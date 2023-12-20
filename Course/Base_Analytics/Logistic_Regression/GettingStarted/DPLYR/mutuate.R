##install.packages("dplyr")
library(dplyr)
bigdata <- readRDS("D:\\RProgramme\\chicago.rds")
bigdata <- rename(bigdata , dewpoint = dptp, pm25 = pm25tmean2)
head(bigdata)

bigdata<- mutate(bigdata, pm25detrend = pm25 - mean(pm25, na.rm = TRUE))
head(bigdata)