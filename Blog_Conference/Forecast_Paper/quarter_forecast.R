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
source("C:/Work/Forecasting/Forecast_Paper/Required_Functions_quarter.R")

m3_data<- read.csv("C:/Work/Forecasting/Forecast_Paper/Quarter_data.csv", stringsAsFactors = FALSE)
m3_data<- melt(m3_data, id=c("Series", "N", "NF","Category","Starting.Year","Starting.Quarter")) 
##m3_data<- subset(m3_data, Category=="FINANCE     " )
m3_data$Series_name<- paste(m3_data$Series,m3_data$Category, sep="_")
m3_data[m3_data$Starting.Year==0,"Starting.Year"]<-1990
m3_data[m3_data$Starting.Quarter==0,"Starting.Quarter"]<-1

m3_data$start_date<- ymd(paste(m3_data$Starting.Year,m3_data$Starting.Quarter,'01',sep="-"))
#m3_data<-m3_data[m3_data$Series=="Industry       ",]

m3_data<- m3_data[c('Series_name','value','start_date')]

unique_series= unique(m3_data$Series_name)
Forecast_horizon=8
all_series_forecast=NULL
count=0
season= 4
check_points=4
for(series in unique_series)
{
  count=count+1
  print(count)
  #print(series)
  series_data= subset(m3_data, Series_name==series)
  series_data<-  series_data[complete.cases(series_data),]
  #date_genearte<- seq(from=series_data$start_date[1],length= nrow(series_data),by="month")
  date_genearte<- seq(from=series_data$start_date[1],length= nrow(series_data),by="quarter")
  series_train_data<- data.frame(Date= date_genearte,value=series_data$value)
  test_end= nrow(series_train_data)-8
  test_begin= test_end-12
  #combine_begin= test_begin+13
  final_forecast<-NULL
  all_forecast<-NULL
  for(i in test_begin:test_end)
  {
    temp_train_data=  series_train_data[1:i,]
    last_month<-max(temp_train_data$Date)  
    Forecast_To<-seq(from=last_month,length= Forecast_horizon+1,by="quarter")[2:( Forecast_horizon+1)]
    
    ets_forecast<- data.frame(Forecast_From=last_month,Forecast_To,horizon=1:Forecast_horizon, Type="ETS",
                              value=ETS_Model(temp_train_data,season,Forecast_horizon))
    arima_forecast<-data.frame(Forecast_From=last_month,Forecast_To,horizon=1:Forecast_horizon,Type="ARIMA",
                               value=Arima_Model(temp_train_data,season,Forecast_horizon))
    stl_forecast<- data.frame(Forecast_From=last_month,Forecast_To,horizon=1:Forecast_horizon,Type="STL",
                             value= STLF_Model(temp_train_data,season,Forecast_horizon)) 
    theta_forecast<- data.frame(Forecast_From=last_month,Forecast_To,horizon=1:Forecast_horizon,Type="THETA",
                                value=Theta_Model(temp_train_data,season,Forecast_horizon)) 
    # hw_forecast<- data.frame(Forecast_From=last_month,Forecast_To,horizon=1:Forecast_horizon,Type="HW",
    #                         value=HoltWinter_Model(temp_train_data,12,Forecast_horizon)) 
    snaive_forecast<- data.frame(Forecast_From=last_month,Forecast_To,horizon=1:Forecast_horizon,Type="SNAIVE",
                                 value=Snaive_Model(temp_train_data,season,Forecast_horizon)) 
    naive_forecast<- data.frame(Forecast_From=last_month,Forecast_To,horizon=1:Forecast_horizon,Type="NAIVE",
                                value= Naive_Model(temp_train_data,season,Forecast_horizon)) 
    
    merge_forecast= rbind(ets_forecast,arima_forecast,theta_forecast,snaive_forecast,naive_forecast, stl_forecast)
    merge_forecast$Series= series
    all_forecast= rbind(all_forecast,merge_forecast)
    if(i==test_end)
    {
      all_forecast_previous=all_forecast[all_forecast$Type!="Combined",] 
      previous_forecast<- subset(all_forecast_previous, Forecast_From < last_month)
      current_forecast<- subset(all_forecast_previous, Forecast_From== last_month)
      #comb_fore<-combine_forecast(series,series_data,current_forecast,previous_forecast,Forecast_horizon,check_points)
      #comb_fore1<-combine_forecast_min(series,temp_train_data,current_forecast,previous_forecast,
      #                            Forecast_horizon,check_points,error_method="Symetric")
      #comb_fore2<-combine_forecast_min(series,temp_train_data,current_forecast,previous_forecast,
      #                                Forecast_horizon,check_points=6,error_method="MAPE")
      comb_fore3<-combine_forecast(series,temp_train_data,current_forecast,previous_forecast,
                                   Forecast_horizon,check_points,error_method="Symetric",weight_method="notstandard")
      comb_fore4<-combine_forecast(series,temp_train_data,current_forecast,previous_forecast,
                                   Forecast_horizon,check_points,error_method="MAPE",weight_method="notstandard")
      comb_fore1<-combine_forecast(series,temp_train_data,current_forecast,previous_forecast,
                                   Forecast_horizon,check_points,error_method="Symetric",weight_method="standard")
      comb_fore2<-combine_forecast(series,temp_train_data,current_forecast,previous_forecast,
                                   Forecast_horizon,check_points,error_method="MAPE",weight_method="standard")
      comb_fore5<-combine_forecast_old(series,temp_train_data,current_forecast,previous_forecast,
                                       Forecast_horizon,check_points)
      
      comb_fore6<-combine_forecast_median(series,temp_train_data,current_forecast,previous_forecast,
                                          Forecast_horizon,check_points,error_method="Symetric",weight_method="standard")
      comb_fore6$Type<-"Median_SAPE_stana"
      comb_fore<-rbind(comb_fore1,comb_fore2,comb_fore3, comb_fore4,comb_fore5,comb_fore6)
      final_forecast= rbind(final_forecast,merge_forecast,comb_fore)
      #return(final_forecast)
    }
    
  }
  
  true_data<- data.frame(Series=series, Forecast_From=series_train_data$Date,Forecast_To=series_train_data$Date,
                         horizon=0, Type="Truth", value=series_train_data$value)
  final_forecast= rbind(final_forecast, true_data)
  all_series_forecast<-rbind(all_series_forecast,final_forecast)
}

#true value
true_data<- subset(all_series_forecast,Type=="Truth" )
true_data<-true_data[,c("Forecast_To","value","Series" )]
colnames(true_data)<- c("Forecast_To","True_value","Series")
library(stringr)
all_series_forecast1<-merge( all_series_forecast,true_data, by= c("Forecast_To","Series"),  all.x =TRUE)
column_names<- data.frame(str_split_fixed(all_series_forecast1$Series, "_", 2))
colnames(column_names)<-c("Series_No","Series_Name")
all_series_forecast1<-cbind(all_series_forecast1,column_names)

write.csv( all_series_forecast1,"C:/Work/Forecasting/Forecast_Paper/forecast_result_quarter.csv", row.names = FALSE)
