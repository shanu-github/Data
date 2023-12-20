#predicting medical expenses using linear regression
insurance_data<- read.csv("D:/work/Shanu/ATI/Base_Analytics/class4/insurance.csv")

#Check the Structure of data
str(insurance_data)

#Check the summary of data, if any missing values NA 
summary(insurance_data)

#Check first few rows
head(insurance_data)

#--------------------------------------------------------------------------------------------------------
#Step2: Data Exploration
library(ggplot2)

#Charge Distribution
ggplot(insurance_data, aes(x =charges)) +  
  geom_histogram(binwidth = 10000)

#Is it more for smoker
ggplot(insurance_data, aes(x =charges, fill=smoker)) +  
  geom_histogram(binwidth = 10000)


ggplot(insurance_data, aes(x=smoker, y =charges)) +  
  geom_boxplot()

#Is it more for females
ggplot(insurance_data, aes(x=sex, y =charges)) +  
  geom_boxplot()

#Is it more for region
ggplot(insurance_data, aes(x=region, y =charges)) +  
  geom_boxplot()


#Is it more for more kids
ggplot(insurance_data, aes(x= as.factor(children), y =charges)) +   geom_boxplot()

#is it older people have more expense?
ggplot(insurance_data, aes(x=age,y =charges)) +   geom_point()

#is it older people have more expense? and differs in smoker
ggplot(insurance_data, aes(x=age,y =charges, color=smoker)) +   geom_point()

#is it obess people have more expense?
ggplot(insurance_data, aes(x=bmi,y =charges)) +   geom_point()

#is it obess people have more expense? and differs in smoker
ggplot(insurance_data, aes(x=bmi,y =charges, color=smoker)) +   geom_point()

table(insurance_data$region)

table(insurance_data$sex)

cor(insurance_data[c("age", "bmi", "children", "charges")])
pairs(insurance_data[c("age", "bmi", "children", "charges")])

#age and bmi appear to have a moderate correlation, meaning that as age increases, so does bmi. 
#There is also a moderate correlation between age and charges, bmi and charges, and children and charges.
#----------------------------------------------------------------------------------------------------
#Step 3 - training a model on the data
ins_model <- lm(charges ~ age + children + bmi + sex +
                  smoker + region, data = insurance_data)

ins_model <- lm(charges ~ ., data = insurance)
#---------------------------------------------------------------------------------------------------
#Step 4 - evaluating model performance
summary(ins_model )

insurance_data$predicted_charges= ins_model$fitted.values
#charges vs predicted charges
ggplot(insurance_data, aes(x=predicted_charges,y =charges)) +   geom_point(color= "blue")

#error with charge
ggplot(insurance_data, aes(x=charges,y =ins_model$fitted.values-charges)) +   geom_point(color= "blue")

#Error distribution
ggplot(insurance_data, aes(x=ins_model$fitted.values-charges)) +   geom_density()

summary(ins_model$fitted.values-charges)
#------------------------------------------------------------------------------------------------------
#Step 5 - improving model performance with additional features
insurance_data$age2 <- insurance_data$age^2
insurance_data$bmi30 <- ifelse(insurance_data$bmi >= 30, 1, 0)


ins_model2 <- lm(charges ~ age + age2 + children + bmi + sex +
                   bmi30*smoker + region, data = insurance_data)

summary(ins_model2)

#-----------------------------------------------------------------------------------------------
#Model Test , Divide into train and test
train_data <- insurance_data %>% sample_frac(.75)
#anti_join delete the data if present in other
test_data  <- anti_join(insurance_data, train_data) 

ins_model2 <- lm(charges ~ age + age2 + children + bmi + sex +
                   region, data = train_data)

test_data$predict_charge<- predict(ins_model2, newdata = test_data[, c('age', 'age2', 'children',
                                                                       'bmi', 'sex','region')])

#charges vs predicted charges
ggplot(test_data, aes(x=charges,y =predict_charge)) +   geom_point(color= "blue")

