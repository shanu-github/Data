# -*- coding: utf-8 -*-
"""
Created on Fri Nov 24 12:36:22 2023abT?fgt4A

@author: HAG5KOR
"""
https://www.youtube.com/watch?v=-r7wB9DJtiU&list=PL3N9eeOlCrP5cK0QRQxeJd6GrQvhAtpBK

import numpy as np
import pandas as pd
import seaborn as sns
import seaborn as sns
import matplotlib.pyplot as plt

from datetime import datetime
import plotly.express as px

from sklearn.ensemble import IsolationForest

df= pd.read_csv("D:/work/Data_Science/Interview_Preparation/TimeSeries/nyc_taxi.csv")
df.info()

#change datatype for date column
df['timestamp']= pd.to_datetime(df['timestamp'])

#Aggregate the dataset on hourly level
df= df.set_index('timestamp').resample('H').mean().reset_index()

fig= px.line(df.reset_index(), x='timestamp', y='value', title ='NYC Taxi Demand')
fig.update_xaxes(rangeslider_visible=True,)
fig.show()

df['hour']= df['timestamp'].dt.hour
df['weekday']= pd.Categorical(df['timestamp'].dt.strftime('%A'), categories =['Monday','Tuesday',
                                 'Wednesday', 'Thursday','Friday','Saturday','Sunday'])

#There might be monthly weekly or hourly seasonality
#isolation forest don't understand sesonality

df[['value','hour']].groupby('hour').mean().plot()
#it indicates there is hourly seasonality from midnight to early morning decline in number
#of cabs then slowly incresing in morning time and higher in evening time

df[['value','weekday']].groupby('weekday').mean().plot()
# There is weekly seasonality, weekdays and weekend have difference in number of cabs
df[df.isnull()]
#need to pass as feature so that isolation forest so that can understand the contextual anomalies
#data is out of context
df.groupby(['hour','weekday']).mean()['value'].unstack().plot()

df_final= df.join(df.groupby(['hour', 'weekday'])['value'].mean(),
                  on=['hour','weekday'], rsuffix='_avg')
'''
#Anomalous point
NYC Marathon: 2014-11-02
Thanksgivin -2014-11-27
christmas 2014-12-25
New year 2015-01-01
snow Blizzard -2015-01-26/27
'''

df_final['day']= df['timestamp'].dt.weekday

data = df_final[['value','hour','day']]

model= IsolationForest(contamination=0.005, max_samples=0.8, n_estimators= 200)
model.fit(data)


df_final['outliers']= pd.Series(model.predict(data)).apply(lambda x: 'yes' if (x==-1) else 'no')

df_final.query('outliers=="yes"')

score= model.decision_function(data)
plt.hist(score, bins=50)

df_final['score']=score

df_final.query('score<-0.02')












