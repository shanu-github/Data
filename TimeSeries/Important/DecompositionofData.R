#PACKAGE
install.packages("TTR")
install.packages("fpp")

#Loading Libraries
library(fpp)
library(glmnet)
library(data.table)
library(TTR)


setwd("C:/Users/UAG1KOR/Desktop/Surabhi Docs/Working")
traindata <- read.csv("BorutaData.csv", header=TRUE, stringsAsFactors = F )
traindata <- as.data.frame(traindata)

#Decomposing Sales
ts_sales = ts(traindata$Sales, frequency = 12)
decompose_sales = decompose(ts_sales, "additive")
#Removing seasonality
adjust_sales = ts_sales - decompose_sales$seasonal
adjust_sales <- as.data.frame(adjust_sales)
plot(adjust_sales)

##
data(traindata)
ts_EU_OECD_LI100 = ts(EU_OECD_LI100, frequency = 12)

decompose_EU_OECD_LI100 = decompose(ts_EU_OECD_LI100, "additive")
adjust_EU_OECD_LI100 = ts_EU_OECD_LI100 - decompose_EU_OECD_LI100$seasonal
plot(adjust_EU_OECD_LI100)

#Decomposition of all indicators
mydata <- ts(traindata$EU_OECD_LI100, frequency= 12)
mydata <- decompose(mydata)

mydata

#
mydata <- ts(traindata$EU_GDP_Q, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$World_GDP_Q, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$EU_inflation, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$World_inflation, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$Germany_GDP_Q, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$EU_investment, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$Germany_investment, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$EU_consumption, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$Germany_consumption, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$Germany_PMI, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$EU_consumer, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$Germany_consumer, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$EU_oecd_li, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$Germany_oecd_li, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$EU_unemployment, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$Germany_unemployment, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$Germany_inflation, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$UK_inflation, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$EU_refinance_rate, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$UK_refinance_rate, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$EU_manu_prod, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$Germany_manu_prod, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$EU_manu_order, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$Germany_manu_order, frequency= 12)
mydata <- decompose(mydata)
mydata

#
mydata <- ts(traindata$EU_prod_mach, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Germany_prod_mach, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$EU_orders_mach, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Germany_orders_mach, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$EU_vehicle_prod, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Germany_vehicle_prod, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$EU_vehicle_order, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Germany_vehicle_order, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$EU15_prod_pc, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Germany_prod_pc, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$EU_building_permits, frequency= 12)
mydata <- decompose(mydata)

#
ts_France_building_permits <- ts(traindata$France_building_permits, frequency= 12)
decompose_France_building_permits <- decompose(ts_France_building_permits, "additive")
decompose_France_building_permits <- ts_france_building_permits - (decompose_France_building_permits$seasonal)
adjust_France_building_permits <- as.data.frame(adjust_France_building_permits)


decompose_sales = decompose(ts_sales, "additive")
adjust_sales = ts_sales - decompose_sales$seasonal
adjust_sales <- as.data.frame(adjust_sales)
plot(adjust_sales)

#
mydata <- ts(traindata$France_building_starts, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$France_building_permits_index, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Germany_building_permits_nonres_area, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Germany_building_permits_res, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Germany_building_permits_buildings_currency, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Germany_building_permits_nonres_currency, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Germany_building_permits_res_currency, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Germany_building_permits_res_index, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Spain_building_permits_res_sa, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$EU28_CPI, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$EU_monetary_CPI, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$France_CPI, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Germany_CPI, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Italy_CPI, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Spain_CPI, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$UK_CPI, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$EU_monetary_GDP_Q, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$France_GDP_Q, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Italy_GDP_Q, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Spain_GDP_Q, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$UK_GDP_Q, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$EU27_IP, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$EU_monetary_IP, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$France_IP, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Germany_IP, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Italy_IP, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Spain_IP, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$UK_IP, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$EU_monetary_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Germany_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$UK_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$AllCountries_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$World_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$EmergingMarkets_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Energy_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$EnergyEquipmentServices_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$OilGasFuels_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Materials_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$MaterialsMining_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Industrials_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$CapitalGoods_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Machinery_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$RoadRail_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$AutomobilesComponents_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$ConsumerDurablesApparel_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Financials_stocks, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Banks_stocks, frequency= 12)
mydata <- decompose(mydata)

		
#
mydata <- ts(traindata$Oil_price, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Metals_price, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$Iron_price, frequency= 12)
mydata <- decompose(mydata)

#
mydata <- ts(traindata$FreightRate, frequency= 12)
mydata <- decompose(mydata)












