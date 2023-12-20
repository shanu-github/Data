
#Load Libraries
library(xlsx) #read data from excel into R
library(dplyr) #Manipulate data
library(forecast) #Predict SALES values
library(glmnet) #LASSO
library(caTools)
library(MASS)
library(data.table)
library(forecast)
library(rlist)

#Call file
#Read excel data into R
inputdata <- read.xlsx("C:/Users/UAG1KOR/Desktop/FunctionData.xlsx", sheetIndex = 1,header= TRUE)
clean.data <- as.data.frame(inputdata)

#Creating lagged variables
#Lagged Var Creation
for (j in 2:ncol(clean.data)) 
{
  
  for (i in 1:12) {
    clean.data <- cbind( clean.data, shift(x = clean.data[ ,j], n=i, fill=NA, type="lag"))
    names(clean.data)[ncol(clean.data)] <- sprintf( "lag_%02d_%s",i,colnames(clean.data)[j])
  }
}

#Dividing into test and train
traindata <- clean.data[1:96,] 
testdata <- clean.data[97:nrow(clean.data),]

#Deleting the features with unknown vaues from the dataset, train and test.
for(k in 1:nrow(testdata))
{
  temp_testdata <- testdata[k,]
  temp_testdata <-temp_testdata[colSums(!is.na(temp_testdata)) > 0]
  temp_traindata<- traindata[ colnames(temp_testdata)]
  
  
#Deleting the rows with NAs
temp_traindata <- na.omit(temp_traindata)
copy_temp_traindata<- temp_traindata  
  
#Normalzie
###MEAN normalizing
  for (j in 3:ncol(copy_temp_traindata)) {
    
    m <- mean(copy_temp_traindata[,j])
    stddev <- sd(copy_temp_traindata[,j])
    copy_temp_traindata[,j] <- ((copy_temp_traindata[,j]-m)/stddev)
  }
  
####### Working on Training data only for Lasso
#Model MAtrix formation
x <- model.matrix(Sales~.-DATE, copy_temp_traindata)
y <- (copy_temp_traindata$Sales)
  
#LASSO run
set.seed(1)
cv.out <- cv.glmnet(x,y, alpha=1)
model= glmnet(x,y, type.gaussian = "naive", lambda = cv.out$lambda.1se)
pred <- predict(model, type="coefficients")
pred1 <- as.matrix(pred)
predtable <- data.frame(coef.name = dimnames(coef(model))[[1]], coef.value = matrix(coef(model)))
  
####Renaming Column names and storing predicted Sales in data table
colnames(predtable) <-  c("indicators", "Coeff")
predtable$Coeff <- abs(predtable$Coeff)
  
#Arranging in descending order to extract the top ten indicators
top <- arrange(predtable, desc(Coeff))
top <- top[2:11,] #Selecting the first ten rows to get top ten indicators

#Creating dataframe with Sales and top ten indicators
RegTable <-temp_traindata[c('Sales',as.character(top$indicators))]
  
####Model Creation
#Working on Test Data
linearModtrain <- lm(Sales ~. , data=RegTable)  # build linear regression model on full data
summary(linearModtrain)
  
#Predict Sales on test data 
predvalue <- predict(linearModtrain, newdata = temp_testdata)
PredictedSales <- rbind(predvalue)
colnames(PredictedSales) <-  c("PredSales")
PredictedSales <- as.data.frame(PredictedSales)

#MAPE Calculation
ErrorTable <-temp_testdata[c('DATE', 'Sales')]
ErrorTable$PredSales <- PredictedSales$PredSales
ErrorTable$Error <- ErrorTable$Sales - ErrorTable$PredSales
ErrorTable$MAPE <- (ErrorTable$Error / ErrorTable$Sales)
  
} 








