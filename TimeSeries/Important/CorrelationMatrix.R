#Calling packages
library(corrplot)
library(glmnet)
library(data.table)
library(dplyr)

#Call file and read data into R
setwd("C:/Users/UAG1KOR/Desktop/Surabhi Docs/Working")
traindata <- read.csv("BorutaData.csv", header=TRUE, stringsAsFactors = F )
traindata <- as.data.frame(traindata)

#Readying data for cor function to take as input
ndata <- subset(traindata, select = c(34,35,38,65)) 
ndata <- subset(traindata, select = -c(DATE,Sales)) #either one can be used, mutually exclusively

#Correlation matrix
m <- cor(ndata)
fix(m)
corrplot(m, method = "circle", type = "upper") 


