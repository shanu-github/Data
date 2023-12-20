a<-'hello'
b<-2
c<-c(a,b)
save.image(file = "mydata.RData")
rm(a,b,c)
load("mydata.RData")
a
b
c
