# -*- coding: utf-8 -*-
"""
Created on Thu Jul  6 16:54:05 2023

@author: HAG5KOR
"""
import numpy as np
import pandas as pd

path = "D:\\work\\Data_Science\\Interview_Preparation\\Decision_Tree\\"
data = pd.read_csv(path+ "play_data.csv")

#Spliting in Train and Test Data
from sklearn.model_selection import train_test_split
#X_train, X_test, y_train, y_test =  train_test_split(X,y,test_size = 0.25, random_state= 0)
train_data, test_data =  train_test_split(data,test_size = 0.25, random_state= 0)
X_train, X_test, y_train, y_test = train_test_split( X, y, test_size=0.4, random_state=0)


from sklearn.model_selection import KFold
kf = KFold(n_splits=3)

def get_score(model, X_train, X_test, y_train, y_test):
    model.fit(X_train, y_train)
    return model.score(X_test, y_test)

from sklearn.model_selection import StratifiedKFold
folds = StratifiedKFold(n_splits=3)

scores_logistic = []
scores_svm = []
scores_rf = []

for train_index, test_index in folds.split(digits.data,digits.target):
    X_train, X_test, y_train, y_test = digits.data[train_index], digits.data[test_index], \
                                       digits.target[train_index], digits.target[test_index]
    scores_logistic.append(get_score(LogisticRegression(solver='liblinear',multi_class='ovr'), X_train, X_test, y_train, y_test))  
    scores_svm.append(get_score(SVC(gamma='auto'), X_train, X_test, y_train, y_test))
    scores_rf.append(get_score(RandomForestClassifier(n_estimators=40), X_train, X_test, y_train, y_test))
    
    

#Doing the K-fold cross validation
from sklearn.model_selection import cross_val_score
clf = svm.SVC(kernel='linear', C=1, random_state=42)
scores = cross_val_score(clf, X, y, cv=5)
scores.mean()
scores.std()

#Chossing the other score metric in cross validation
from sklearn import metrics
scores = cross_val_score(clf, X, y, cv=5, scoring='f1_macro')
scores

from sklearn.model_selection import ShuffleSplit
n_samples = X.shape[0]
cv = ShuffleSplit(n_splits=5, test_size=0.3, random_state=0)
cross_val_score(clf, X, y, cv=cv)


#Stratified Sampling
from sklearn.model_selection import StratifiedKFold, KFold
skf = StratifiedKFold(n_splits=3)
cross_val_score(clf, X, y, cv=skf)

from sklearn.model_selection import KFold
kf = KFold(n_splits=3)
cross_val_score(clf, X, y, cv=kf)

model = tree.DecisionTreeClassifier(max_depth=4, random_state=42)
from sklearn.model_selection import cross_val_score
from sklearn.metrics import balanced_accuracy_score
cross_val_score(model, X_train, Y_train, cv=3,scoring= 'balanced_accuracy')


#The cross_validate function and multiple metric evaluation
from sklearn.model_selection import cross_validate
from sklearn.metrics import recall_score
scoring = ['precision_macro', 'recall_macro']
clf = svm.SVC(kernel='linear', C=1, random_state=0)
scores = cross_validate(clf, X, y, scoring=scoring)
sorted(scores.keys())
['fit_time', 'score_time', 'test_precision_macro', 'test_recall_macro']
scores['test_recall_macro']

scores = cross_validate(clf, X, y, scoring=scoring, cv=5, return_train_score=True)
scores = cross_validate(clf, X, y, scoring='precision_macro', cv=5, return_estimator=True)

#Time Series Split
from sklearn.model_selection import TimeSeriesSplit

X = np.array([[1, 2], [3, 4], [1, 2], [3, 4], [1, 2], [3, 4]])
y = np.array([1, 2, 3, 4, 5, 6])
tscv = TimeSeriesSplit(n_splits=3)
print(tscv)
TimeSeriesSplit(gap=0, max_train_size=None, n_splits=3, test_size=None)
for train, test in tscv.split(X):
     print("%s %s" % (train, test))
[0 1 2] [3]
[0 1 2 3] [4]
[0 1 2 3 4] [5]