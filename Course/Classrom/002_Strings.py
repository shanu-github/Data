#---------------------------------------------------------------------------------
#String In Python: Used to store text information
#Strings are represented by quotes in python (single, double, tripple)
#python stores each character of string in different memory location index starts with 0

text1= "ice cream"

#want to access i, index start from 0
text1[0]
text1[3]

#if you want to change specific character
text1[0]= 'y' #you will get error, as strings are immutable can not be changed partially, you can change whole

#accessing the substring
text1[0:3] #from start 0 till 2nd index

#if omit the after: then it will go till end
text1[3:]

#if omit the before : then it will start from 0 index
text1[:3]

#Single/ double quotation
text="hello"
text='text'
text= 'let's learn python' #throw error
#if single quote inside then use double quote outside viceversa
text= "let's learn python"

text = 'hello "world"'

#When multi line use triple quote
address= '''123, House No 209
Ashoka palace'''

print(address)
address
#\n mean new line
#------------------------------------------------------------
#Operations in String
#Concatination in strings
s1="Good"
s2="Morning"

s1+s2
#want to add space
s1+' '+s2

#want to concat number with string
s1+123  #wrong

#convert number to string first and then concat
str(123) #to know whether converted or not
s1+ str(123)
