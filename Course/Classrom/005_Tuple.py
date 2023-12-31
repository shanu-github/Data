
#Tuple is a list of values grouped together
#A tuple is a collection which is ordered and unchangeable.
# In Python tuples are written with round brackets.

#Tuples are for one object with different values
#like geometry points
point= (13, 20,6)

#to access the element in tuple
point[0]
point[1]

#Range of index
point[0:2]
point[1:3]

point[1:4]

#using Negative index
point[-1]
point[-1:-3] #wrong

point[-3:-1]

#Once a tuple is created, you cannot change its values.
# Tuples are unchangeable, or immutable.
#Note: You cannot remove items in a tuple
point[0]= 5 #will throw an error

#But there is a workaround. You can convert the tuple into a list, change the list,
# and convert the list back into a tupl3
list_point= list(point)
print(list_point)

list_point[0]=12
print(list_point)

list_point= tuple(list_point)
print(list_point)

#To determine if a specified item is present in a tuple

12 in point

#Determine Tuple length
len(point)

#Join two tuples
mod_points=point+list_point

#get the occurance of each value
mod_points.count(12)
mod_points.count(20)

#get the index for particular value
mod_points.index(12)
mod_points.index(6)

#delete the value from tuple
#Note: You cannot remove items in a tuple
del point

