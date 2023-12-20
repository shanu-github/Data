
# Data frame is a two-dimensional data structure, i.e., data is aligned in a tabular fashion in rows and columns.

#Create an Empty DataFrame
import pandas as pd
df = pd.DataFrame()
print(df)

#Create a DataFrame from Lists
#The DataFrame can be created using a single list or a list of lists

data = [1,2,3,4,5]
df = pd.DataFrame(data)
print(df)

data = [['Rahul',10],['Rohan',12],['Seema',13]]
df = pd.DataFrame(data,columns=['Name','Age'])
print(df)

#Create a DataFrame from Dict
data = {'Name':['Tom', 'Jack', 'Steve', 'Ricky'],'Age':[28,34,29,42]}
df = pd.DataFrame(data)
print(df)

#create a dataframe by reading files
emp_data= pd.read_csv("D:\\work\\Learnings\\Softwares\\Python\\Classrom\\employee_data.csv")

#get the column names
print(emp_data.columns)

#get the first 5 rows of data
emp_data.head()
emp_data.tail()

#to know the data type for each column
emp_data.dtypes

#-------------------------------------------------------------
#Data Selection using column names
emp_data['NAME']
emp_data[['NAME','GENDER']]


#Row Selection using index
emp_data.loc[0]
emp_data.loc[0:2]

#when using .loc it should be actual row index
sub_emp_data= emp_data[100:]
sub_emp_data.loc[0:3] #will provide empty dataframe

#using .iloc can be accessed when not sure about index
sub_emp_data.iloc[0:3]

#accessing columns and rows together
emp_data.loc[1:5, 'NAME']

emp_data.loc[1:5, ['NAME','GENDER']]

#.iloc should be used with indexes only
sub_emp_data.iloc[0:3, ['NAME','GENDER']] #gives an error
sub_emp_data.iloc[0:3, [1,5]]

#reset the index and can use .loc
sub_emp_data=sub_emp_data.reset_index(drop=True)
sub_emp_data.loc[0:3, ['NAME','GENDER']] #gives an error

#-----------------------------------------------------------
#get summary the data like min, max, mean, std, count
#By default gives only for numeric columns
emp_data.describe()

# list of dtypes to include
check= emp_data.describe(include= ['object'])

# we can call describe method for specific column as well
emp_data["GENDER"].describe()

#Dept and Gender wise average salary
emp_data.groupby(['DEPT','LOCATION'], as_index=True).agg(
    total_Genmonths=('FQ', 'count'),
    avg_FQ=('abs_FQ', 'mean'),
    avg_sd=('abs_FQ', 'std')).reset_index()

#--------------------------------------------------------------------------
#Data Cleaning
# removing null values
emp_data.dropna(inplace = True)
len(emp_data)

emp_data.dropna(subset = ['CTC','EMP ID'])

#filling NA with some value
emp_data['ANNUAL PERFORMANCE RATING'].fillna(0, inplace=True)

#removing the duplicate values
emp_data=emp_data.drop_duplicates()

#dropping particular column
emp_data.drop(['DEPT'],axis=1)

# transposing rows to columns

#Reshaping of data
#suppose for each dept, gender, location wise employee count

emp_data.groupby(['DEPT','LOCATION','GENDER'], as_index=True).agg(
    total_employee=('EMP ID', 'count')).reset_index()

#suppose you need LOCATION in columns
import numpy as np
employee_summary= emp_data.pivot_table(index=['DEPT','GENDER'],
                                  columns='LOCATION',values='EMP ID',
                                 fill_value=0, aggfunc='count').reset_index()

# Transforming LOCATION column to rows
temployee_summary = pd.melt(employee_summary, id_vars=['DEPT','GENDER'],
                            var_name="LOCATION", value_name="total_employee")
#---------------------------------------------------------------------------------------
#filtering data in dataframe
#suppose we want to know average salary of bangalore employee
#python is case sensitive
emp_data['LOCATION'].unique()
banglore_emp= emp_data[emp_data['LOCATION']=='Bangalore']
banglore_emp['CTC'].mean()
banglore_emp['CTC'].max()
banglore_emp['CTC'].min()

#suppose we want to get employee have more than 3 rating
good_emp= emp_data[emp_data['ANNUAL PERFORMANCE RATING']>3]

#suppose we want to know average salary of kolkata employee in accounts dept
#python is case sensitive
kolkata_emp= emp_data[(emp_data['LOCATION']=='Kolkata') & (emp_data['DEPT']=='Accounting')]
kolkata_emp['CTC'].mean()
kolkata_emp.describe()

#Filter employee for Bangalore and Kolkata location
sub_data= emp_data[(emp_data['LOCATION']=='Bangalore') | (emp_data['LOCATION']== 'Kolkata')]

#another way of filtering multiple values in dataframe
sub_data= emp_data[emp_data['LOCATION'].isin(['Bangalore','Kolkata'])]

#Data Type Transformation in python
emp_data.dtypes

emp_data['NAME']= emp_data['NAME'].astype('str')
emp_data['CTC']= emp_data['CTC'].astype('float')

emp_data['CTC']= emp_data['CTC'].apply(lambda x: int(x))

#Correct date column
#date format is very important for correct transformation
#https://docs.python.org/3/library/datetime.html#strftime-and-strptime-behavior
emp_data['DATE OF JOINING'].unique()
emp_data['DOJ']=emp_data['DATE OF JOINING'].apply(lambda x: pd.to_datetime(x,format='%A, %d %B %Y'))

#get the year of experience
emp_data['experience']=pd.datetime.now()-emp_data['DOJ']
emp_data['experience']= emp_data['experience'].dt.days/365

emp_data['experience'].describe()

