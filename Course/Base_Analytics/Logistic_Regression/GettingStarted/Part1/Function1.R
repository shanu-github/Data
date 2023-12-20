f <- function() {
print("Welcome to Functions")
}
f()

square <- function(x) {
paste("Square of x is",x**x)
}
square(2)

power <- function(x,n){
paste(" x raised to n is", x ^ n)
}
power(3,4)

##Lazy evaluation
l <- function(a, b) {
a ** a
a** b
}

l(2)