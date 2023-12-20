#Arima Model
Arima_Model<- function(Training_data, season_parameter, Forecast_horizon)
{
  trial<-try({
    Training_data<-ts(Training_data[,2], frequency =  season_parameter)
    fit_ets<-auto.arima(Training_data) 
    #prediction
    sales_pred <- forecast(fit_ets, h=Forecast_horizon)
    forecast_results<-as.numeric(sales_pred$mean)
    forecast_results[ forecast_results < 0] <- 0
  })
  
  if(class(trial)=="try-error")  forecast_results<-rep(0,Forecast_horizon)
  return(forecast_results)
}

#------------------------------------------------------------------------------------------------------------------------
ETS_Model<- function(Training_data, season_parameter, Forecast_horizon)
{
  trial<-try({
    Training_data<-ts(Training_data[,2], frequency =  season_parameter)
    fit_ets<-ets(Training_data, model="ZZZ") 
    #prediction
    sales_pred <- forecast(fit_ets, h=Forecast_horizon)
    forecast_results<-as.numeric(sales_pred$mean)
    forecast_results[ forecast_results < 0] <- 0
  })
  
  if(class(trial)=="try-error")  forecast_results<-rep(0,Forecast_horizon)
  return(forecast_results)
}

#----------------------------------------------------------------------------------------------------------------------------------

library(forecast)
library(lubridate)
library(zoo)

data<-read.csv("APUMP_Data.csv")
data$Date<- as.Date(paste('01',data$Month), format='%d %b-%y')

#setting of parameters for Rolling Forecast
test_begin=52
test_end= nrow(df)
forecast_horizon=12
all_forecast<-NULL

#Rolling Forecast
for(i in test_begin:test_end)
{ 
    train_data= df[1:i,]
    train_data<-train_data[c('Date',"Actual_Inwarding")]
    
    #creation of future Dates
    last_month<-max( train_data$Date)  
    Forecast_To<-seq(from=last_month,length= forecast_horizon+1,by="month")[2:( forecast_horizon+1)]
    
    #forecasting using Exponential Smoothing Model
    ets_forecast<- data.frame(Forecast_From=last_month,Forecast_To,horizon=1:forecast_horizon, Type="ETS",
                              Sales=ETS_Model(train_data,12,forecast_horizon))
    
    #forecasting Using ARIMA Model
    arima_forecast<- data.frame(Forecast_From=last_month,Forecast_To,horizon=1:forecast_horizon, Type="ARIMA",
                                Sales=Arima_Model(train_data,12,forecast_horizon))
   all_forecast<-rbind(all_forecast,ets_forecast,arima_forecast)
  
}

true_values<-data.frame(Forecast_From=data$Date,Forecast_To=data$Date,
                          horizon=0,Type="Truth",Sales= data$Actual_Inwarding)
  
all_forecast<- rbind(all_forecast,true_values)
  
write.csv(all_forecast,"all_forecast.csv", row.names = FALSE)









