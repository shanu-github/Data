
#Missing value Treatment
titanic_data<- read.csv("D:/work/Shanu/ATI/Base_Analytics/class5/train.csv", stringsAsFactors = FALSE)

summary(titanic_data)
str(titanic_data)
#to count number of NA's/ missing value
sum(is.na(titanic_data))

#To count missing values in each column
colSums(is.na(titanic_data))

#To calculate percentage missing values in each column
colSums(is.na(titanic_data))/nrow(titanic_data)

apply(titanic_data,2, function(x) sum(is.na(x)))

#Be careful with categorical missing data
unique(titanic_data$Cabin)
apply(titanic_data,2, function(x) sum(x==""))
apply(titanic_data,2, function(x) sum(x=="")/length(x))

#To remove all rows contains NA
titanic_data[complete.cases(titanic_data), ]

#to remove row if age column contains NA
titanic_data[!(is.na(titanic_data$Age)),]

#replace NA value in age column with mean age
titanic_data[is.na(titanic_data$Age), 'Age'] = mean(titanic_data$Age, na.rm= TRUE)

# Create the function.
Mode <- function(x){
  a = table(x) # x is a vector
  return(names(a)[which.max(a)])
}

#replace NA value in age column with mode
titanic_data[titanic_data$Embarked, 'Embarked'] = Mode(titanic_data$Embarked)

#------------------------------------------------------------------------------------------------------
#outlier Detection
house_data<- read.csv("D:\\work\\Shanu\\ATI\\Base_Analytics\\class4\\Regression-Analysis-Data.csv")

remove_outliers <- function(x, na.rm = TRUE) {
  qnt <- quantile(x, probs=c(.25, .75), na.rm = TRUE)
  H <- 1.5 * IQR(x, na.rm = TRUE)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  return(y)
}

library(dplyr)
numeric_columns= colnames(select_if(house_data,is.numeric))

apply(house_data[,numeric_columns], 2, function(x) sum(is.na(remove_outliers(x))))

for( col in numeric_columns)
{
  house_data[,col]<- remove_outliers(house_data[,col])
}

#To remove all rows contains NA
nrow(house_data[complete.cases( house_data), ])/ nrow(house_data)

#------------------------------------------------------------------------------------------------
#model Validation
