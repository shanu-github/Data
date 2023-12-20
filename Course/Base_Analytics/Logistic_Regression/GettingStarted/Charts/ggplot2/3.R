# make some data
months <-rep(c("jan", "feb", "mar", "apr", "may", "jun", 
               "jul", "aug", "sep", "oct", "nov", "dec"), 2)
chickens <-c(1, 2, 3, 3, 3, 4, 5, 4, 3, 4, 2, 2)
eggs <-c(0, 8, 10, 13, 16, 20, 25, 20, 18, 16, 10, 8)
values <-c(chickens, eggs)
type <-c(rep("chickens", 12), rep("eggs", 12))
mydata <-data.frame(months, values)
library(ggplot2)

p <-ggplot(mydata, aes(months, valu


p <-ggplot(mydata, aes(months, values))
p +geom_bar(stat = "identity", aes(fill = type)) 
p +geom_bar(stat = "identity", aes(fill = type), position = "dodge")

df <- data.frame(dose=c("D0.5", "D1", "D2"),
                len=c(4.2, 10, 29.5))
head(df)

p<-ggplot(data=df, aes(x=dose, y=len)) +
  geom_bar(stat="identity")
p
   
# Horizontal bar plot
p + coord_flip()
p + scale_x_discrete(limits=c("D0.5", "D2"))