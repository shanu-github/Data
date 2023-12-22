library(reshape)
library(lubridate)
library(forecast)
library(bsts)
library(forecTheta)
library(MAPA)
library(forecastxgb)
library(ForecastCombinations)
library(doParallel)
library(foreach)
source("C:/Work/Forecasting/Forecast_Paper/Required_Functions.R")

cores <- detectCores(logical = FALSE)
cores=4
c1 = makeCluster(cores)
registerDoParallel(c1, cores= cores)

m3_data<- read.csv("C:/Work/Forecasting/Forecast_Paper/Copy of M3C.csv", stringsAsFactors = FALSE)
m3_data<- melt(m3_data, id=c("Series", "N", "NF","Category","Starting.Year","Starting.Month")) 
m3_data$Series_name<- paste(m3_data$Series,m3_data$Category, sep="_")
m3_data[m3_data$Starting.Year==0,"Starting.Year"]<-1990
m3_data[m3_data$Starting.Month==0,"Starting.Month"]<-1

m3_data$start_date<- ymd(paste(m3_data$Starting.Year,m3_data$Starting.Month,'01',sep="-"))
#m3_data<-m3_data[m3_data$Series!="OTHER       ",]

m3_data<- m3_data[c('Series_name','value','start_date')]

unique_series= unique(m3_data$Series_name)
Forecast_horizon=18
all_series_forecast=NULL
count=0
f1<-function(series)
{
  #count=count+1
  #print(count)
  #print(series)
  source("C:/Work/Forecasting/Forecast_Paper/Required_Functions.R")
  series_data= subset(m3_data, Series_name==series)
  series_data<-  series_data[complete.cases(series_data),]
  date_genearte<- seq(from=series_data$start_date[1],length= nrow(series_data),by="month")
  series_train_data<- data.frame(Date= date_genearte,value=series_data$value)
  test_end= nrow(series_train_data)-18
  test_begin= test_end-25
  #combine_begin= test_begin+13
  final_forecast<-NULL
  all_forecast<-NULL
  for(i in test_begin:test_end)
  {
    temp_train_data=  series_train_data[1:i,]
    last_month<-max(temp_train_data$Date)  
    Forecast_To<-seq(from=last_month,length= Forecast_horizon+1,by="month")[2:( Forecast_horizon+1)]
    
    ets_forecast<- data.frame(Forecast_From=last_month,Forecast_To,horizon=1:Forecast_horizon, Type="ETS",
                              value=ETS_Model(temp_train_data,12,Forecast_horizon))
    arima_forecast<-data.frame(Forecast_From=last_month,Forecast_To,horizon=1:Forecast_horizon,Type="ARIMA",
                               value=Arima_Model(temp_train_data,12,Forecast_horizon))
    stl_forecast<- data.frame(Forecast_From=last_month,Forecast_To,horizon=1:Forecast_horizon,Type="STL",
                              value= STLF_Model(temp_train_data,12,Forecast_horizon)) 
    theta_forecast<- data.frame(Forecast_From=last_month,Forecast_To,horizon=1:Forecast_horizon,Type="THETA",
                                value=Theta_Model(temp_train_data,12,Forecast_horizon)) 
    
    snaive_forecast<- data.frame(Forecast_From=last_month,Forecast_To,horizon=1:Forecast_horizon,Type="SNAIVE",
                                 value=Snaive_Model(temp_train_data,12,Forecast_horizon)) 
    naive_forecast<- data.frame(Forecast_From=last_month,Forecast_To,horizon=1:Forecast_horizon,Type="NAIVE",
                                value= Naive_Model(temp_train_data,12,Forecast_horizon)) 
    
    merge_forecast= rbind(ets_forecast,arima_forecast, stl_forecast, 
                          theta_forecast,snaive_forecast,naive_forecast)
    merge_forecast$Series= series
    all_forecast= rbind(all_forecast,merge_forecast)
    if(i==test_end)
    {
      all_forecast_previous=all_forecast[all_forecast$Type!="Combined",] 
      previous_forecast<- subset(all_forecast_previous, Forecast_From < last_month)
      current_forecast<- subset(all_forecast_previous, Forecast_From== last_month)
      #comb_fore<-combine_forecast(series,series_data,current_forecast,previous_forecast,Forecast_horizon,check_points)
      comb_fore1<-combine_forecast_min(series,temp_train_data,current_forecast,previous_forecast,
                                       Forecast_horizon,check_points=6,error_method="Symetric")
      comb_fore2<-combine_forecast_min(series,temp_train_data,current_forecast,previous_forecast,
                                       Forecast_horizon,check_points=6,error_method="MAPE")
      comb_fore3<-combine_forecast(series,temp_train_data,current_forecast,previous_forecast,
                                   Forecast_horizon,check_points=6,error_method="Symetric")
      comb_fore4<-combine_forecast(series,temp_train_data,current_forecast,previous_forecast,
                                   Forecast_horizon,check_points=6,error_method="MAPE")
      comb_fore<-rbind(comb_fore1,comb_fore2,comb_fore3, comb_fore4)
      final_forecast= rbind(final_forecast,merge_forecast,comb_fore)
      #return(final_forecast)
    }
    
  }
  
  true_data<- data.frame(Series=series, Forecast_From=series_train_data$Date,Forecast_To=series_train_data$Date,
                         horizon=0, Type="Truth", value=series_train_data$value)
  final_forecast= rbind(final_forecast, true_data)
  return(final_forecast)
}

all_series_forecast<- foreach(series=unique_series, .combine=rbind,
               .packages = c('forecast','reshape')) %dopar% { f1(series)}

#true value
true_data<- subset(all_series_forecast,Type=="Truth" )
true_data<-true_data[,c("Forecast_To","value","Series" )]
colnames(true_data)<- c("Forecast_To","True_value","Series")

all_series_forecast1<-merge( all_series_forecast,true_data, by= c("Forecast_To","Series"),  all.x =TRUE)


write.csv( all_series_forecast1,"C:/Work/Forecasting/Forecast_Paper/forecast_result.csv", row.names = FALSE)
