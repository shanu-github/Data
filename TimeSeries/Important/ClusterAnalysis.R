#Calling packages
library(amap)
library(cluster)
library(factoextra)
library(stats)
library(dendextend)


#Reading and storing the data in R
setwd("C:/Users/UAG1KOR/Desktop/Surabhi Docs/Working")
cd <- read.csv("BorutaData.csv", header=TRUE, stringsAsFactors = F )
cd <- as.data.frame(cd)

#Normalizing the data
for (j in 3:ncol(cd)) {
  
  m <- mean(cd[,j])
  stddev <- sd(cd[,j])
  cd[,j] <- ((cd[,j]-m)/stddev)
}
#Data Tidying
cd<- na.omit(cd)

#Ccorrelation Matrix
x <- subset(cd, select = -c(1,2))
m <- cor(x)

#Dissimilarity matrix
dissimilarity <- 1 - cor(x)
distance <- as.dist(dissimilarity)
dist <- hclust(distance) #Creating distance matrix

#PLOTIING DENDROGRAM
dendogram <-plot(dist, 
                 main="Dissimilarity = 1 - Correlation", xlab="")












 

