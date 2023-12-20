#Libraries loaded
library(glmnet)
library(data.table)
library(dplyr)
library(relaimpo)
library(ggfortify)
library(xlsx)

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

####SCATTER PLOTS FOR THE TOP TEN INDICATORS

                           ######################################################################
#1
attach(newdata)
plot( lag_05_Spain_IP, Sales, xlab = "lag_05_Spain_IP", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~lag_05_Spain_IP), col="red")

# fit a loess line
loess_fit <- loess(Sales ~lag_05_Spain_IP ,newdata)
lines(newdata$lag_05_Spain_IP, predict(loess_fit), col = "blue")

#2
attach(newdata)
plot( lag_12_Sales, Sales, xlab = "lag_12_Sales", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~lag_12_Sales), col="red")

# fit a loess line
loess_fit <- loess(Sales ~lag_12_Sales ,newdata)
lines(newdata$lag_12_Sales, predict(loess_fit), col = "blue")

##########
attach(newdata)
plot( World_GDP_Q, Sales, xlab = "World_GDP_Q", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~lag_12_Sales), col="red")

#3
attach(newdata)
plot( Germany_prod_pc, Sales, xlab = "Germany_prod_pc", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~Germany_prod_pc), col="red")

# fit a loess line
loess_fit <- loess(Sales ~Germany_prod_pc ,newdata)
lines(newdata$Germany_prod_pc, predict(loess_fit), col = "blue")


#4
attach(newdata)
plot( lag_08_Germany_stocks, Sales, xlab = "lag_08_Germany_stocks", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~lag_08_Germany_stocks), col="red")

# fit a loess line
loess_fit <- loess(Sales ~lag_08_Germany_stocks ,newdata)
lines(newdata$lag_08_Germany_stocks, predict(loess_fit), col = "blue")

#5
attach(newdata)
plot( EU15_prod_pc, Sales, xlab = "EU15_prod_pc", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~EU15_prod_pc), col="red")

# fit a loess line
loess_fit <- loess(Sales ~EU15_prod_pc ,newdata)
lines(newdata$EU15_prod_pc, predict(loess_fit), col = "blue")

#6
attach(newdata)
plot( lag_01_EmergingMarkets_stocks, Sales, xlab = "lag_01_EmergingMarkets_stocks", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~lag_01_EmergingMarkets_stocks), col="red")

# fit a loess line
loess_fit <- loess(Sales ~lag_01_EmergingMarkets_stocks ,newdata)
lines(newdata$lag_01_EmergingMarkets_stocks, predict(loess_fit), col = "blue")

#7
attach(newdata)
plot( lag_10_Spain_GDP_Q, Sales, xlab = "lag_10_Spain_GDP_Q", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~lag_10_Spain_GDP_Q), col="red")

# fit a loess line
loess_fit <- loess(Sales ~lag_10_Spain_GDP_Q ,newdata)
lines(newdata$lag_10_Spain_GDP_Q, predict(loess_fit), col = "blue")

#8
attach(newdata)
plot( lag_05_France_building_permits, Sales, xlab = "lag_05_France_building_permits", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~lag_05_France_building_permits), col="red")

# fit a loess line
loess_fit <- loess(Sales ~lag_05_France_building_permits ,newdata)
lines(newdata$lag_05_France_building_permits, predict(loess_fit), col = "blue")

#9
attach(newdata)
plot( lag_04_Sales, Sales, xlab = "lag_04_Sales", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~lag_04_Sales), col="red")

# fit a loess line
loess_fit <- loess(Sales ~lag_04_Sales ,newdata)
lines(newdata$lag_04_Sales, predict(loess_fit), col = "blue")

#10
attach(newdata)
plot( Germany_building_permits_nonres_currency, Sales, xlab = "Germany_building_permits_nonres_currency", ylab = "Sales", pch=3)
title("Scatter Plot")
abline(lm(Sales~Germany_building_permits_nonres_currency), col="red")

# fit a loess line
loess_fit <- loess(Sales ~Germany_building_permits_nonres_currency ,newdata)
lines(newdata$Germany_building_permits_nonres_currency, predict(loess_fit), col = "blue")

