##install.packages("dplyr")
library(dplyr)
bigdata <- readRDS("D:\\RProgramme\\chicago.rds")
bigdata <- arrange(bigdata , date)
bigdata 
head(bigdata,5)
tail(bigdata,5)
bigdata <- arrange(bigdata , desc(date))
bigdata 

