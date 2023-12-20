#Dictionary
#It allows values to store in Key Value Pairs
#Classical example: Telephone directory

#creating a Dictionary
phone_book= {"Shubham": 9965473450,"Manju":9988776547, "Rajesh":8897403456}
#Shubham :key, phone number: value
print(phone_book)

#To access the phone number, we use key
phone_book["Shubham"]
phone_book["Rajesh"]

phone_book.get("Shubham")

#To get all keys and values
phone_book.keys()
phone_book.values()

#Add new entry in dictionary
phone_book["Riya"]= 8876543900
print(phone_book)

#check if particular key present or not
"Shubham" in phone_book
"Sameer" in phone_book

#Deleting an entry
del phone_book["Manju"]
print(phone_book)

#delete all the entries frim dictionary
phone_book.clear()
print(phone_book)

# Exercise
'''
Write a Python Program that allows to store age of your family members with Name.
Now print the age of person given the name
'''