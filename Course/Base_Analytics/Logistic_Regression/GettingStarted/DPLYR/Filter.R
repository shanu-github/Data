##install.packages("dplyr")
library(dplyr)
bigdata <- readRDS("D:\\RProgramme\\chicago.rds")
greatethan30 <- filter(bigdata , pm25tmean2 > 30)
str(greatethan30)

rs <- filter(bigdata , pm25tmean2 > 30 & tmpd > 80)
str(rs)