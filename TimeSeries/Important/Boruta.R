#Calling packages
library(data.table)
library(Boruta)

#Reading data
setwd("C:/Users/UAG1KOR/Desktop/Surabhi Docs/Working")
traindata <- read.csv("BorutaData.csv", header=TRUE, stringsAsFactors = F )

#Converting into data frame
traindata <- as.data.frame(traindata)

#LAgged Variable Creation
for (j in 3:ncol(traindata)) 
{
  
  for (i in 1:12) {
    traindata <- cbind( traindata, shift(x = traindata[ ,j], n=i, fill=NA, type="lag"))
    names(traindata)[ncol(traindata)] <- sprintf( "lag_%02d_%s",i,colnames(traindata)[j])
    
  }
}

#Tidying Data
newdata <-na.omit(traindata)

#Boruta Run
set.seed(100)
boruta.train <- Boruta(Sales~.-DATE, data=newdata, doTrace=2)
final.boruta <- TentativeRoughFix(boruta.train)
getSelectedAttributes(final.boruta,withTentative=F)
print(final.boruta)

#Plotting Boruta Results
par(cex.axis=1, cex.lab=1, cex.main=1.2, cex.sub=1)
plot(final.boruta)








