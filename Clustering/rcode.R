Iris_data<-read.csv("C:\\Users\\hag5kor\\Desktop\\iris.data")

cluster_data<-Iris_data[c(1:4)]
# Determine number of clusters
wss <- (nrow(cluster_data)-1)*sum(apply(cluster_data,2,var))
variance_reduction<-1
for (i in 2:15) 
{
  wss[i] <- sum(kmeans(cluster_data,centers=i)$withinss)
  variance_reduction[i]<-(wss[i-1]-wss[i])/wss[i-1]
}

plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares") 
plot(1:15, variance_reduction, type="b", xlab="Number of Clusters", ylab="variance_reduction") 

(wss[1]-wss[2])/wss[1]
(wss[4])/wss[1]

d<-kmeans(cluster_data,centers=2)
cluster_data$cluster_no<-d$cluster



#Verifying within sum of square calcultion
sub_data<-subset(cluster_data,cluster_no==1)
for(i in 1:nrow(sub_data))
{
  sub_data$diff_mean[i]<-(sub_data[i,1]-d$centers[1,1])^2+(sub_data[i,2]-d$centers[1,2])^2+
    (sub_data[i,3]-d$centers[1,3])^2+(sub_data[i,4]-d$centers[1,4])^2
}
sum(sub_data$diff_mean)

sub_data<-subset(cluster_data,cluster_no==2)
for(i in 1:nrow(sub_data))
{
  sub_data$diff_mean[i]<-(sub_data[i,1]-d$centers[2,1])^2+(sub_data[i,2]-d$centers[2,2])^2+
    (sub_data[i,3]-d$centers[2,3])^2+(sub_data[i,4]-d$centers[2,4])^2
}
sum(sub_data$diff_mean)

d$withinss

#Total Within sum of square
d$tot.withinss

##verifying total sum of square
cluster_data<-Iris_data[c(1:4)]
mean_var<-apply(cluster_data,2,mean)
for(i in 1:nrow(cluster_data))
{
  cluster_data$diff_mean[i]<-(cluster_data[i,1]-mean_var[1])^2+(cluster_data[i,2]-mean_var[2])^2+
    (cluster_data[i,3]-mean_var[3])^2+(cluster_data[i,4]-mean_var[4])^2
}
sum(cluster_data$diff_mean)

d$totss

#% of variaance explained
(d$totss-d$tot.withinss)/d$totss

d$betweenss
d$size

#Visualization the clustering solution from K-means clustering with PCA components.
library(cluster)
clusplot(cluster_data[,1:4],d$cluster, color=TRUE, shade=FALSE,labels=4, lines=0)
sil.kmeans<-silhouette(d$cluster,dist(cluster_data[,1:4]))
min(sil.kmeans)

#K-Medoid Clustering
library(fpc)

fit.pam<-pamk(cluster_data[,1:4],metric="manhattan")
fit.pam$pamobject$clustering
#choose the number of clusters estimated by optimum average silhouette
k.pam<-fit.pam$nc
pam.result<-fit.pam$pamobject
pam.result$medoids
for(i in 1:k.pam){
  cat(paste("cluster ", i , ": ", sep=""))
  cat(colnames(pam.result$medoids)[which(pam.result$medoids[i,]>=1)],"\n")  
}

#Visualizing the clustering solution and the silhouette plot
layout(matrix(c(1,2),1,2))
plot(pam.result,label=4,lines=0,cex=0.8,col=pam.result$clustering)

