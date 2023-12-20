
#------------------------------------------------------------------------------------
#Z Value
#P(Z<=0) = 0.5
pnorm(0, mean=0,sd=1)

#P(Z<=1.93)= 0.9732
pnorm(1.93, mean=0,sd=1)

#P(Z<=-1.65)=  1- P(1.65) = 1- 0.9505 =0.05
pnorm(-1.65, mean=0,sd=1)

#P(-1.65 < Z ??? 1.93)

pnorm(1.93, mean=0,sd=1)- pnorm(-1.65, mean=0,sd=1)

#P(Z ??? -0.69)
pnorm(-0.69, mean=0,sd=1)
#P(0.85 < Z ??? 2.23)
pnorm(2.23, mean=0,sd=1)- pnorm(0.85, mean=0,sd=1)

pnorm(0.85, mean=0,sd=1)- pnorm(2.23, mean=0,sd=1)

#what % of students scored more than 940
#mean= 850, std= 100
#P(X>940)
1- pnorm(940, mean= 850, sd=100)

pnorm(250, mean= 255, sd=2.5)


z_value= (940-850)/100
1- pnorm(z_value, mean=0, sd=1)

pnorm(57, mean=43, sd=14)-pnorm(22, mean= 43, sd=14)

#P(Z > 1.75)
1-pnorm(1.75, mean=0, sd=1)
pnorm(-1.75, mean=0, sd=1)
pnorm(1.75, mean=0, sd=1, lower.tail = FALSE)

#to get Z value according to probability
qnorm(0.5)
qnorm(1)
qnorm(0.75)

#--------------------------
(factorial(12)/(factorial(12-4)* factorial(4)))* (0.2^4)*(0.8^8)


factorial(10)/(factorial(3)* factorial(10-3))

#sampling Distribution
cash= seq(0, 19, by=1)
sample_size=8
num_samples= 200
sample_means <- rep(NA, num_samples)

for(i in 1:num_samples){
  samp <- sample(cash, sample_size)
  sample_means[i] <- mean(samp)
}

hist(sample_means)
mean(sample_means)
mean(iris$Sepal.Length)

#-----------------------------------------------------------------------------------------------
#hypothesis Testing
library(rio)
setwd("D:\\work\\Learnings\\ATI\\R_Basics\\")
getwd()
file_path="EmpData.csv"
employee_data<- import(file_path)

library(lubridate)

employee_data$`DATE OF JOINING`<-dmy(employee_data$`DATE OF JOINING`)


library(esquisse)
esquisse::esquisser()

unique(employee_data$LOCATION)
bangalore_employee<- employee_data[employee_data$LOCATION=="Bangalore",]
summary(bangalore_employee$CTC)
#Newspaper agency told in bangalore average CTC is 5 lakhs (500000)
#two sample t-test
#H0=5 Lakhs , HA!=5 lakhs
t.test(bangalore_employee$CTC, mu = 500000, alternative = "two.sided")

#Newspaper agency told in bangalore average CTC is more than 5 lakhs (500000)
# One-sample t-test
#H0>=5 Lakhs , HA<5 lakhs
t.test(bangalore_employee$CTC, mu = 500000, alternative = "less") 


#Newspaper agency told in bangalore average CTC is less than 5 lakhs (500000)
# One-sample t-test
#H0<=5 Lakhs , HA>5 lakhs
t.test(bangalore_employee$CTC, mu = 500000, alternative = "greater") 