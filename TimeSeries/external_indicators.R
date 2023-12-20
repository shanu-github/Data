#Libraries
library(data.table) #for indicator data
library(zoo) #Date transformation
library(MASS) 
library(forecast) #ARIMA forecast
library(reshape) #for data melting
library(glmnet) #for Lasso
require(caret) #for PCA
library(dplyr)
library(lubridate)
library(relaimpo)
library(igraph)

#Lag Creation
indicator_list<-function(training_data,h,past_value)
{
  #training Data Format: First column as Date and other series
  # h: forecast horizon, according to horizon lags are created
  #if h=1 the it will create from lag1
  #if h=2 the it will create from lag2
  #past value : basically how many lags has be created
  #If h=1, and past_value=6 then it will create from lag1 to lag6
  #return indicators with reuired lags 
  #and also data for forcast for according to h
  
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

revenue_data<-read.csv("C:\\Work\\GS_CTG4_Assessment\\Cleaned_Data\\GS_Data\\Merged_PC_Fixed.csv",stringsAsFactors = FALSE)
#Correcting the Date Format
revenue_data$Date<-ymd(revenue_data$Date)
revenue_data<-aggregate(Sales~Date+Entity,revenue_data,sum)
#training_data<-filter(revenue_data, Entity=="GSG")
training_data<-revenue_data

#Indicator Data
indicator_dir="C:\\Work\\GS_CTG4_Assessment\\Shared_Data\\Indicators\\"
indicator_data_feri<-read.csv(paste(indicator_dir,"allIndicators.csv",sep=''),stringsAsFactors = FALSE)
indicator_data_feri$Date<-as.Date(as.yearmon(as.character(indicator_data_feri$Date), "%b'%y"))

indicator_data_fred<-read.csv(paste(indicator_dir,"Indicators_data_July_2017.csv",sep=''),stringsAsFactors = FALSE)
indicator_data_fred$Date<-ymd(indicator_data_fred$Date)

indicator_data<- merge(indicator_data_feri,indicator_data_fred, by=c('Date'))


#keep indicator and training till same date
training_data<-training_data[training_data$Date<=max(indicator_data$Date),]
indicator_data<-indicator_data[indicator_data$Date<=max(training_data$Date),]

new_indicator_data<- data.frame(Date= indicator_data$Date)
for(i in 2:ncol(indicator_data))
{
 std= sd(indicator_data[,i])
 if(std>0)
   new_indicator_data<- cbind(new_indicator_data, indicator_data[,i])
  
}

target<-'Sales'
past_value_indicator<-12

unique_entity<- unique(training_data$Entity)


temp_indi_data<-indicator_data[indicator_data$Date<=max(training_data$Date),]
importance_variables<-NULL
data_points<-NULL
for (k in unique_entity)
{
  print(k)
  temp_training_data<- subset(training_data, Entity== k)
  temp_training_data<- temp_training_data[c('Date',target)]
  #create lags
  #temp_tar_indi_data<- merge(temp_training_data,temp_indi_data, by=c('Date') )
  temp_tar_indi_data<- temp_indi_data
  lag_indicator_data<-indicator_list(temp_tar_indi_data,1,past_value_indicator)[[1]]
  actual_indi_lags<- merge(temp_indi_data,lag_indicator_data, by=c('Date'))
  reg_input_data<-merge(temp_training_data,actual_indi_lags, by=c("Date"))
  #reg_input_data<- subset(reg_input_data, select = c(-Date))
  
  variables<- data.frame(Indicator=names(reg_input_data)[c(-1,-2)])
  variables$Variance_Explained<-NA
  variables$Coefficient<-NA
  variables$Intercept<-NA
  variables$MAPE<-NA
  variables$p_value<-NA
  variables$Entity<-k
  for (i in 1:nrow(variables))
  {
    temp= reg_input_data[c( "Sales",as.character(variables$Indicator[i]))]
    linmod <- lm(Sales ~ ., data = temp)
    variables$Variance_Explained[i]<-summary(linmod)$r.squared
    variables$p_value[i]<-as.numeric(summary(linmod)$coefficients[,4])[2]
    #variables$r_sq_cor[i]<-cor(temp[,1] ,temp[,2])^2
    variables$Coefficient[i]<-linmod$coefficients[[2]]
    variables$Intercept[i]<-linmod$coefficients[[1]]
    variables$MAPE[i]<- mean(abs((linmod$fitted.values/temp$Sales)-1))
  }

  variables<- filter(variables,Variance_Explained>.2 & p_value<0.05)
  #if(nrow(variables)>0)
  #{
   #sel_variables=actual_indi_lags[variables$Indicator]
  # b<- names(sel_variables)
  # b<-b[!(b %in% c("Date")) ]
  # sel_variables<- sel_variables[b]
  # var.corelation <- cor(as.matrix(sel_variables), method="pearson")
  
  # prevent duplicated pairs
  #var.corelation <- var.corelation*lower.tri(var.corelation)
  #check.corelation <- which(var.corelation>0.90, arr.ind=TRUE)

  #graph.cor <- graph.data.frame(check.corelation, directed = FALSE)
  #groups.cor <- split(unique(as.vector(check.corelation)),         clusters(graph.cor)$membership)
  #var_group<-lapply(groups.cor,FUN=function(list.cor){rownames(var.corelation)[list.cor]})
  #final_data<-NULL
  #for(g in 1:length(var_group))
  #{
  # temp= data.frame(Indicator= var_group[[i]])
  # temp$cluster= i
  # final_data<- rbind(final_data,temp)
  #}

  #variables$Indicator<- as.character(variables$Indicator)
  #final_data$Indicator<- as.character(final_data$Indicator)

  #final_data1<- merge(variables, final_data, by=c("Indicator"), all.x = TRUE )
  final_data1<-variables
  importance_variables<- rbind(importance_variables,variables)
  #write.csv( final_data1,"C:\\Work\\GS_CTG4_Assessment\\Modelling_Outputs\\External_indicators\\indicator.csv", row.names = FALSE)

  final_data_points<- NULL
  for (i in 1:nrow(final_data1))
  {
     temp= reg_input_data[c( "Sales",as.character(final_data1$Indicator[i]))]
     linmod <- lm(Sales ~ ., data = temp)
      datapoints<- data.frame(Date=reg_input_data$Date, Target= reg_input_data$Sales, Indicator= final_data1$Indicator[i],
                          Indicator_value= temp[,2], Fitted_target= linmod$fitted.values)
     final_data_points<- rbind(final_data_points,datapoints)
  }
  final_data_points$Entity<-k
  data_points<-rbind( data_points,final_data_points)
  #write.csv( final_data_points,"C:\\Work\\GS_CTG4_Assessment\\Modelling_Outputs\\External_indicators\\indicator_data_points.csv", row.names = FALSE)
}

write.csv(importance_variables,"C:\\Work\\GS_CTG4_Assessment\\Modelling_Outputs\\External_indicators\\indicator.csv", row.names = FALSE)
write.csv( data_points,"C:\\Work\\GS_CTG4_Assessment\\Modelling_Outputs\\External_indicators\\indicator_data_points.csv", row.names = FALSE)







#----------------------------------------------------------------------------------------------------


nmod <- lm(Sales ~ ., data = select(reg_input_data, -Date))
summary(linmod)

metrics <- calc.relimp(linmod, type = c( "first"))
metrics


#indicator information
indicators_info <- data.frame(Names= names(actual_indi_lags)[-1])
indicators_info$Names<- as.character(indicators_info$Names)
indicators_info$mean=0
indicators_info$std=0

for(i in 1:nrow(indicators_info))
{
  indicators_info$mean[i]<-mean(actual_indi_lags[,indicators_info$Names[i]], na.rm = TRUE)
  indicators_info$std[i]<-sd(actual_indi_lags[,indicators_info$Names[i]], na.rm = TRUE)
  actual_indi_lags[,indicators_info$Names[i]]<- (actual_indi_lags[,indicators_info$Names[i]]- indicators_info$mean[i])/indicators_info$std[i]
}

reg_input_data<-merge(temp_training_data,actual_indi_lags, by=c("Date"))
reg_input_data<-reg_input_data[colSums(!is.na(reg_input_data)) > 0]

dependent<- as.matrix(reg_input_data[c(target)])
independent<- as.matrix(reg_input_data[c(colnames(reg_input_data)[3:ncol(reg_input_data)])])
#independent<- scale(independent, center = TRUE, scale = TRUE )
final_model<-cv.glmnet(independent,dependent,alpha=1)
variables<-data.frame(Coeficient= as.matrix(coef(final_model)))
variables$Names<- rownames(variables)

variables<-merge(variables,indicators_info, by=c("Names"), all.x = TRUE)
variables$Actual_beta_weight<- variables$X1/variables$std
variables$Actual_beta_weight[1]<- variables$X1[1]-sum(variables$Actual_beta_weight * variables$mean, na.rm = TRUE)

selected_var<- filter(variables, abs(Actual_beta_weight)>0)
selected_var$X1_abs<- abs(selected_var$X1)

#similar variables according to correlation
selectedvariables<- selected_var$Names[-1]
correlation_matrix=data.frame(cor(actual_indi_lags[-1]))
correlation_matrix1<- subset(correlation_matrix, select=selectedvariables)
correlation_matrix1$Variable1<- rownames(correlation_matrix1)
mdata <- melt(correlation_matrix1, id=c("Variable1")) 
mdata<- filter(mdata,value>.80 )

#cleaning of column names without lag 
column_Names_without_lags<-function(column_names){
  initial.digit<-function(x) {strsplit(as.character(x),'_lag')[[1]][1]}
  return(unique(sapply(column_names,initial.digit)))
}


unique(column_Names_without_lags(mdata$Variable1))

#groupin of Similar variable using PCA
trans = preProcess(actual_indi_lags[,2:ncol(actual_indi_lags)], method=c("YeoJohnson", "center", "scale", "pca"))
a<-data.frame(trans$rotation)
pc <- prcomp(actual_indi_lags[,2:ncol(actual_indi_lags)],scale=FALSE)
plot(pc)
plot(pc, type='l')
summary(pc)
# First for principal components
comp <- data.frame(pc$x[,1:10])
# Plot
#plot(comp, pch=16, col=rgb(0,0,0,0.5))
k <- kmeans(comp, 10, nstart=25, iter.max=1000)
# Cluster sizes
sort(table(k$clust))
clust <- names(sort(table(k$clust)))

# First cluster
row.names(filter(data, k$clust==clust[1]))
# Second Cluster
row.names(data[k$clust==clust[2],])
# Third Cluster
row.names(data[k$clust==clust[3],])
# Fourth Cluster
row.names(data[k$clust==clust[4],])
