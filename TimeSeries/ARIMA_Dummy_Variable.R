#Function for Arima Model with dummy variables
Arima_Model_Dummy_Variable<-function(training_data, input_variables, target, Forecast_horizon)
{
  training_data <- training_data[order(training_data$Date),] 
  time_series_data<-ts(training_data[target], frequency =  1)
  library(forecast)
  
  last_month<-max(training_data$Date)
  dates<-seq(last_month,length= Forecast_horizon+1,by="month")[2:(Forecast_horizon+1)]
  dates<-data.frame(dates)
  dates$Month<- format(dates$dates,"%m")
  trial<-try({
    arima_model<-auto.arima(time_series_data, xreg = training_data[input_variables])
    #create dummy variable for months
    dates$Jan<-ifelse(dates$Month=="01", 1,0)
    dates$Feb<-ifelse(dates$Month=="02", 1,0)
    dates$Mar<-ifelse(dates$Month=="03", 1,0)
    dates$Apr<-ifelse(dates$Month=="04", 1,0)
    dates$May<-ifelse(dates$Month=="05", 1,0)
    dates$Jun<-ifelse(dates$Month=="06", 1,0)
    dates$Jul<-ifelse(dates$Month=="07", 1,0)
    dates$Aug<-ifelse(dates$Month=="08", 1,0)
    dates$Sep<-ifelse(dates$Month=="09", 1,0)
    dates$Oct<-ifelse(dates$Month=="10", 1,0)
    dates$Nov<-ifelse(dates$Month=="11", 1,0)
    
    forecated_values<-forecast(arima_model, xreg=dates[input_variables],level = 90)
    
  })
  
  if(class(trial)=="try-error"){
    forecast_results<-data.frame(ForecastedFrom= last_month,ForecastedTo=dates$dates,horizon=1:Forecast_horizon,
                                 Value=NA)
  }else
  {forecast_results<-data.frame(ForecastedFrom= last_month,ForecastedTo=dates$dates,horizon=1:Forecast_horizon,
                                Value=as.numeric(forecated_values$mean))}
  return(forecast_results)
}

#Forecast
testEnd <- length(Month_year)
testBegin <- testEnd-23
horizon=12
business_unit_name<-unique(Business.unit_aggregate_EUR1$Business.unit)
rm(all_forecast)
for(k in business_unit_name)
{
  Business_unit_data<-subset(Business.unit_aggregate_EUR1,Business.unit==k)
  for(j in testBegin:testEnd)
    {
      print(paste("Business unit=",k,"test", j))
      training_data<-subset(Business_unit_data, Date<=Month_year[j])
      target<-"EUR"
      input_variables<-c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov")
      model_forecast<-Arima_Model_Dummy_Variable(training_data,input_variables, target, horizon)
      forecast_results<-data.frame(Business.unit=k,Type="ARIMA", model_forecast)
      if(!exists("all_forecast"))all_forecast <- forecast_results else all_forecast <- rbind(all_forecast,forecast_results)
  }  
  
  #extract True values
  True_values<-data.frame(Business.unit=k,Type="Truth",ForecastedFrom=Business_unit_data$Date,
                          ForecastedTo=Business_unit_data$Date,horizon=0, 
                          Value=Business_unit_data$EUR)  
  
  if(!exists("all_forecast"))all_forecast <- True_values else all_forecast<-rbind(all_forecast,True_values)
}