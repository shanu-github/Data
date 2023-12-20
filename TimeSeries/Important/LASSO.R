#Call packages
library(glmnet)
library(data.table)


#Call file and read data in R
setwd("C:/Users/UAG1KOR/Desktop/Surabhi Docs/Working")
traindata <- read.csv("BorutaData.csv", header=TRUE, stringsAsFactors = F )
traindata <- as.data.frame(traindata)

#Lagged Var Creation
for (j in 3:ncol(traindata)) 
{
  
  for (i in 1:12) {
    traindata <- cbind( traindata, shift(x = traindata[ ,j], n=i, fill=NA, type="lag"))
    names(traindata)[ncol(traindata)] <- sprintf( "lag_%02d-%s",i,colnames(traindata)[j])
  }
}

#Deleting the fields with NA entries
newdata <-na.omit(traindata)
newdata <- newdata[-grep('DATE', colnames(newdata))]

#Normalizing the data for predictive analysis
newdata <-scale(newdata, center = TRUE, scale = TRUE)
print(newdata)

#Tidying data for Prediction
###Deleting Date Column
newdata <- newdata[-grep('DATE', colnames(newdata))]


#Lasso
x <- model.matrix(Sales~., newdata)
y <- (newdata$Sales)

cv.out <- cv.glmnet(x,y, alpha=1)
model= glmnet(x,y,type.gaussian = "naive", lambda = cv.out$lambda.1se)
predict(model, type="coefficients")






