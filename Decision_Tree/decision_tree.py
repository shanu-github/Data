# -*- coding: utf-8 -*-
"""
Created on Wed Jun 21 16:09:39 2023

@author: HAG5KOR
"""
import numpy as np
import pandas as pd
import seaborn as sns
from sklearn import tree

from sklearn.datasets import load_iris
from sklearn import tree
iris = load_iris()
X, y = iris.data, iris.target
clf = tree.DecisionTreeClassifier()
clf = clf.fit(X, y)
tree.plot_tree(clf)

path = "D:\\work\\Data_Science\\Interview_Preparation\\Decision_Tree\\"
data = pd.read_csv(path+ "play_data.csv")

# Input and Output
data.columns
data = pd.get_dummies(data, columns = ['Outlook', 'Humidity', 'Wind'])
data['Play'].unique()
play_code= {'No':0, 'Yes':1}

data['CPlay']= data['Play'].apply(lambda x: play_code[x])

data.columns


#Splitting The Data in Train and Test/Validation
from sklearn.model_selection import train_test_split
#X_train, X_test, y_train, y_test =  train_test_split(X,y,test_size = 0.25, random_state= 0)
train_data, test_data =  train_test_split(data,test_size = 0.25, random_state= 0)

X_train = train_data.loc[:,['Outlook_Overcast', 'Outlook_Rain', 'Outlook_Sunny',
       'Humidity_High', 'Humidity_Normal', 'Wind_Strong', 'Wind_Weak']]
y_train = train_data[['CPlay']]

#Fitting The Model
from sklearn.tree import DecisionTreeClassifier
classifier = DecisionTreeClassifier()
classifier.fit(X_train,y_train)

from sklearn.tree import export_text
r = export_text(classifier, feature_names=['Outlook_Overcast', 'Outlook_Rain', 'Outlook_Sunny',
     'Humidity_High', 'Humidity_Normal', 'Wind_Strong', 'Wind_Weak'])
print(r)

#Prediction for validation data
X_test = test_data.loc[:,['Outlook_Overcast', 'Outlook_Rain', 'Outlook_Sunny',
       'Humidity_High', 'Humidity_Normal', 'Wind_Strong', 'Wind_Weak']].values

test_data['Pred_Play']=classifier.predict(X_test)
test_data[['prob_NPlay','prob_Play']]=classifier.predict_proba(X_test)

#Confusion Matrix
test_data[['CPlay','Pred_Play']].value_counts()

from sklearn.metrics import accuracy_score, confusion_matrix

feature_df = pd.DataFrame({
    'feature':X_train.columns,
    'importance': classifier.feature_importances_
}).sort_values('importance', ascending=False)