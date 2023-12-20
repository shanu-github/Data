# -*- coding: utf-8 -*-
"""
Created on Wed Jun 28 10:34:11 2023

@author: HAG5KOR
"""
#Creating function for Model Performance calculation 
def model_score(model, X_train, Y_train, X_test, Y_test):
    
    model.fit(X_train, Y_train)                           
    test_data['pred_outcome'] = model.predict(X_test)
    #Confusion Matrix
    print("Confusion Matix")
    print (test_data[['Outcome','pred_outcome']].value_counts())
    print (train_data['Outcome'].value_counts(normalize=True))
    print("Train Data Normal Accuracy ={}".format(model.score(X_train, Y_train)))
    print("Test Data Normal Accuracy ={}".format(model.score(X_test, Y_test)))
    from sklearn.metrics import balanced_accuracy_score
    bal_acc=balanced_accuracy_score(test_data['Outcome'], test_data['pred_outcome'])
    print("Test Data Balanced Accuracy ={}".format(bal_acc))
    
    from sklearn.metrics import classification_report
    print(classification_report(test_data['Outcome'], test_data['pred_outcome']))
    
    from sklearn.tree import export_text
    r = export_text(model, feature_names=input_variables)
    print(r)
    
import numpy as np
import pandas as pd
import seaborn as sns
from sklearn import tree
from sklearn.metrics import balanced_accuracy_score

path = "D:\\work\\Data_Science\\Interview_Preparation\\Decision_Tree\\"
data = pd.read_csv(path+ "diabetes.csv")

data.columns
data.info()
data.describe()

#check the data distribution
data['Outcome'].value_counts()

#We have imbalance data as class 0 is more than class 1
#As all values are filled and all numeric columns no data transformation required

#Split in train and test data 
from sklearn.model_selection import train_test_split
train_data, test_data= train_test_split(data, test_size=0.25, random_state= 123)
#We set random_state so that split in test train is same every time

input_variables= ['Pregnancies', 'Glucose', 'BloodPressure', 'SkinThickness', 'Insulin',
       'BMI', 'DiabetesPedigreeFunction', 'Age']
output_variable= ['Outcome']

X_train= train_data[input_variables]
Y_train= train_data[output_variable]

#Fitting the model
model= tree.DecisionTreeClassifier(random_state= 123)
model.fit(X_train, Y_train)

#Train and Test score
model.score(X_train, Y_train)

X_test= test_data[input_variables]
Y_test= test_data[output_variable]
model.score(X_test, Y_test)

train_data['pred_outcome']= model.predict(X_train)
test_data['pred_outcome'] = model.predict(X_test)

#Confusion Matrix
test_data[['Outcome','pred_outcome']].value_counts()

from sklearn.metrics import classification_report
print(classification_report(test_data['Outcome'], test_data['pred_outcome']))

#As we have training accuracy more than test accuracy, model is overfitting,
# lets try to decrese the depth of the decision tree
model.get_params()
model2= tree.DecisionTreeClassifier( max_depth= 3, random_state= 123)

model_score(model2, X_train, Y_train, X_test, Y_test)

#See though the accuracy s more than 75 % class 1 prediction is very poor not even 50 % we are able predict
# class 0 is dominationg in accuracy calculation,We need to take balanced accuracy measure which
#treats both class equally

#We can also observe just by setting the max_depth accuracy is improved for test data and
# also comparabable to train data
#Hence we are able to decrese the overfitting
# Now next question is what the optimal value of max_depth?
train_score= []
test_score=[]
for max_d in range(1,7):
  model = tree.DecisionTreeClassifier(max_depth=max_d, random_state=42)
  model.fit(X_train, Y_train)
  print('The Training Accuracy for max_depth {} is: {}'.format(max_d, model.score(X_train, Y_train)))
  print('The Validation Accuracy for max_depth {} is {}:'.format(max_d, model.score(X_test, Y_test)))
  bal_acc= balanced_accuracy_score(test_data['Outcome'], model.predict(X_test) )
  print("Validation Data Balanced Accuracy ={}".format(bal_acc))
  train_score.append(model.score(X_train, Y_train))
  test_score.append(model.score(X_test, Y_test))
  print('')

#Depth 4 looks the appropriate according to both Accuracy and balanced accuracy
import matplotlib.pyplot as plt
# summarize history for accuracy
plt.plot(train_score)
plt.plot(test_score)

#From plot max_depth= 3 looks the appropriate
# With small change in training whole decision tree can change and becomes unstable
# due to this we use cross validation 

model = tree.DecisionTreeClassifier(max_depth=4, random_state=42)
from sklearn.model_selection import cross_val_score
cross_val_score(model, X_train, Y_train, cv=3)

model = tree.DecisionTreeClassifier(max_depth=4, random_state=42)
from sklearn.model_selection import cross_val_score
from sklearn.metrics import balanced_accuracy_score
cross_val_score(model, X_train, Y_train, cv=3,scoring= 'balanced_accuracy')

#Randomize the order in tarning data and check the variation in model performance
import random
train_data1= train_data.reset_index(drop=True)
train_data1 = train_data1.reindex(random.sample(range(0, len(train_data1)), len(train_data1)))
X_train= train_data1[input_variables]
Y_train= train_data1[output_variable]

cross_val_score(model, X_train, Y_train, cv=3,scoring= 'balanced_accuracy')

#Now to find the optimal depth we can run model multiple times with different depth parameter
cross_val_score(tree.DecisionTreeClassifier(max_depth= 2, random_state= 123), X_train, Y_train,cv=3,
                      scoring= 'balanced_accuracy' )
cross_val_score(tree.DecisionTreeClassifier(max_depth= 3, random_state= 123),
                X_train, Y_train,cv=3,scoring= 'balanced_accuracy' )
cross_val_score(tree.DecisionTreeClassifier(max_depth= 4, random_state= 123),
                X_train, Y_train,cv=3,scoring= 'balanced_accuracy')

depths = [1,2,3,4,5,6]
avg_scores = {}

for d in depths:
    cv_scores = cross_val_score(tree.DecisionTreeClassifier(max_depth=d, random_state= 123),
                                X_train, Y_train, cv=3,scoring= 'balanced_accuracy')
    avg_scores['depth' + '_' + str(d)] = np.average(cv_scores)

print(avg_scores)
#Depth 4 has the highest accuracy we will go with depth=4

#We can use Grid Serch CV for finding multiple optimal parameters and further Pruning
from sklearn.model_selection import GridSearchCV
param_grid={'max_depth': [3,4,5], 'min_samples_split': [0.10,0.20, 0.25],
            'min_impurity_decrease':[0.01,0.02]}
grid_model = GridSearchCV(tree.DecisionTreeClassifier(class_weight= 'balanced',random_state= 1), param_grid,
                          cv=3, return_train_score=False,scoring= 'balanced_accuracy')
grid_model.fit(X_train, Y_train)
df = pd.DataFrame(grid_model.cv_results_)

#Get the best parameter and fit the model again on whole training data
grid_model.best_params_

#divide in train and test, do cross validation and also grid serach and take the minimum one for final model
final_model= tree.DecisionTreeClassifier(max_depth= 5, min_samples_split=0.10,
                                         min_impurity_decrease=0.01,random_state= 123)

model_score(final_model, X_train, Y_train, X_test, Y_test)                    

#further pruning of tree is required
 #----------------------------------------------------------------   
#Class 0 is dominating a lot as our class 0 records are more than class 1
# we can use class_weight parameter to balance it 
final_model= tree.DecisionTreeClassifier(max_depth= 4, min_samples_split=0.20,
                                         class_weight='balanced',random_state= 123)
model_score(final_model, X_train, Y_train, X_test, Y_test)

#Playing with Class weight
weights = {0:0.6, 1:0.4}
final_model= tree.DecisionTreeClassifier(max_depth= 3, min_samples_split=0.20,
                                         class_weight= weights,random_state= 123)
model_score(final_model, X_train, Y_train, X_test, Y_test)

weights = {0:0.4, 1:0.6}
final_model= tree.DecisionTreeClassifier(max_depth= 3, min_samples_split=0.20,
                                         class_weight= weights,random_state= 123)
model_score(final_model, X_train, Y_train, X_test, Y_test)

weights = {0:0.4, 1:0.7}
final_model= tree.DecisionTreeClassifier(max_depth= 3, min_samples_split=0.20,
                                         class_weight= weights,random_state= 123)
model_score(final_model, X_train, Y_train, X_test, Y_test)

param_grid={'max_depth': [1, 2,3,4,5], 'min_samples_split': [0.10,0.20],
            'class_weight':[{0:0.5,1:0.5}, {0:0.4,1:0.6}, {0:0.3,1:0.7}]}

grid_model = GridSearchCV(tree.DecisionTreeClassifier(random_state= 1), param_grid,
                          cv=3, return_train_score=False, scoring='balanced_accuracy' )
grid_model.fit(X_train, Y_train)


#Get the best parameter and fit the model again on whole training data
grid_model.best_params_

final_model= tree.DecisionTreeClassifier(max_depth= 3, min_samples_split=0.25,
                                         class_weight= 'balanced',random_state= 123)
model_score(final_model, X_train, Y_train, X_test, Y_test)

final_model= tree.DecisionTreeClassifier(max_depth= 3, min_samples_split=0.25,min_impurity_decrease=0.01,
                                         class_weight= 'balanced',random_state= 123)
model_score(final_model, X_train, Y_train, X_test, Y_test)

#Fixing the depth is important 
param_grid={'min_samples_split': [0.10,0.20, 0.25]}
grid_model = GridSearchCV(tree.DecisionTreeClassifier(random_state= 1,class_weight= 'balanced'), param_grid,
                          cv=3, return_train_score=False)
grid_model.fit(X_train, Y_train)
grid_model.best_params_

final_model= tree.DecisionTreeClassifier(min_samples_split=0.30,
                                         class_weight= 'balanced',random_state= 123)
model_score(final_model, X_train, Y_train, X_test, Y_test)

#Decision tree is high variance model, we reduce the variance by ensembling
from sklearn.ensemble import BaggingClassifier
from sklearn.tree import DecisionTreeClassifier
bag_model = BaggingClassifier(
    base_estimator=DecisionTreeClassifier(), 
    n_estimators=100, 
    max_samples=0.8, 
    oob_score=True,
    random_state=0
)
bag_model.fit(X_train, Y_train)
bag_model.oob_score_
bag_model.score(X_test, Y_test)

#Decision tree is varies a lot due to that we ensemble different trees using Random forest, 
#In Random forecast, random slection of samples with replacment and features happen

from sklearn.ensemble import RandomForestClassifier
model3 = RandomForestClassifier(random_state = 24, n_jobs = -1)
model3.fit( X_train, Y_train)

scores = cross_val_score(RandomForestClassifier(n_estimators=50), X_train, Y_train, cv=5)
scores.mean()




