
#read the Adversting Data 
adversting_data<- read.csv("D:/work/Shanu/ATI/Base_Analytics/class4/Advertising.csv")

#Check the Structure of data
str(adversting_data)

#Check the summary of data, if any missing values NA 
summary(adversting_data)

#Check first few rows
head(adversting_data)

#Correlation
cor(adversting_data)

cor( adversting_data$TV, adversting_data$sales)

colnames(adversting_data)

#1. Is there a relationship between advertising sales and budget?
#A simple regression model of sales onto TV
reg_model<- lm(sales~TV, data=adversting_data)
summary(reg_model)

#A simple regression model of sales onto radio
reg_model<- lm(sales~radio, data=adversting_data)
summary(reg_model)
#A simple regression model of sales onto newspaper
reg_model<- lm(sales~newspaper, data=adversting_data)
summary(reg_model)

#A multiple regression model of sales onto TV, radio, and newspaper
reg_model<- lm(sales~., data=adversting_data)
reg_model<- lm(sales~ TV+radio+newspaper, data=adversting_data)

reg_model<- lm(sales~ TV+radio+newspaper+TV*radio+radio*newspaper+
                 TV*newspaper, data=adversting_data)

summary(reg_model)





reg_model<- lm(sales~ scale(TV)+scale(radio)+scale(newspaper), data=adversting_data)
summary(reg_model)

library(caret)
varImp(reg_model, scale = FALSE)

#2. How strong is the relationship?
#Two measures of model accuracy:RSE and R^2 RSE: Residual (y-yhat) standard error
# rsq is calculated by the following formuala
yhat=reg_model$fitted.values #predicted 
y=adversting_data$sales #observed 
rse<- sqrt(mean((y-yhat)^2))

rsq=1-sum((y-yhat)^2)/sum((y-mean(y))^2) #orginal formula

#3. Which media contribute to sales?
summary_reg_model<-summary(reg_model)
summary_reg_model$coefficients

#4. How large is the effect of each medium on sales?
confint(reg_model)
#The confidence intervals for TV and radio are narrow and far from zero, 
#providing evidence that these media are related to sales.
#But the interval for newspaper includes zero, indicating that the variable is not statistically significant 
#given the values of TV and radio.

#Could collinearity be the reason that the confidence interval associated with newspaper is so wide?
#Variation Inflation factor (vif) measures collinearity:
require(car)
vif(reg_model)

#5. How accurately can we predict future sales?
predict(reg_model, newdata=data.frame(TV=149,radio=22,newspaper=25),
        interval="confidence")

#6. Is the relationship linear?
#If the relationships are linear, then the residual plots should display no pattern.
fitted_data<- adversting_data
fitted_data$pred_Sales<- reg_model$fitted.values

fitted_data$error<- fitted_data$sales- fitted_data$pred_Sales
library(esquisse)
esquisse::esquisser()
library(ggplot2)
ggplot(data = fitted_data) +
  aes(x = sales, y = pred_Sales) +
  geom_point(color = "blue") 

ggplot(data = fitted_data) +
  aes(x = sales, y = error) +
  geom_point(color = "blue") 


ggplot(data = fitted_data) +
  aes(x = error) +
  geom_density(fill="red") +
  theme_minimal()

#7. Is there synergy among the advertising media?
#non-additive relationships model
model2 <- lm(sales~TV+radio+newspaper+TV*radio+
               TV*newspaper+newspaper*radio, data=adversting_data)
summary(model2 )


#Non-linear Transformations of the Predictors
lm(sales~.+I(TV^2), data=adversting_data)

lm(sales~TV+radio_newspaper+TV^2, data=adversting_data)

#comparsion between two models
anova(reg_model,model2)

#can also t.test for error in both the models