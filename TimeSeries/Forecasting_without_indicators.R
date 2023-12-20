
#ARIMA Model
ARIMA_forecastFunction<- function(Training_data, Business_Unit, season_parameter, Forecast_horizon)
{
  library(forecast)
  #changing the date format
  #Training_data$Date<-as.yearmon(as.character(Training_data$Date), "%b'%y")
  last_month<-max(Training_data$Date)  
  
  Training_data<-ts(Training_data[,Business_Unit], frequency =  season_parameter)
  fit_ets<-auto.arima(Training_data,stepwise=TRUE) 
  #prediction
  sales_pred <- data.frame(forecast(fit_ets, h=Forecast_horizon))
  Business_unit_forecast<-sales_pred[c("Point.Forecast")]
  
  Forecast_To<-seq(from=last_month,length= Forecast_horizon+1,by="month")[2:( Forecast_horizon+1)]
  Final_forecast_data<-data.frame(Target=Business_Unit, Model="ARIMA",Forecast_From=last_month,
                                  Forecast_To=Forecast_To,
                                  horizon=seq(1,Forecast_horizon,by=1),Forecast=Business_unit_forecast$Point.Forecast)
  return(Final_forecast_data)
}


#Function for Arima Model
Arima_model<-function(training_data, input_variables, target, Forecast_horizon)
{
  library(forecast)
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
    forecast_results<-data.frame(Target=target, Model="ARIMA_Dummy",Forecast_From= last_month,
                                 Forecast_To=dates$dates,horizon=1:Forecast_horizon,
                                 Forecast=NA)
    
    }else
    {forecast_results<-data.frame(Target=target, Model="ARIMA_Dummy",Forecast_From= last_month,
                                  Forecast_To=dates$dates,horizon=1:Forecast_horizon,
                                  Forecast=as.numeric(forecated_values$mean))}
  return(forecast_results)
}

#BSTS Model
BSTS_model<-function(Training_data, Business_Unit, season_parameter, Forecast_horizon)
{
  library(bsts)
  last_month<-max(Training_data$Date)  
  y<-Training_data[,Business_Unit]
  #ssI <- AddLocalLinearTrend(list(), y)
  ssI <- AddSeasonal(list(), y, nseasons = 12, season.duration = 1)
  modelI <- bsts(y , state.specification = ssI,niter =  1000)
  
  ### Get a suggested number of burn-ins
  burn <- SuggestBurn(0.1,  modelI)
  
  predI <- predict(modelI,  burn =  burn , quantiles = c(.1, .90))
  #predI$interval[1,]
  
  Forecast_To<-seq(from=last_month,length= Forecast_horizon+1,by="month")[2:( Forecast_horizon+1)]
 
   Final_forecast_data<-data.frame(Target=Business_Unit, Model="BSTS",Forecast_From=last_month,
                                  Forecast_To=Forecast_To,
                                  horizon=seq(1,Forecast_horizon,by=1),Forecast=predI$mean)
  return(Final_forecast_data)
}

#Lag Creation
indicator_list<-function(training_data,h,past_value)
{
  library(data.table)
  temp<-data.frame(matrix(NA, nrow = h, ncol = ncol(training_data)))
  colnames(temp)<-colnames(training_data)
  temp<-rbind(training_data,temp)
  temp$Date[(nrow(temp)-h+1):nrow(temp)]<- seq(from=max(temp$Date,na.rm=TRUE),length=h+1,by="month")[2:(h+1)]
  
  indicatorsNames<-names(temp)[2:ncol(temp)]
  #rm(final_df2)
  for(k in indicatorsNames)
  {
    n <- past_value+h-1
    df<-data.frame(temp[,k])
    df2<-data.frame(shift(df,h:n))
    df2<-as.data.frame(setDT(df)[, paste(k,"lag", h:n, sep="_") := shift(df,h:n)][])
    if(!exists("final_df2")) final_df2 <-df2[,-1] else final_df2 <- cbind(final_df2,df2[,-1])
    #Google_trends_data<-cbind(Google_trends_data,df2[,-1])
  }
  
  final_df2<-cbind(Date=temp$Date,final_df2)
  
  train_indi_data<- final_df2[(n+1):(nrow(final_df2)-h),]
  test_indi_data<- final_df2[nrow(final_df2),]
  return(list(train_indi_data,test_indi_data))
}

#Linear Regression with separate model
LM_function<-function(training_data,target, past_value , h)
{
  for(i in 1:h)
  {
    indicator_prep<-indicator_list(training_data,i,past_value)
    training_indicator_set<-indicator_prep[[1]]
    test_indicator_set<-indicator_prep[[2]]
    
    reg_input_data<-merge(training_data,training_indicator_set, by=c("Date"))
    #colnames(reg_input_data)
    
    model<-lm(as.formula(paste(target,"~ .")), data= reg_input_data[c(-1)])
    temp<-data.frame(Target=target,Model="Regression",Forecast_From=max(training_indicator_set$Date),Forecast_To= test_indicator_set$Date,
                     horizon=i,Forecast=predict(model,test_indicator_set[c(-1)]))
    if(i==1) Forecast_frame<-temp else Forecast_frame<-rbind(Forecast_frame,temp)
  }
  return(Forecast_frame)
}


#Linear Regression with forecast
LM_function_forecast<-function(training_data,target, past_value , h)
{
    indicator_prep<-indicator_list(training_data,1,past_value)
    training_indicator_set<-indicator_prep[[1]]
    test_indicator_set<-indicator_prep[[2]]
    
    reg_input_data<-merge(training_data,training_indicator_set, by=c("Date"))
    #colnames(reg_input_data)
    
    model<-lm(as.formula(paste(target,"~ .")), data= reg_input_data[c(-1)])
    
    for(i in 1:h )
    {
      Forecast=predict(model,test_indicator_set[c(-1)])
      temp<-data.frame(Target=target,Model="Regression_forecast",Forecast_From=max(training_indicator_set$Date),Forecast_To= test_indicator_set$Date,
                     horizon=i,Forecast=Forecast)
      if(i==1) Forecast_frame<-temp else Forecast_frame<-rbind(Forecast_frame,temp)
      
      temp1<- data.frame(test_indicator_set$Date, Forecast)
      colnames(temp1)<- colnames(training_data)
      training_data<- rbind(training_data, temp1)
      indicator_prep<-indicator_list(training_data,1,past_value)
      test_indicator_set<-indicator_prep[[2]]
    }
  return(Forecast_frame)
}

#elastic net with forecast
elastic_net_function_forecast<-function(training_data,target, past_value, h)
{
    library(glmnet)
    indicator_prep<-indicator_list(training_data,1,past_value)
    training_indicator_set<-indicator_prep[[1]]
    test_indicator_set<-indicator_prep[[2]]
    
    reg_input_data<-merge(training_data,training_indicator_set, by=c("Date"))
    dependent<- as.matrix(reg_input_data[c(target)])
    independent<- as.matrix(reg_input_data[c(colnames(reg_input_data)[3:ncol(reg_input_data)])])
    
    #Model Selection
     for(k in 0:10)
    {
      model<-cv.glmnet(independent,dependent,alpha=k/10)
      fitted_values<-predict(model, newx = independent,s=model$lambda.min)
      error<- mean(abs((dependent - fitted_values)/dependent))
      mse<-model$cvm[which(model$lambda == model$lambda.min)]
      temp<-data.frame(alpha=k/10, error,mse)
      
      if(k==0) alpha_sel<- temp else alpha_sel<- rbind(alpha_sel,temp)
    }
    
    final_alpha<- alpha_sel[alpha_sel$error==min(alpha_sel$error),]
    #final_alpha<- alpha_sel[alpha_sel$mse==min(alpha_sel$mse),]
    
    final_model<-cv.glmnet(independent,dependent,alpha=final_alpha$alpha)
    
    
    for(i in 1:h )
    {
      Forecast<- predict( final_model, 
                           newx =as.matrix(test_indicator_set[c(names(test_indicator_set)[2:ncol(test_indicator_set)])]),
                           s=final_model$lambda.min)
      
      temp<-data.frame(Target=target,Model="Elastic_Net_Forecast",Forecast_From=max(training_indicator_set$Date),Forecast_To= test_indicator_set$Date,
                       horizon=i,Forecast=Forecast[1])
      if(i==1) Forecast_frame<-temp else Forecast_frame<-rbind(Forecast_frame,temp)
      
      temp1<- data.frame(test_indicator_set$Date, Forecast)
      colnames(temp1)<- colnames(training_data)
      training_data<- rbind(training_data, temp1)
      indicator_prep<-indicator_list(training_data,1,past_value)
      test_indicator_set<-indicator_prep[[2]]
    }
  return(Forecast_frame)
}

#elastic net
elastic_net_function<-function(training_data,target, past_value, h)
{
  library(glmnet)
  for(i in 1:h)
  {
    indicator_prep<-indicator_list(training_data,i,past_value)
    training_indicator_set<-indicator_prep[[1]]
    test_indicator_set<-indicator_prep[[2]]
    
    reg_input_data<-merge(training_data,training_indicator_set, by=c("Date"))
    dependent<- as.matrix(reg_input_data[c(target)])
    independent<- as.matrix(reg_input_data[c(colnames(reg_input_data)[3:ncol(reg_input_data)])])
    
    for(k in 0:10)
    {
      model<-cv.glmnet(independent,dependent,alpha=k/10)
      fitted_values<-predict(model, newx = independent,s=model$lambda.min)
      error<- mean(abs((dependent - fitted_values)/dependent))
      mse<-model$cvm[which(model$lambda == model$lambda.min)]
      temp<-data.frame(alpha=k/10, error,mse)
      
      if(k==0) alpha_sel<- temp else alpha_sel<- rbind(alpha_sel,temp)
    }
    
    final_alpha<- alpha_sel[alpha_sel$error==min(alpha_sel$error),]
    #final_alpha<- alpha_sel[alpha_sel$mse==min(alpha_sel$mse),]
    
    final_model<-cv.glmnet(independent,dependent,alpha=final_alpha$alpha)
    Forecast1<- predict( final_model, 
                         newx =as.matrix(test_indicator_set[c(names(test_indicator_set)[2:ncol(test_indicator_set)])]),
                         s=final_model$lambda.min)
    
    temp<-data.frame(Target=target,Model="Elastic_Net",Forecast_From=max(training_indicator_set$Date),Forecast_To= test_indicator_set$Date,
                     horizon=i,Forecast=Forecast1[1])
    if(i==1) Forecast_frame<-temp else Forecast_frame<-rbind(Forecast_frame,temp)
  }
  return(Forecast_frame)
}

#forward Stepwise Regresion
Stepwise_function<-function(training_data,target, past_value , h)
{
  for(i in 1:h)
  {
    indicator_prep<-indicator_list(training_data,i,past_value)
    training_indicator_set<-indicator_prep[[1]]
    test_indicator_set<-indicator_prep[[2]]
    reg_input_data<-merge(training_data,training_indicator_set, by=c("Date"))
    
    library(leaps)
    #training data
    train= sample(nrow(reg_input_data),nrow(reg_input_data)*0.7, rep=FALSE)
    test=-train
    #nvmax =(ncol(reg_input_data)-2)
    model<-regsubsets(as.formula(paste(target,"~ .")), data= reg_input_data[c(-1)][train,],
                      nvmax = 20, 
                      method="forward")
    summary_model<-summary(model)
    which.min(summary_model$bic)
    #which.min(summary_model$cp)
    test.mat<-data.frame(1,reg_input_data[test,])
    colnames(test.mat)[1]<-c("(Intercept)")
    names(test.mat)
    val.errors=rep(0, nrow(summary_model$which))
    for(k in 1:length(val.errors))
    {
      coefi<- coef(model, id= k)
      pred=as.matrix(test.mat[,names(coefi)])%*%coefi
      b<-abs((test.mat[c(target)]- pred)/test.mat[c(target)])
      val.errors[k]=mean(b[,1])*100
    }
    
    
    test_indicator_set<-data.frame(1,test_indicator_set)
    colnames(test_indicator_set)[1]<-c("(Intercept)")
    
    #select the best coefficients
    best_coef<-coef(model, id=  which.min(val.errors))
    
    pred=as.matrix(test_indicator_set[,names(best_coef)])%*%best_coef
    
    temp<-data.frame(Target=target,Model="Stepwise Regression",Forecast_From=max(training_indicator_set$Date),Forecast_To= test_indicator_set$Date,
                     horizon=i,Forecast=pred)
    if(i==1) Forecast_frame<-temp else Forecast_frame<-rbind(Forecast_frame,temp)
  }
  return(Forecast_frame)
}

#forward Stepwise Regresion with forecast
Stepwise_function_forecast<-function(training_data,target, past_value , h)
{
    indicator_prep<-indicator_list(training_data,1,past_value)
    training_indicator_set<-indicator_prep[[1]]
    test_indicator_set<-indicator_prep[[2]]
    reg_input_data<-merge(training_data,training_indicator_set, by=c("Date"))
    
    library(leaps)
    #training data
    train= sample(nrow(reg_input_data),nrow(reg_input_data)*0.7, rep=FALSE)
    test=-train
    #nvmax =(ncol(reg_input_data)-2)
    model<-regsubsets(as.formula(paste(target,"~ .")), data= reg_input_data[c(-1)][train,],
                      nvmax = 20, method="forward")
    summary_model<-summary(model)
    which.min(summary_model$bic)
    #which.min(summary_model$cp)
    test.mat<-data.frame(1,reg_input_data[test,])
    colnames(test.mat)[1]<-c("(Intercept)")
    names(test.mat)
    val.errors=rep(0, nrow(summary_model$which))
    for(k in 1:length(val.errors))
    {
      coefi<- coef(model, id= k)
      pred=as.matrix(test.mat[,names(coefi)])%*%coefi
      b<-abs((test.mat[c(target)]- pred)/test.mat[c(target)])
      val.errors[k]=mean(b[,1])*100
    }
    
    #select the best coefficients
    best_coef<-coef(model, id=  which.min(val.errors))
    for(i in 1:h)
   { 
     test_indicator_set<-data.frame(1,test_indicator_set)
    colnames(test_indicator_set)[1]<-c("(Intercept)")
    
    pred=as.matrix(test_indicator_set[,names(best_coef)])%*%best_coef
    
    temp<-data.frame(Target=target,Model="Stepwise Regression_forecast",Forecast_From=max(training_indicator_set$Date),Forecast_To= test_indicator_set$Date,
                     horizon=i,Forecast=pred)
    if(i==1) Forecast_frame<-temp else Forecast_frame<-rbind(Forecast_frame,temp)
    
    temp1<- data.frame(test_indicator_set$Date, pred)
    colnames(temp1)<- colnames(training_data)
    training_data<- rbind(training_data, temp1)
    indicator_prep<-indicator_list(training_data,1,past_value)
    test_indicator_set<-indicator_prep[[2]]
  }
  return(Forecast_frame)
}

#SVM Model
SVM_function<-function(training_data,target, past_value , h)
{
  library(Boruta)
  for(i in 1:h)
  {
    indicator_prep<-indicator_list(training_data,i,past_value)
    training_indicator_set<-indicator_prep[[1]]
    test_indicator_set<-indicator_prep[[2]]
    
    reg_input_data<-merge(training_data,training_indicator_set, by=c("Date"))
    #colnames(reg_input_data)
    
    #variable Selection
    boruta.train <- Boruta(as.formula(paste(target,"~ .")), data= reg_input_data[c(-1)], doTrace = 2)
    result<-boruta.train$finalDecision
    regressor<-names(result[result=="Confirmed"])
    equation<- as.formula(paste(target,"~ ", paste(regressor, collapse= "+")))
    
    library(e1071)
    svm.model <- svm(equation, data= reg_input_data[c(-1)],
                     type="nu-regression",
                     kernel="radial")
    
    #svm.model <- svm(as.formula(paste(target,"~ .")), data= reg_input_data[c(-1)],
    #                 type="nu-regression", kernel="radial")
    
    pred<- predict(svm.model,test_indicator_set[c(-1)])
    temp<-data.frame(Target=target,Model="SVM Regression",Forecast_From=max(training_indicator_set$Date),Forecast_To= test_indicator_set$Date,
                     horizon=i,Forecast= pred)
    if(i==1) Forecast_frame<-temp else Forecast_frame<-rbind(Forecast_frame,temp)
  }
  return(Forecast_frame)
}

##SVM Model with forecast
SVM_function_forecast<-function(training_data,target, past_value , h)
{
  library(Boruta)
  indicator_prep<-indicator_list(training_data,1,past_value)
    training_indicator_set<-indicator_prep[[1]]
    test_indicator_set<-indicator_prep[[2]]
    
    reg_input_data<-merge(training_data,training_indicator_set, by=c("Date"))
    #colnames(reg_input_data)
    
    #variable Selection
    boruta.train <- Boruta(as.formula(paste(target,"~ .")), data= reg_input_data[c(-1)], doTrace = 2)
    result<-boruta.train$finalDecision
    regressor<-names(result[result=="Confirmed"])
    equation<- as.formula(paste(target,"~ ", paste(regressor, collapse= "+")))
    
    library(e1071)
    svm.model <- svm(equation, data= reg_input_data[c(-1)],
                     type="nu-regression",
                     kernel="radial")
    
    for(i in 1:h)
    {
    pred<- predict(svm.model,test_indicator_set[c(-1)])
    temp<-data.frame(Target=target,Model="SVM Regression_forecast",Forecast_From=max(training_indicator_set$Date),Forecast_To= test_indicator_set$Date,
                     horizon=i,Forecast= pred)
    if(i==1) Forecast_frame<-temp else Forecast_frame<-rbind(Forecast_frame,temp)
    temp1<- data.frame(test_indicator_set$Date, pred)
    colnames(temp1)<- colnames(training_data)
    training_data<- rbind(training_data, temp1)
    indicator_prep<-indicator_list(training_data,1,past_value)
    test_indicator_set<-indicator_prep[[2]]
    
  }
  return(Forecast_frame)
}

####################################
###################################
sales<-read.csv("C:\\Work\\Forecasting\\cmsc_actual_targets_201611_history.csv")
library(zoo)
sales$Date<-as.yearmon(as.character(sales$Date), "%b'%y")
sales$Date<-as.Date(sales$Date)
library(MASS)

#create dummy variable for Months so that if any particular not prresent model can handle
sales$Jan<-ifelse(format(sales$Date,"%m")=="01", 1,0)
sales$Feb<-ifelse(format(sales$Date,"%m")=="02", 1,0)
sales$Mar<-ifelse(format(sales$Date,"%m")=="03", 1,0)
sales$Apr<-ifelse(format(sales$Date,"%m")=="04", 1,0)
sales$May<-ifelse(format(sales$Date,"%m")=="05", 1,0)
sales$Jun<-ifelse(format(sales$Date,"%m")=="06", 1,0)
sales$Jul<-ifelse(format(sales$Date,"%m")=="07", 1,0)
sales$Aug<-ifelse(format(sales$Date,"%m")=="08", 1,0)
sales$Sep<-ifelse(format(sales$Date,"%m")=="09", 1,0)
sales$Oct<-ifelse(format(sales$Date,"%m")=="10", 1,0)
sales$Nov<-ifelse(format(sales$Date,"%m")=="11", 1,0)



testEnd <- dim(sales)[1]
testBegin <- testEnd-29#17
h=6
past_value<-12
business_unit_name<-names(sales)[-1]
for(i in 1:length(business_unit_name))
{
  input_variables<-c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov")
  Business_unit_data<-sales[c("Date",business_unit_name[i],input_variables)]
  
  target<-business_unit_name[i]
  for(j in testBegin:testEnd)
  {
    training_data<-Business_unit_data[1:j,]
    
    ARIMA_Forecast<- ARIMA_forecastFunction(training_data, target,past_value,  h)
    
    ARIMA_Forecast_dummy<-Arima_model(training_data,input_variables, target, h)
    #BSTS_forecast<-BSTS_model(training_data, target,past_value,  h)
    #Linear_model<-LM_function(training_data, target,past_value,  h)
    # Linear_model_forecast<-LM_function_forecast(training_data, target,past_value,  h)
    
    #Stepwise_model<-Stepwise_function(training_data, target,past_value,  h)
    #Stepwise_model_forecast<-Stepwise_function_forecast(training_data, target,past_value,  h)
    
    #Elastic_net_model<- elastic_net_function(training_data, target,past_value,  h)
    #Elastic_net_forecast<- elastic_net_function_forecast(training_data, target,past_value,  h)
    
    #svm_model<-SVM_function(training_data, target,past_value,  h)
    #svm_forecast<-SVM_function_forecast(training_data, target,past_value,  h)
    
   # Forecast_busines_unit<- rbind(ARIMA_Forecast,BSTS_forecast,  Linear_model,Linear_model_forecast,
     #                             Stepwise_model,Stepwise_model_forecast, Elastic_net_model,
      #                            Elastic_net_forecast,svm_model, svm_forecast)
    Forecast_busines_unit<- rbind(ARIMA_Forecast, ARIMA_Forecast_dummy)
    if(!exists("all_forecast")){
      all_forecast <- Forecast_busines_unit
    } else {
      all_forecast <- rbind(all_forecast,Forecast_busines_unit)
    }
  }
  truth_value<- data.frame(Target= target, Model="Truth",Forecast_From=Business_unit_data$Date,
                           Forecast_To=Business_unit_data$Date,horizon=0,
                           Forecast=Business_unit_data[,2])
  all_forecast <- rbind(all_forecast,truth_value)
}

write.csv(all_forecast , "C:\\Work\\Forecasting\\forecast_all_models.csv",row.names = FALSE)
