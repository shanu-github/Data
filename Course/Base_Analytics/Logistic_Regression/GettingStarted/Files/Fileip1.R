print(getwd())
# Set current working directory.
setwd("D://ip")
# Get and print current working directory.
print(getwd())
data <- read.csv("sample1.csv")
print(data)
print(is.data.frame(data))
print(ncol(data))
print(nrow(data))
print(names(data))
new_DF <- data[is.na(data$indx1),]
new_DF
print(max(data$indx5,na.rm=TRUE))
print(max(data$indx1,na.rm=TRUE))
