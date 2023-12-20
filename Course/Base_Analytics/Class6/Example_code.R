#Clustering of flowers
library(datasets)
head(iris)
#--------------------------------------------------------------------------------------
#Data Exploration
library(ggplot2)
ggplot(iris, aes(x=Petal.Length, y=Petal.Width,
                 color = Species)) + geom_point(size=)

#----------------------------------------------------------------------------------------
#Divide into train and test
library(dplyr)
train_data <- iris %>% sample_frac(.75)
#anti_join delete the data if present in other
test_data  <- anti_join(iris, train_data)

#------------------------------------------------------------------------------
#Scaling of Data
scaled_train_data<- train_data
scaled_test_data<- test_data

for(col in c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width" ))
{
  scaled_train_data[,col]= (train_data[,col]- mean(train_data[,col]))/ sd(train_data[,col])
  scaled_test_data[,col]= (test_data[,col]- mean(train_data[,col]))/ sd(train_data[,col])
}

#------------------------------------------------------
set.seed(20)
irisCluster <- kmeans(scaled_train_data[, 3:4], 3, nstart = 20)
irisCluster

#Since we know that there are 3 species involved, we ask the algorithm to group the data into 3 clusters,
#and since the starting assignments are random, we specify nstart = 20.
#This means that R will try 20 different random starting assignments and then select the one with 
#the lowest within cluster variation.
#We can see the cluster centroids, the clusters that each data point was assigned to, and the within cluster variation.

#-------------------------------------------------------
# to Analyze the performance
table(irisCluster$cluster, train_data$Species)

library(cluster)
clusplot(train_data[,3:4], irisCluster$cluster, main='2D representation of the Cluster solution',
         color=TRUE, shade=TRUE,
         labels=2, lines=0)

#---------------------------------------------------------------------------------------
#To decide on optimal clusters
wssplot <- function(data, nc=15, seed=1234){
  wss <- (nrow(data)-1)*sum(apply(data,2,var))
  for (i in 2:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
  plot(1:nc, wss, type="b", xlab="Number of Clusters",
       ylab="Within groups sum of squares")}

wssplot(scaled_train_data[, 3:4], nc=20) 

#--------------------------------------------------------------------------------
#prediction for new data
clusters <- function(x, centers) {
  # compute squared euclidean distance from each sample to each cluster center
  tmp <- sapply(seq_len(nrow(x)),
                function(i) apply(centers, 1,
                                  function(v) sum((x[i, ]-v)^2)))
  #print(tmp)
  max.col(-t(tmp))  # find index of min distance
}
clusters(scaled_test_data[, 3:4],irisCluster$centers)


table(test_data$Species,
      clusters( scaled_test_data[, 3:4],irisCluster$centers) )

#-----------------------------------------------------------------------------------
#further exploration

#to know center in same scale
aggregate(train_data[, 3:4], by=list(cluster=irisCluster$cluster), mean)

par(mfrow=c(2,2))
pie(colSums(iris[irisCluster$cluster==1,3:4]),cex=0.5)

pie(colSums(iris[irisCluster$cluster==2,3:4]),cex=0.5)

pie(colSums(iris[irisCluster$cluster==3,3:4]),cex=0.5)

#----------------------------------------------------------
url = 'http://www.biz.uiowa.edu/faculty/jledolter/DataMining/protein.csv'
food <- read.csv(url)
head(food)
