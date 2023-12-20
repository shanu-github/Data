
#Link to Read : http://www.sthda.com/english/wiki/one-sample-t-test-in-r
#Here, we'll use an example data set containing the weight of 10 mice.
#We want to know, if the average weight of the mice differs from 25g?
set.seed(1234)
my_data <- data.frame(
  name = paste0(rep("M_", 10), 1:10),
  weight = round(rnorm(10, 20, 2), 1)
)

#We want to know, if the average weight of the mice differs from 25g (two-tailed test)?
# One-sample t-test
#H0==25 g
#HA!=25g

t.test(my_data$weight, mu = 25, alternative = "two.sided")
 

#if you want to test whether the mean weight of mice is less than 25g (one-tailed test), type this:
#H0>=25
#HA<25
t.test(my_data$weight, mu = 25,       alternative = "less")

#Or, if you want to test whether the mean weight of mice is greater than 25g (one-tailed test), type this:
#H0<=25
#HA>25
t.test(my_data$weight, mu = 25,      alternative = "greater")  

#----------------------------------------------------------------------------------------------------------
#proportion test

prop.test(x=12,n=20,p=0.50, alternative = "two.sided")

prop.test(x=73,n=100,p=0.80, alternative = "two.sided")


#--------------------------------------------------------------------------------
#two sample t.test
#-------------------------------------------------------------------------------
#Example 1

data("mtcars")

library(ggplot2)
ggplot(data = mtcars) +
  aes(x = mpg, fill = as.factor(am)) +  geom_density(adjust = 1) +  theme_minimal()

t.test(mpg ~ am, data=mtcars, alternative="two.sided")

unique(mtcars$am)
t.test(mtcars[mtcars$am==1,'mpg'],mtcars[mtcars$am==0,'mpg'], data=mtcars, alternative="two.sided")

t.test(mtcars[mtcars$am==1,'mpg'],mtcars[mtcars$am==0,'mpg'], data=mtcars, alternative="greater")

t.test(mtcars[mtcars$am==1,'mpg'],mtcars[mtcars$am==0,'mpg'], data=mtcars, alternative="less")

#Example 2
#Here, we'll use an example data set, which contains the weight of 18 individuals (9 women and 9 men):
# Data in two numeric vectors
women_weight <- c(38.9, 61.2, 73.3, 21.8, 63.4, 64.6, 48.4, 48.8, 48.5)
men_weight <- c(67.8, 60, 63.4, 76, 89.4, 73.3, 67.3, 61.3, 62.4) 
# Create a data frame
my_data <- data.frame( 
  group = rep(c("Woman", "Man"), each = 9),
  weight = c(women_weight,  men_weight)
)

#Question : Is there any significant difference between women and men weights?
t.test(women_weight, men_weight)

t.test(weight~group, my_data)

#if you want to test whether the average men's weight is less than the average women's weight, type this:
t.test(weight ~ group, data = my_data, alternative = "less")

t.test(women_weight, men_weight, data = my_data, alternative = "less")

#Or, if you want to test whether the average men's weight is greater than the average women's weight, type this
t.test(weight ~ group, data = my_data,  alternative = "greater")

t.test(women_weight, men_weight, data = my_data, alternative = "greater")

#http://www.sthda.com/english/wiki/unpaired-two-samples-t-test-in-r


#Example 3 from ppt
class_marks<-data.frame(score=c(35,51,66,42,37,46,60,55,53,c(52,87,76,62,81,71,55,67)),
           class= c(rep(1,9),rep(2,8)))

t.test(score~class, data=class_marks)


#(((107.7444/8)+(151.29/7))^2)/(((1/8)*(107.7444/8)^2)+((1/7)*( 151.29/7)^2))

#--------------------------------------------------------------------------------------------------------------------
#paired T-test
#As an example of data, 20 mice received a treatment X during 3 months.
#We want to know whether the treatment X has an impact on the weight of the mice.
#To answer to this question, the weight of the 20 mice has been measured before and after the treatment.
#This gives us 20 sets of values before treatment and 20 sets of values after treatment
#from measuring twice the weight of the same mice.

# Data in two numeric vectors
# ++++++++++++++++++++++++++
# Weight of the mice before treatment
before <-c(200.1, 190.9, 192.7, 213, 241.4, 196.9, 172.2, 185.5, 205.2, 193.7)
# Weight of the mice after treatment
after <-c(392.9, 393.2, 345.1, 393, 434, 427.9, 422, 383.9, 392.3, 352.2)
# Create a data frame
my_data <- data.frame( 
  group = rep(c("before", "after"), each = 10),
  weight = c(before,  after)
)
#We want to know, if there is any significant difference in the mean weights after treatment?
t.test(before, after, paired = TRUE)

#if you want to test whether the average weight before treatment is less than the average weight after treatment, type this:
t.test(weight ~ group, data = my_data, paired = TRUE,
       alternative = "less")

#Or, if you want to test whether the average weight before treatment is greater than the average weight after treatment, type this
t.test(weight ~ group, data = my_data, paired = TRUE,
       alternative = "greater")

#http://www.sthda.com/english/wiki/paired-samples-t-test-in-r

library(MASS)
data(immer)
head(immer)

#------------------------------------------------------------------------------------------------------
#Anova: http://www.sthda.com/english/wiki/one-way-anova-test-in-r
my_data<-PlantGrowth

# Show the levels
levels(my_data$group)

library(dplyr)
group_by(my_data, group) %>%
  summarise(
    count = n(),
    mean = mean(weight, na.rm = TRUE),
    sd = sd(weight, na.rm = TRUE)
  )

#box plot
ggplot(my_data, aes(x= group, y=weight))+ geom_boxplot()+geom_jitter()


# Compute the analysis of variance
res.aov <- aov(weight ~ group, data = my_data)
# Summary of the analysis
summary(res.aov)

TukeyHSD(res.aov)

#As the p-value is less than the significance level 0.05, 
#we can conclude that there are significant differences between the groups highlighted with "*" in the model summary.

head(PlantGrowth)

#Example 2
#Is there difference in sepal length between flowers?
data(iris)

your.aov = aov(iris$Sepal.Length ~ iris$Species)
summary(your.aov)

#which flower how much different?
TukeyHSD(your.aov)

aggregate(Sepal.Length~Species, data=iris, mean)

#-----------------------------------------------------------------------------------
# Import the data

chisq.test(x=c(73, 100-73),p=c(0.83,1-0.83))

chisq.test(x=c(73,38,18),p=c(0.60,0.28,0.12))


file_path <- "http://www.sthda.com/sthda/RDoc/data/housetasks.txt"
housetasks <- read.delim(file_path, row.names = 1)



#The data is a contingency table containing 13 housetasks and their distribution in the couple:
#  rows are the different tasks
#values are the frequencies of the tasks done :
#  by the wife only
#alternatively
#by the husband only
#or jointly

chisq <- chisq.test(housetasks)
chisq


chisq.test(c(29,12,61), c(8,47, 56))

table(c(29,12,61), c(8,47, 56))


chisq.test(as.table(rbind(c(72,48), c(489,530))))

chisq.test(as.table(rbind(c(29,12,61), c(8,47,56))))



as.table(x)

#ChiSquare Test


library(esquisse)
esquisse::esquisser()









qnorm(0.05)














