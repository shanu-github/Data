
#csv file eading
#Comma Separated Values (CSV) files, which contain data values that are separated by , for example
#NAME,ADDRESS,EMAIL
#ABC,CITY A,abc@xyz.com
#LMN,CITY B,lmn@xyz.com

#Delimited files, which contain data values with a
# user-specified delimiter. This can be a \t tab or a symbol (#,&,||),
import pandas as pd

emp_data= pd.read_csv("D:\\work\\Learnings\\Softwares\\Python\\Classrom\\employee_data.csv")



data = {
    'CHN': {'COUNTRY': 'China', 'POP': 1_398.72, 'AREA': 9_596.96,
            'GDP': 12_234.78, 'CONT': 'Asia'},
    'IND': {'COUNTRY': 'India', 'POP': 1_351.16, 'AREA': 3_287.26,
            'GDP': 2_575.67, 'CONT': 'Asia', 'IND_DAY': '1947-08-15'},
    'USA': {'COUNTRY': 'US', 'POP': 329.74, 'AREA': 9_833.52,
            'GDP': 19_485.39, 'CONT': 'N.America',
            'IND_DAY': '1776-07-04'},
    'RUS': {'COUNTRY': 'Russia', 'POP': 146.79, 'AREA': 17_098.25,
            'GDP': 1_530.75, 'IND_DAY': '1992-06-12'},
    'JPN': {'COUNTRY': 'Japan', 'POP': 126.22, 'AREA': 377.97,
            'GDP': 4_872.42, 'CONT': 'Asia'},
    'CAN': {'COUNTRY': 'Canada', 'POP': 37.59, 'AREA': 9_984.67,
            'GDP': 1_647.12, 'CONT': 'N.America', 'IND_DAY': '1867-07-01'},
    'AUS': {'COUNTRY': 'Australia', 'POP': 25.47, 'AREA': 7_692.02,
            'GDP': 1_408.68, 'CONT': 'Oceania'}
}

columns = ('COUNTRY', 'POP', 'AREA', 'GDP', 'CONT', 'IND_DAY')

country_data = pd.DataFrame(data=data).T
country_data.to_csv('D:\\work\\Learnings\\Softwares\\Python\\Classrom\\country_data_windex.csv')
country_data.to_csv('D:\\work\\Learnings\\Softwares\\Python\\Classrom\\country_data.csv', index=False)


#The first column contains the row labels.
#If you don’t want to keep them, then you can pass the argument index=False to .to_csv().
df.to_csv('data.csv', index=False)

import os
os.getcwd()
os.chdir("D:\\work\\Learnings\\Softwares\\Python\\Classrom")

df = pd.read_csv('country_data_windex.csv', index_col=0)

#if we do not provide index column default index column will from 0 onwards
df = pd.read_csv('country_data.csv')
