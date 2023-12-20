import numpy as np
from dateutil.relativedelta import relativedelta
import datetime


class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def sayhello(self):
        print("Hello my name is " + self.name)

    def calculate_birthyear(self):
        birth_year = datetime.datetime.now() - relativedelta(years=self.age)
        return birth_year.year

    @staticmethod
    def count_char(s1):
        return len(s1)

    def print_countchar(self):
        print("Number of characters in Person Name",Person.count_char(self.name))


class Student(Person):
    def __init__(self,name, age, grad_year):
        super().__init__(name,age)
        self.grad_year= grad_year

    def welcome(self):
        print("Welcome", self.name, "to the class of", self.grad_year)


def main():
    p1 = Person("John", 36)
    p1.sayhello()
    p1.calculate_birthyear()
    p1.print_countchar()

    s1= Student("Aditya", 20, 2017)
    s1.name()
    s1.welcome()

if __name__ == '__main__':
    main()
