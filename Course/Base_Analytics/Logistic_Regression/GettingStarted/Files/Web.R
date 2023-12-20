# install.packages("RCurl")
library(RCurl)
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
x <- getURL(URL)
## Or 
## x <- getURL(URL, ssl.verifypeer = FALSE)
out <- read.csv(textConnection(x))
head(out[1:6])

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile="reviews.csv",method="libcurl")



