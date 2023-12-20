#Calling packages
library(glmnet)
library(data.table)
library(caret)
library(dplyr)
library(randomForest)


#Call file
setwd("C:/Users/UAG1KOR/Desktop/Surabhi Docs/Working")
traindata <- read.csv("BorutaData.csv", header=TRUE, stringsAsFactors = F )
traindata <- as.data.frame(traindata)

#Lagged Var Creation
for (j in 2:ncol(traindata)) 
{
  
  for (i in 1:12) {
    traindata <- cbind( traindata, shift(x = traindata[ ,j], n=i, fill=NA, type="lag"))
    names(traindata)[ncol(traindata)] <- sprintf( "lag_%02d_%s",i,colnames(traindata)[j])
  }
}

#Deleting the fields with NA entries
newdata <-na.omit(traindata)
traindta <- newdata[1:96, ]
testdta <- newdata[97:118, ]

ndata <- subset(traindta, select = -c(DATE))


### Random Forest Algo
rf <- randomForest(Sales~., data = ndata)
# Create an importance based on mean decreasing gini
importance(rf)
getTree(rf, 1)

# View the forest results.
print(rf) 

# Importance of each predictor.
imp <- print(importance(rf,type = 2)) 

#VarImpPlot
varImpPlot(rf)
