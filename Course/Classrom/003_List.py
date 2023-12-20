#list
#List: All values have same meaning (homogenous)
#Suppose you want to go to grocery store, before going you are deciding on items to buy
#bread, butter, fruits, vegetables
item1= "bread"
item2= "butter"
item3= "fruits"
item4= "vegetables"

#end up creating many variables, is there a way to store in just one variable
items= ["bread","butter","fruits","vegetables"]
print(items)
#items will be stored in sequence of memory location

#We can access each item using python index
items[0]
items[3]

#what happens if outside of list index
items[5] #will throw an error

#to access range of items
items[0:3]

#If we want to know last item in items
items[-1]

#suppose you want to add extra item in list
items.append("biscuit")
items

#if you want to insert at specific index
items.insert(2, "chocolate")
items

#If you want to join two list
#your wife has given two list of items want to make one
food= ["bread","vegetables","egg"]
bathroom= ["shampoo","soap"]

items= food+bathroom

items

items+"chips" #throws an error can not add list with string

#while adding both should be list
items+["chips"]

# another way to join two lists
food.extend(bathroom)


#to count the number of items in list
len(items)

#to check the presence of particular item in list/ lookup
"chips" in items

"soda" in items

#to remove the specific value
items.remove("soda")

#lists are mutable, means we can change the value for specific index
daily_expense= [100, 300, 1000, 500, 200]
daily_expense[0]= 90
print(daily_expense)

daily_expense[0]= daily_expense[0]+90
print(daily_expense)

daily_expense.append(900)

#Copy a list
list2= daily_expense.copy()