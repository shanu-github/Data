
library(fpp)
devtools::install_github("ellisp/forecastxgb-r-package/pkg")
library(forecastxgb)
model <- xgbar(gas)
fc <- forecast(model, h = 12)
plot(fc)
summary(model)

consumption <- usconsumption[ ,1]
income <- matrix(usconsumption[ ,2], dimnames = list(NULL, "Income"))
consumption_model <- xgbar(y = consumption, xreg = income)
summary(consumption_model)


library(forecast)
ts_data<-c(1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0,
           1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0,
           1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0,
           1,2,3,4,5,6,7,8,9,0,0,0,0, 1,2,3,4,5,6,7,8,9,0,0,0,0,
           1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9)

ts_data<- ts(ts_data, frequency=1)

auto.arima(ts_data)

acf(ts_data)

forecast(ts_data, h=6)

plot(ts_data)

library(PSF)
psf(ts_data, h=6)

p <- psf(ts_data)
## Forecast the next 12 values of such time series.
pred <- predict(p, n.ahead = 24)
## Plot forecasted values.
plot(p, pred)

fourier(ts_data, K=2)

auto.arima(ts_data, xreg=fourier(ts_data,K=1), seasonal=FALSE)

library(forecast)
gas <- ts(read.csv("https://robjhyndman.com/data/gasoline.csv", header=FALSE)[,1], 
          freq=365.25/7, start=1991+31/365.25)
plot(gas)
bestfit <- list(aicc=Inf)
for(i in 1:25)
{
  fit <- auto.arima(gas, xreg=fourier(gas, K=i), seasonal=FALSE)
  if(fit$aicc < bestfit$aicc)
    bestfit <- fit
  else break;
}
fc <- forecast(bestfit, xreg=fourier(gas, K=12, h=104))
plot(fc)

ts_data<--1*ts_data

convert_ts_data<-ts(ts_data,frequency=find.freq(ts_data))
model= auto.arima(convert_ts_data)
plot(forecast(model,h=9))

model= stlf(convert_ts_data)
plot(forecast(model,h=9))

model= ets(convert_ts_data)
plot(forecast(model,h=9))

library(PSF)
## Train a PSF model from the univariate time series 'nottem' (package:datasets).
p <- psf(ts_data,cycle =find.freq(ts_data))
## Forecast the next 12 values of such time series.
pred <- predict(p, n.ahead = 24)
## Plot forecasted values.
plot(p, pred)

model= snaive(convert_ts_data)
plot(forecast(model,h=9))

model= tbats(convert_ts_data)
plot(forecast(model,h=9))

model= bats(convert_ts_data)
plot(forecast(model,h=9))

library(forecastxgb)
model=xgbar(convert_ts_data)
plot(forecast(model,h=9))

fit_ets<-xgbar(Training_data)
#prediction
sales_pred <- forecast(fit_ets, h=Forecast_horizon)

model= thetaf(convert_ts_data,h=9)
plot(model)

#not good Model
library(MAPA)
model=mapaest(convert_ts_data)
mapafor(convert_ts_data, model,fh=9)


findfrequency(ts_data)

find.freq <- function(x)
{
  n <- length(x)
  spec <- spec.ar(c(x),plot=FALSE)
  if(max(spec$spec)>10) # Arbitrary threshold chosen by trial and error.
  {
    period <- round(1/spec$freq[which.max(spec$spec)])
    if(period==Inf) # Find next local maximum
    {
      j <- which(diff(spec$spec)>0)
      if(length(j)>0)
      {
        nextmax <- j[1] + which.max(spec$spec[j[1]:500])
        period <- round(1/spec$freq[nextmax])
      }
      else
        period <- 1
    }
  }
  else
    period <- 1
  return(period)
}

plot(decomp(convert_ts_data))

