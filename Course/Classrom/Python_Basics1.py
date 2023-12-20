# -*- coding: utf-8 -*-
"""
Created on Tue Apr  5 23:00:45 2022

@author: HAG5KOR
"""
#To get the current working 
import os
os.getcwd()

#To change the working directory
os.chdir("C:\\Users\\hag5kor\\Desktop\\Python_ Course\\")

os.chdir("C:/Users/hag5kor/Desktop/Python_ Course/")

#can be used as calculator
#mathemtical calculations
#Addition of Two Numbers
12+15
#Subtraction of two numbers
34-14
#Multiplication of two numbers
7*9
#Division of two numbers
8/4
#remainder after division modulo operator
19%2
#Power of number
4**3  #4*4*4


#######################
#Variables: Variables are containers for storing data values.
#Python has no command for declaring a variable.
#######################
#suppose you want to find out total monthly expense given individual expense items
#store individual expense in some place and add all the individual expense
rent= 11000
electricity= 1000
grocery= 4000

total_expense = rent+electricity+grocery
print(total_expense)

#now I want to store name of individual expense
item1="Rent"
item2= "Electricity"
item3="Grocery"

print("My Expense Items are:",item1,item2, item3)

#Variables do not need to be declared with any particular type, and can even change type after they have been set.
x = 4       # x is of type int
x = "Sally" # x is now of type str
print(x)

#get the type of variable
x = 5
y = "John"
print(type(x))
print(type(y))

#Type of variables

