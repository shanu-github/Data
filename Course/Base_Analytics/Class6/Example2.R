url = 'http://www.biz.uiowa.edu/faculty/jledolter/DataMining/protein.csv'
food <- read.csv(url)
head(food)

#To decide on optimal clusters
wssplot <- function(data, nc=15, seed=1234){
  wss <- (nrow(data)-1)*sum(apply(data,2,var))
  for (i in 2:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
  plot(1:nc, wss, type="b", xlab="Number of Clusters",
       ylab="Within groups sum of squares")}

wssplot(scale(food[,-1]), nc=15) 

grpProtein <- kmeans(food[,-1], centers=8, nstart=10)
grpProtein

library(cluster)
clusplot(food[,-1], grpProtein$cluster, main='2D representation of the Cluster solution', 
         color=TRUE, shade=TRUE, labels=2, lines=0)

#https://rpubs.com/gabrielmartos/ClusterAnalysis

kmeans.predict(food[,-1],grpProtein)


clusters <- function(x, centers) {
  # compute squared euclidean distance from each sample to each cluster center
  tmp <- sapply(seq_len(nrow(x)),
                function(i) apply(centers, 1,
                                  function(v) sum((x[i, ]-v)^2)))
  print(tmp)
  max.col(-t(tmp))  # find index of min distance
}

clusters(scale(food[,-1]),grpProtein$centers)
#to know center in same scale

