library(ISLR)
data("Default")

#predicting default using logistic regression
#-----------------------------------------------------------------------------------------------------
#step1: Reading the Data 
default_data<- read.csv("D:/work/Shanu/ATI/Base_Analytics/class5/Default.csv")

#Check the Structure of data
str(default_data)

#Check the summary of data, if any missing values NA 
summary(default_data)

#Check first few rows
head(default_data)

colnames(default_data)

#--------------------------------------------------------------------------------
#Step2 : Exploring the data
library(ggplot2)
ggplot(default_data, aes(x=balance, y = income, color=default)) +  
  geom_point()

ggplot(default_data, aes(x=default, y =balance)) +  
  geom_boxplot()

ggplot(default_data, aes(x=default, y =income)) +  
  geom_boxplot()

table(default_data$student, default_data$default)

#-------------------------------------------------------------------------------------------------------
#Divide into train and test
library(dplyr)
train_data <- default_data %>% sample_frac(.75)
#anti_join delete the data if present in other
test_data  <- anti_join(default_data, train_data)


#--------------------------------------------------------------------------------------
# Build Logitistic Model 
log_model <- glm(default ~ balance, family="binomial", 
                 data = train_data)

summary(log_model)

# Build Logitistic Model 
log_model <- glm(default ~ balance+student+income, family="binomial", data =train_data)
summary(log_model)

#-------------------------------------------------------------------------------------
#Prediction

#Also, an important caveat is to make sure you set the type="response" 
#when using the predict function on a logistic regression model. 
#Else, it will predict the log odds of P, that is the Z value, instead of the probability itself.

test_data$predicted_Prob <- predict(log_model, test_data,
                                    type="response") 

test_data$predicted_default <-ifelse(test_data$predicted_Prob > 0.5, 
                                     "Yes", "No")

table(test_data$default, test_data$predicted_default)

ggplot(test_data, aes(x=predicted_Prob, fill =default)) +  geom_density()

#------------------------------------------------------------------------------
#Performance evaluation
cm = as.matrix(table(Actual = test_data$default, Predicted =test_data$predicted_default)) # create the confusion matrix
cm

n = sum(cm) # number of instances
nc = nrow(cm) # number of classes
diag = diag(cm) # number of correctly classified instances per class 
rowsums = apply(cm, 1, sum) # number of instances per class
colsums = apply(cm, 2, sum) # number of predictions per class
p = rowsums / n # distribution of instances over the actual classes
q = colsums / n # distribution of instances over the predicted classes

accuracy = sum(diag) / n 

precision = diag / colsums 
recall = diag / rowsums 
f1 = 2 * precision * recall / (precision + recall) 

data.frame(precision, recall, f1) 

library(caret)
summary_log_model<-caret::confusionMatrix(test_data$default, 
                       as.factor(test_data$predicted_default), 
                       positive="Yes", mode="everything")

str(summary_log_model)
summary_log_model$byClass

#=-----------------------------------------------------------------------------------------------
#deciding on Optimal Threshold
prediction_score<-NULL
cutoffs <- seq(0.1,0.9,0.1)

for (i in seq(along = cutoffs)){
 
  train_data$predicted_Prob <- predict(log_model, train_data,type="response") 
  
  train_data$predicted_default <-ifelse(train_data$predicted_Prob > cutoffs[i], "Yes", "No")
  
  cm = as.matrix(table(Actual = train_data$default, Predicted = train_data$predicted_default)) # create the confusion matrix

  n = sum(cm) # number of instances
  nc = nrow(cm) # number of classes
  diag = diag(cm) # number of correctly classified instances per class 
  rowsums = apply(cm, 1, sum) # number of instances per class
  colsums = apply(cm, 2, sum) # number of predictions per class
  p = rowsums / n # distribution of instances over the actual classes
  q = colsums / n # distribution of instances over the predicted classes
  
  
  accuracy = sum(diag) / n 
  
  precision = diag / colsums 
  recall = diag / rowsums 
  f1= 2 * precision * recall / (precision + recall) 
  temp_prediction_score= data.frame(precision, recall, f1 ) 
  temp_prediction_score$Threshold<-cutoffs[i]
  temp_prediction_score$default= row.names(temp_prediction_score)
  prediction_score<- rbind(prediction_score,temp_prediction_score)
}

library(ggplot2)
ggplot(prediction_score[prediction_score$default=="Yes",], aes(x=Threshold, y = f1)) +  
  geom_point()

