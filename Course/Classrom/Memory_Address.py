'''
X=Y does not make a copy of Y object, X will refer to same memory address as Y
Any change in X will cause change in Y
Only applicable for list, Dictionary, tuple, dataframe..etc which are not simple built-in data types
'''
a = [1, 2, 3]
b = a
b.append(4)
print(a)

'''
Any changes made to b in the above example also impact a and vice-versa.
When you assign a variable, you’re really pointing it to a same memory address. 
So when I did a = [1, 2, 3] I created a new list object in memory,
and then saved a as a variable that points to the memory address of that object.
And what I’d done in the above example was point two variables, a and b, to the same memory address
'''
#to know the memory address
id(a)
id(b)
#another way to check
#whether they are the same object, which for our purposes means they are at the same memory address:
a is b

#To really make a copy without distrubing the original value
b= a.copy()
id(a)
id(b)

a is b

#If object is simple built-in datatype (float, integer, string),
# after modifying one will start acting as two seprate object

a= 10
b=a

a is b

b=b+1
a is b

a="string"
b=a

b=b+"kk"

a is b
