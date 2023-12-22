
#################################################################################################################################
outlier_corretion <- function(series,cval){
  #It require only series, considers monthly data
  #Return adjusted series and level shift if LS corrected
  
  data.ts<-ts(series,frequency=12)
  level_shifting<- 0
  trial<-try({
    data.ts.outliers <- tso(data.ts, cval = cval,types = c("AO","LS"))
    
    #getting the level shift
    
    for (i in 1:nrow(data.ts.outliers$outliers)){
      if(data.ts.outliers$outliers$type[i]=='LS') level_shifting= data.ts.outliers$outliers$coefhat[i]
    }
  })
  
  if(class(trial)=="try-error") results<- list(series,level_shifting)  else results<-list(as.numeric(data.ts.outliers$yadj),level_shifting)
  
  return(results)
}
#################################################################################################################################
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
#################################################################################################################################
NNETR_Model<- function(Training_data, season_parameter, Forecast_horizon)
{
  trial<-try({
    Training_data<-ts(Training_data[,2], frequency =  season_parameter)
    fit_ets<-nnetar(Training_data) 
    #prediction
    sales_pred <- forecast(fit_ets, h=Forecast_horizon)
    forecast_results<-as.numeric(sales_pred$mean)
    forecast_results[ forecast_results < 0] <- 0
  })
  
  if(class(trial)=="try-error")  forecast_results<-rep(0,Forecast_horizon)
  return(forecast_results)
}
#-----------------------------------------------------------------------------------------------------------------
HoltWinter_Model<- function(Training_data, season_parameter, Forecast_horizon)
{
  trial<-try({
    Training_data<-ts(Training_data[,2], frequency =  season_parameter)
    fit_ets<-HoltWinters(Training_data) 
    #prediction
    sales_pred <- forecast(fit_ets, h=Forecast_horizon)
    forecast_results<-as.numeric(sales_pred$mean)
    forecast_results[ forecast_results < 0] <- 0
  })
  
  if(class(trial)=="try-error")  forecast_results<-rep(0,Forecast_horizon)
  return(forecast_results)
}
#------------------------------------------------------------------------------------------------------------------------
#Snaive Model
Snaive_Model<- function(Training_data, season_parameter, Forecast_horizon)
{
  trial<-try({
    Training_data<-ts(Training_data[,2], frequency =  season_parameter)
    model<- snaive(Training_data, h=Forecast_horizon)
    forecast_results<-as.numeric( model$mean)
    forecast_results[ forecast_results < 0] <- 0
  })
  
  if(class(trial)=="try-error")  forecast_results<-rep(0,Forecast_horizon)
  return(forecast_results)
}
#------------------------------------------------------------------------------------------------------------------------
#Snaive Model
Naive_Model<- function(Training_data, season_parameter, Forecast_horizon)
{
  trial<-try({
    Training_data<-ts(Training_data[,2], frequency =  season_parameter)
    model<- naive(Training_data, h=Forecast_horizon)
    forecast_results<-as.numeric(model$mean)
    forecast_results[ forecast_results < 0] <- 0
  })
  
  if(class(trial)=="try-error")  forecast_results<-rep(0,Forecast_horizon)
  return(forecast_results)
}
#------------------------------------------------------------------------------------------------------------------------
#BSTS Model
BSTS_Model<- function(Training_data, season_parameter, Forecast_horizon)
{
  trial<-try({
    ynoI <- Training_data[,2]
    ssnoI <- AddLocalLinearTrend(list(), ynoI) 
    ssnoI <- AddSeasonal(ssnoI,ynoI, nseasons = season_parameter, season.duration = 1)
    modelnoI <- bsts(ynoI, state.specification = ssnoI, niter =1000)
    prediction<-predict(modelnoI, h=12)
    forecast_results<-as.numeric(prediction$mean)
    forecast_results[ forecast_results < 0] <- 0
  })
  
  if(class(trial)=="try-error")  forecast_results<-rep(0,Forecast_horizon)
  return(forecast_results)
}
#------------------------------------------------------------------------------------------------------
#BATS Model
BATS_Model<- function(Training_data, season_parameter, Forecast_horizon)
{
  trial<-try({
    Training_data<-ts(Training_data[,2], frequency =  season_parameter)
    fit_ets<-bats(Training_data) 
    #prediction
    sales_pred <- forecast(fit_ets, h=Forecast_horizon)
    forecast_results<-as.numeric(sales_pred$mean) 
    forecast_results[ forecast_results < 0] <- 0
  })
  
  if(class(trial)=="try-error")  forecast_results<-rep(0,Forecast_horizon)
  return(forecast_results)
}
#-----------------------------------------------------------------------------------------
#BATS Model
fboost_Model<- function(Training_data, season_parameter, Forecast_horizon)
{
  trial<-try({
    Training_data<-ts(Training_data[,2], frequency =  season_parameter)
    fit_ets<-xgbar(Training_data)
     #prediction
    sales_pred <- forecast(fit_ets, h=Forecast_horizon)
    forecast_results<-as.numeric(sales_pred$mean) 
    forecast_results[ forecast_results < 0] <- 0
  })
  
  if(class(trial)=="try-error")  forecast_results<-rep(0,Forecast_horizon)
  return(forecast_results)
}
#-------------------------------------------------------------------------------------------------------
#TBATS Model
TBATS_Model<- function(Training_data, season_parameter, Forecast_horizon)
{
  trial<-try({
    Training_data<-ts(Training_data[,2], frequency =  season_parameter)
    fit_ets<-tbats(Training_data) 
    #prediction
    sales_pred <- forecast(fit_ets, h=Forecast_horizon)
    forecast_results<-as.numeric(sales_pred$mean) 
    forecast_results[ forecast_results < 0] <- 0
  })
  
  if(class(trial)=="try-error")  forecast_results<-rep(0,Forecast_horizon)
  return(forecast_results)
}
#---------------------------------------------------------------------------------------------------------
#MAPA Model
MAPA_Model<- function(Training_data, season_parameter, Forecast_horizon)
{
  trial<-try({
    Training_data<-ts(Training_data[,2], frequency =  season_parameter)
    fit_mapa<- mapaest( Training_data)
    future_value<-mapafor( Training_data, fit_mapa,fh=Forecast_horizon)
    forecast_results<-as.numeric(future_value$outfor) 
    forecast_results[ forecast_results < 0] <- 0
  })
  
  if(class(trial)=="try-error")  forecast_results<-rep(0,Forecast_horizon)
  return(forecast_results)
}
#---------------------------------------------------------------------------------------------------------
STLF_Model<- function(Training_data, season_parameter, Forecast_horizon)
{
  trial<-try({
    Training_data<-ts(Training_data[,2], frequency =  season_parameter)
    fit_stl<-stlf( Training_data)
    future_value<-forecast(fit_stl,h=Forecast_horizon)
    forecast_results<-as.numeric(future_value$mean) 
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
#---------------------------------------------------------------------------------------------------------
#State Space Model
SS_Model<- function(Training_data, season_parameter, Forecast_horizon)
{
  trial<-try({
    Training_data<-ts(Training_data[,2], frequency =  season_parameter)
    ss_model <- forecast(StructTS(Training_data), h=Forecast_horizon)
    forecast_results<-as.numeric(ss_model$mean)
    forecast_results[ forecast_results < 0] <- 0
  })
  
  if(class(trial)=="try-error")  forecast_results<-rep(0,Forecast_horizon)
  return(forecast_results)
}

#------------------------------------------------------------------------------------------------------------------------
#THeta Model
Theta_Model<- function(Training_data, season_parameter, Forecast_horizon)
{
  trial<-try({
    Training_data<-ts(Training_data[,2], frequency =  season_parameter)
    out2 <- stheta(y=Training_data, h=Forecast_horizon)
    forecast_results<-as.numeric( out2$mean)
    forecast_results[ forecast_results < 0] <- 0
  })
  
  if(class(trial)=="try-error")  forecast_results<-rep(0,Forecast_horizon)
  return(forecast_results)
}
#------------------------------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------------
#Forecast Combination
combine_forecast<- function(series,training_data,all_forecast_temp,
                            all_forecast_previous,Forecast_horizon,check_points, error_method, weight_method){
  last_month<-max(training_data$Date)  
  Forecast_To<-seq(from=last_month,length= Forecast_horizon+1,by="quarter")[2:( Forecast_horizon+1)]
  comb_forecast<-NULL
  
  for(h in 1:Forecast_horizon)
  {
    #calculate weight
    temp_forecast=  subset(all_forecast_previous,horizon==h)
    forecast_single_horizon<-cast(temp_forecast, Forecast_From+Forecast_To+horizon+Series~Type, sum,  value = 'value') 
    test_actual_data<- merge(training_data, forecast_single_horizon, by.y=c('Forecast_To'), by.x=c('Date'))
    if(nrow(test_actual_data)>check_points) {
      start= nrow( test_actual_data)-check_points+1
      end= nrow( test_actual_data)
      test_actual_data<-  test_actual_data[start:end,]
    }
    store_error<- NULL
    for(k in 6:ncol( test_actual_data))
    {
      if(error_method=="Symetric") {
        error= mean(2*abs((test_actual_data[,2]- test_actual_data[,k]))/(test_actual_data[,2]+test_actual_data[,k])) 
        error_variance = sd(2*abs((test_actual_data[,2]- test_actual_data[,k]))/(test_actual_data[,2]+test_actual_data[,k])) 
      } else {
        error= mean(abs((test_actual_data[,2]- test_actual_data[,k])/test_actual_data[,2]))
        error_variance =  sd(abs((test_actual_data[,2]- test_actual_data[,k])/test_actual_data[,2]))
      }
      error= data.frame(model= colnames(test_actual_data)[k], error=error, error_variance)
      
      store_error<-rbind( store_error, error)
    }
    if (weight_method=="standard") {
      store_error$inverse_error<- (1/store_error$error)+(1/store_error$error_variance)
    } else 
      store_error$inverse_error<- (1/store_error$error)
   
    store_error$weight_model<- store_error$inverse_error/sum(store_error$inverse_error)
    
    #combined_weights<-Forecast_comb(test_actual_data$value,as.matrix( test_actual_data[,6:ncol( test_actual_data)]),
    #                                Averaging_scheme= c("variance based"))
    #Combined Forecast
    temp_forecast_new=  subset(all_forecast_temp,horizon==h)
    forecast_single_horizon_new<-cast( temp_forecast_new, Forecast_From+Forecast_To+horizon+Series~Type,sum,  value = 'value') 
    #comb_fore<-as.matrix(forecast_single_horizon_new[,5:ncol(forecast_single_horizon)]) %*% as.matrix(combined_weights$weights)
    comb_fore<-as.matrix(forecast_single_horizon_new[,5:ncol(forecast_single_horizon)]) %*% as.matrix(store_error$weight_model)
    comb_forecast<-rbind(comb_forecast, data.frame(Series=series, Forecast_From=last_month,Forecast_To=Forecast_To[h],horizon=h,
                                                   Type=paste("Combined","all",error_method,weight_method,sep="_"),
                                                   value=as.numeric(comb_fore)))
  }
  return(comb_forecast)
}

#Forecast Combination
combine_forecast_cv<- function(series,training_data,all_forecast_temp,
                                   all_forecast_previous,Forecast_horizon,check_points, error_method, weight_method){
  last_month<-max(training_data$Date)  
  Forecast_To<-seq(from=last_month,length= Forecast_horizon+1,by="quarter")[2:( Forecast_horizon+1)]
  comb_forecast<-NULL
  
  for(h in 1:Forecast_horizon)
  {
    #calculate weight
    temp_forecast=  subset(all_forecast_previous,horizon==h)
    forecast_single_horizon<-cast(temp_forecast, Forecast_From+Forecast_To+horizon+Series~Type, sum,  value = 'value') 
    test_actual_data<- merge(training_data, forecast_single_horizon, by.y=c('Forecast_To'), by.x=c('Date'))
    if(nrow(test_actual_data)>check_points) {
      start= nrow( test_actual_data)-check_points+1
      end= nrow( test_actual_data)
      test_actual_data<-  test_actual_data[start:end,]
    }
    store_error<- NULL
    for(k in 6:ncol( test_actual_data))
    {
      if(error_method=="Symetric") {
        error= mean(2*abs((test_actual_data[,2]- test_actual_data[,k]))/(test_actual_data[,2]+test_actual_data[,k])) 
        error_variance = sd(2*abs((test_actual_data[,2]- test_actual_data[,k]))/(test_actual_data[,2]+test_actual_data[,k])) 
      } else {
        error= median(abs((test_actual_data[,2]- test_actual_data[,k])/test_actual_data[,2]))
        error_variance =  sd(abs((test_actual_data[,2]- test_actual_data[,k])/test_actual_data[,2]))
      }
      error= data.frame(model= colnames(test_actual_data)[k], error=error, error_variance)
      
      store_error<-rbind( store_error, error)
    }
    if (weight_method=="standard") {
      store_error$inverse_error<- 1/(store_error$error/store_error$error_variance)
    } else 
      store_error$inverse_error<- (1/store_error$error)
    
    store_error$weight_model<- store_error$inverse_error/sum(store_error$inverse_error)
    
    #combined_weights<-Forecast_comb(test_actual_data$value,as.matrix( test_actual_data[,6:ncol( test_actual_data)]),
    #                                Averaging_scheme= c("variance based"))
    #Combined Forecast
    temp_forecast_new=  subset(all_forecast_temp,horizon==h)
    forecast_single_horizon_new<-cast( temp_forecast_new, Forecast_From+Forecast_To+horizon+Series~Type,sum,  value = 'value') 
    #comb_fore<-as.matrix(forecast_single_horizon_new[,5:ncol(forecast_single_horizon)]) %*% as.matrix(combined_weights$weights)
    comb_fore<-as.matrix(forecast_single_horizon_new[,5:ncol(forecast_single_horizon)]) %*% as.matrix(store_error$weight_model)
    comb_forecast<-rbind(comb_forecast, data.frame(Series=series, Forecast_From=last_month,Forecast_To=Forecast_To[h],horizon=h,
                                                   Type=paste("Combined","all",error_method,weight_method,sep="_"),
                                                   value=as.numeric(comb_fore)))
  }
  return(comb_forecast)
}

#Forecast Combination
combine_forecast_median<- function(series,training_data,all_forecast_temp,
                            all_forecast_previous,Forecast_horizon,check_points, error_method, weight_method){
  last_month<-max(training_data$Date)  
  Forecast_To<-seq(from=last_month,length= Forecast_horizon+1,by="quarter")[2:( Forecast_horizon+1)]
  comb_forecast<-NULL
  
  for(h in 1:Forecast_horizon)
  {
    #calculate weight
    temp_forecast=  subset(all_forecast_previous,horizon==h)
    forecast_single_horizon<-cast(temp_forecast, Forecast_From+Forecast_To+horizon+Series~Type, sum,  value = 'value') 
    test_actual_data<- merge(training_data, forecast_single_horizon, by.y=c('Forecast_To'), by.x=c('Date'))
    if(nrow(test_actual_data)>check_points) {
      start= nrow( test_actual_data)-check_points+1
      end= nrow( test_actual_data)
      test_actual_data<-  test_actual_data[start:end,]
    }
    store_error<- NULL
    for(k in 6:ncol( test_actual_data))
    {
      if(error_method=="Symetric") {
        error= median(2*abs((test_actual_data[,2]- test_actual_data[,k]))/(test_actual_data[,2]+test_actual_data[,k])) 
        error_variance = sd(2*abs((test_actual_data[,2]- test_actual_data[,k]))/(test_actual_data[,2]+test_actual_data[,k])) 
      } else {
        error= median(abs((test_actual_data[,2]- test_actual_data[,k])/test_actual_data[,2]))
        error_variance =  sd(abs((test_actual_data[,2]- test_actual_data[,k])/test_actual_data[,2]))
      }
      error= data.frame(model= colnames(test_actual_data)[k], error=error, error_variance)
      
      store_error<-rbind( store_error, error)
    }
    if (weight_method=="standard") {
      store_error$inverse_error<- (1/store_error$error)+(1/store_error$error_variance)
    } else 
      store_error$inverse_error<- (1/store_error$error)
    
    store_error$weight_model<- store_error$inverse_error/sum(store_error$inverse_error)
    
    #combined_weights<-Forecast_comb(test_actual_data$value,as.matrix( test_actual_data[,6:ncol( test_actual_data)]),
    #                                Averaging_scheme= c("variance based"))
    #Combined Forecast
    temp_forecast_new=  subset(all_forecast_temp,horizon==h)
    forecast_single_horizon_new<-cast( temp_forecast_new, Forecast_From+Forecast_To+horizon+Series~Type,sum,  value = 'value') 
    #comb_fore<-as.matrix(forecast_single_horizon_new[,5:ncol(forecast_single_horizon)]) %*% as.matrix(combined_weights$weights)
    comb_fore<-as.matrix(forecast_single_horizon_new[,5:ncol(forecast_single_horizon)]) %*% as.matrix(store_error$weight_model)
    comb_forecast<-rbind(comb_forecast, data.frame(Series=series, Forecast_From=last_month,Forecast_To=Forecast_To[h],horizon=h,
                                                   Type=paste("Combined","all",error_method,weight_method,sep="_"),
                                                   value=as.numeric(comb_fore)))
  }
  return(comb_forecast)
}
#Forecast Combination
combine_forecast_min<- function(series,training_data,all_forecast_temp,
                                all_forecast_previous,Forecast_horizon,check_points,error_method){
  last_month<-max(training_data$Date)  
  Forecast_To<-seq(from=last_month,length= Forecast_horizon+1,by="quarter")[2:( Forecast_horizon+1)]
  comb_forecast<-NULL
  
  for(h in 1:Forecast_horizon)
  {
    #calculate weight
    temp_forecast=  subset(all_forecast_previous,horizon==h)
    forecast_single_horizon<-cast(temp_forecast, Forecast_From+Forecast_To+horizon+Series~Type, sum,  value = 'value') 
    test_actual_data<- merge(training_data, forecast_single_horizon, by.y=c('Forecast_To'), by.x=c('Date'))
    if(nrow(test_actual_data)>check_points) {
      start= nrow( test_actual_data)-check_points+1
      end= nrow( test_actual_data)
      test_actual_data<-  test_actual_data[start:end,]
    }
    store_error<- NULL
    for(k in 6:ncol( test_actual_data))
    {
      if(error_method=="Symetric") {
        error= mean(2*abs((test_actual_data[,2]- test_actual_data[,k]))/(test_actual_data[,2]+test_actual_data[,k])) 
      } else error= mean(abs((test_actual_data[,2]- test_actual_data[,k])/test_actual_data[,2]))
      
      error= data.frame(model= colnames(test_actual_data)[k], error=error)
      store_error<-rbind( store_error, error)
    }
    store_error$inverse_error<- 1/store_error$error
    #store_error$weight_model<- store_error$inverse_error/sum(store_error$inverse_error)
    
    store_error<-store_error[store_error$error==min(store_error$error),]
    #combined_weights<-Forecast_comb(test_actual_data$value,as.matrix( test_actual_data[,6:ncol( test_actual_data)]),
    #                                Averaging_scheme= c("variance based"))
    #Combined Forecast
    temp_forecast_new=  subset(all_forecast_temp,horizon==h)
    #forecast_single_horizon_new<-cast( temp_forecast_new, Forecast_From+Forecast_To+horizon+Series~Type,sum,  value = 'value') 
    #comb_fore<-as.matrix(forecast_single_horizon_new[,5:ncol(forecast_single_horizon)]) %*% as.matrix(combined_weights$weights)
    #comb_fore<-as.matrix(forecast_single_horizon_new[,5:ncol(forecast_single_horizon)]) %*% as.matrix(store_error$weight_model)
    comb_fore<- subset(temp_forecast_new,Type==store_error$model)$value
    comb_forecast<-rbind(comb_forecast, data.frame(Series=series, Forecast_From=last_month,Forecast_To=Forecast_To[h],horizon=h,
                                                   Type=paste("Combined","min",error_method,sep="_"),
                                                   value=as.numeric(comb_fore)))
  }
  return(comb_forecast)
}
#-------------------------------------------------------------------------------------------------------------
#Forecast Combination
combine_forecast_old<- function(series,training_data,all_forecast_temp,all_forecast_previous,Forecast_horizon,check_points){
  last_month<-max(training_data$Date)  
  Forecast_To<-seq(from=last_month,length= Forecast_horizon+1,by="quarter")[2:( Forecast_horizon+1)]
  comb_forecast<-NULL
  
  for(h in 1:Forecast_horizon)
  {
    #calculate weight
    temp_forecast=  subset(all_forecast_previous,horizon==h)
    forecast_single_horizon<-cast(temp_forecast, Forecast_From+Forecast_To+horizon+Series~Type, sum,  value = 'value') 
    test_actual_data<- merge(training_data, forecast_single_horizon, by.y=c('Forecast_To'), by.x=c('Date'))
    if(nrow(test_actual_data)>check_points) {
      start= nrow( test_actual_data)-check_points+1
      end= nrow( test_actual_data)
      test_actual_data<-  test_actual_data[start:end,]
    }
    combined_weights<-Forecast_comb(test_actual_data$value,as.matrix( test_actual_data[,6:ncol( test_actual_data)]),
                                    Averaging_scheme= c("variance based"))
    #Combined Forecast
    temp_forecast_new=  subset(all_forecast_temp,horizon==h)
    forecast_single_horizon_new<-cast( temp_forecast_new, Forecast_From+Forecast_To+horizon+Series~Type,sum,  value = 'value') 
    comb_fore<-as.matrix(forecast_single_horizon_new[,5:ncol(forecast_single_horizon)]) %*% as.matrix(combined_weights$weights)
    comb_forecast<-rbind(comb_forecast, data.frame(Series=series, Forecast_From=last_month,Forecast_To=Forecast_To[h],horizon=h,
                                                   Type="Combined",
                                                   value=as.numeric(comb_fore)))
  }
  return(comb_forecast)
}
#-----------------------------------------------------------------------------------------------------------------
