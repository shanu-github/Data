#------------------------------------------------------------------------------------------------
#Introduction to Variables
#suppose you want to find out total monthly expense given individual expense items
#store individual expense in some place and add all the individual expense
rent= 11000
electricity= 1000
grocery= 4000

total_expense = rent+electricity+grocery
print(total_expense)

#Variables are called variable because we can vary/modify the values in it
rent= 12000
id(rent)
rent1=rent
id(rent1)

#now I want to store name of individual expense
item1="Rent"
item2= "Electricity"
item3="Grocery"

print("My Expense Items are:",item1,item2, item3)

#We should not use python keyword as variable name, special characters like +,-
#if we try it gives syntax error
True= 5

#------------------------------------------------------------------------------------
#Numbers in Python

#mathemtical calculations
#Addition of Two Numbers
12+15
#Subtraction of two numbers
34-14
#Multiplication of two numbers
7*9
#Division of two numbers
8/4
#remainder after division
19%2
#Power of number
4**3  #4*4*4

#Normally we create variables and apply the above mathematical operations
#Suppose you want to travel from Bangalore to Ooty via Mysore and want to calculate total travel distance
bang_mysore= 248
mysore_ooty= 351

bang_ooty= bang_mysore+mysore_ooty

# find out total time if driving at 50km/hour
mph= 50
time_taken= bang_ooty/50 #distance/speed
print(time_taken)

#you can also use round function to reduce the decimal place
round(time_taken,ndigits=0)
round(time_taken,ndigits=1)
#---------------------------------------------------------
#Exception
#What will be output
10+2*3
#reason: priority on mathematical operations (**,%,/,*, -,+)
3*4/2

11%3/2

11%3**2

4-5+8

#use brackets to avoid the python decide for priority on matematical operation
(10+2)*3

#When we subtract float number from integer number output is always float
6-5.7

6+5.7

