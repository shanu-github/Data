#LIBRARIES
library(forecast)
library(glmnet)
library(data.table)
library(dplyr)

#LOAD THE DATA
setwd("C:/Users/UAG1KOR/Desktop/Surabhi Docs/Working")
traindata <- read.csv("BorutaData.csv", header=TRUE, stringsAsFactors = F )
traindata <- as.data.frame(traindata)

#CREATIN LAGGED VARIABLES FOR SALES AND EXTERNAL PREDICTORS
for (j in 2:ncol(traindata)) 
{
  
  for (i in 1:12) {
    traindata <- cbind( traindata, shift(x = traindata[ ,j], n=i, fill=NA, type="lag"))
    names(traindata)[ncol(traindata)] <- sprintf( "lag_%02d_%s",i,colnames(traindata)[j])
  }
}

#DELETING THE ROWS WITH NA VALUES
newdata <-na.omit(traindata)

#NORMALIZING THE DATASET FOR ANALYSIS
for (j in 3:ncol(newdata)) {
  
  m <- mean(newdata[,j])
  stddev <- sd(newdata[,j])
  newdata[,j] <- ((newdata[,j]-m)/stddev)
}

#DIVIDING THE DATA INTO TRAIN AND TEST
traindta <- newdata[1:96, ]
testdta <- newdata[97:118, ]

#LINEAR REGRESSION ANALYSIS FOR FEATURE SELECTION (LASSO REGRESSION/ L1 REGULARIZATION)
x <- model.matrix(Sales~.-DATE, traindta)
y <- (traindta$Sales)

#LASSO CODE
set.seed(1)
cv.out <- cv.glmnet(x,y, alpha=1)
model= glmnet(x,y, type.gaussian = "naive", lambda = cv.out$lambda.1se)
pred <- predict(model, type="coefficients")
pred1 <- as.matrix(pred)
print(pred1)
fix(pred1)

#MODEL CREATION FOR TRAIN DATA
linearMod1 <- lm(Sales ~ lag_12_Sales + Germany_prod_pc + lag_08_Germany_stocks +lag_05_Spain_IP +EU15_prod_pc + lag_01_EmergingMarkets_stocks + lag_10_Spain_GDP_Q + lag_05_France_building_permits + lag_04_Sales + Germany_building_permits_nonres_currency, data=testdta)  # build linear regression model on full data
summary(linearMod1)

#MODEL CREATION FOR TEST DATA
linearModtest <- lm(Sales ~ lag_12_Sales + Germany_prod_pc + lag_08_Germany_stocks +lag_05_Spain_IP +EU15_prod_pc + lag_01_EmergingMarkets_stocks + lag_10_Spain_GDP_Q + lag_05_France_building_permits + lag_04_Sales + Germany_building_permits_nonres_currency, data=testdta)  # build linear regression model on full data
summary(linearModtest)

#PREDICTING SALES VALUE FOR TEST DATA
predvalue <- predict(linearModtest, newdata = testdta)
predvalue <- as.matrix(predvalue)

#MAPE CALCULATION TO CHECK THE MODEL ACCURACY FOR TEST DATA
actual <- (testdta$Sales)
a <- (actual-predvalue)/actual
b<- abs(a)
c <- mean(b) *100

#SCATTER PLOTS FOR THE TOP TEN INDICATORS
attach(newdata)

#1 lag_05_Spain_IP
plot( lag_05_Spain_IP, Sales, xlab = "lag_05_Spain_IP", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~lag_05_Spain_IP), col="red")
# fit a loess line
loess_fit <- loess(Sales ~lag_05_Spain_IP ,newdata)
lines(newdata$lag_05_Spain_IP, predict(loess_fit), col = "blue")


#2 lag_12_Sales
plot( lag_12_Sales, Sales, xlab = "lag_12_Sales", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~lag_12_Sales), col="red")
# fit a loess line
loess_fit <- loess(Sales ~lag_12_Sales ,newdata)
lines(newdata$lag_12_Sales, predict(loess_fit), col = "blue")


#3 Germany_prod_pc
plot( Germany_prod_pc, Sales, xlab = "Germany_prod_pc", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~Germany_prod_pc), col="red")
# fit a loess line
loess_fit <- loess(Sales ~Germany_prod_pc ,newdata)
lines(newdata$Germany_prod_pc, predict(loess_fit), col = "blue")


#4 lag_08_Germany_stocks
plot( lag_08_Germany_stocks, Sales, xlab = "lag_08_Germany_stocks", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~lag_08_Germany_stocks), col="red")
# fit a loess line
loess_fit <- loess(Sales ~lag_08_Germany_stocks ,newdata)
lines(newdata$lag_08_Germany_stocks, predict(loess_fit), col = "blue")


#5 EU15_prod_pc
plot( EU15_prod_pc, Sales, xlab = "EU15_prod_pc", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~EU15_prod_pc), col="red")
# fit a loess line
loess_fit <- loess(Sales ~EU15_prod_pc ,newdata)
lines(newdata$EU15_prod_pc, predict(loess_fit), col = "blue")


#6 lag_01_EmergingMarkets_stocks
plot( lag_01_EmergingMarkets_stocks, Sales, xlab = "lag_01_EmergingMarkets_stocks", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~lag_01_EmergingMarkets_stocks), col="red")
# fit a loess line
loess_fit <- loess(Sales ~lag_01_EmergingMarkets_stocks ,newdata)
lines(newdata$lag_01_EmergingMarkets_stocks, predict(loess_fit), col = "blue")


#7 lag_10_Spain_GDP_Q
plot( lag_10_Spain_GDP_Q, Sales, xlab = "lag_10_Spain_GDP_Q", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~lag_10_Spain_GDP_Q), col="red")
# fit a loess line
loess_fit <- loess(Sales ~lag_10_Spain_GDP_Q ,newdata)
lines(newdata$lag_10_Spain_GDP_Q, predict(loess_fit), col = "blue")


#8 lag_05_France_building_permits
plot( lag_05_France_building_permits, Sales, xlab = "lag_05_France_building_permits", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~lag_05_France_building_permits), col="red")
# fit a loess line
loess_fit <- loess(Sales ~lag_05_France_building_permits ,newdata)
lines(newdata$lag_05_France_building_permits, predict(loess_fit), col = "blue")


#9 lag_04_Sales
plot( lag_04_Sales, Sales, xlab = "lag_04_Sales", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~lag_04_Sales), col="red")
# fit a loess line
loess_fit <- loess(Sales ~lag_04_Sales ,newdata)
lines(newdata$lag_04_Sales, predict(loess_fit), col = "blue")


#10 Germany_building_permits_nonres_currency
plot( Germany_building_permits_nonres_currency, Sales, xlab = "Germany_building_permits_nonres_currency", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~Germany_building_permits_nonres_currency), col="red")
# fit a loess line
loess_fit <- loess(Sales ~Germany_building_permits_nonres_currency ,newdata)
lines(newdata$Germany_building_permits_nonres_currency, predict(loess_fit), col = "blue")

#THE SCATTER PLOTS SHOW EXISTENCE OF NON LINEAR RELATIONS
