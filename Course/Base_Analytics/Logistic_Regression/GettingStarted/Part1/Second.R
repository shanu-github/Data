x = 1
print(x)

x <- 2
print(x)

x = 3
paste('X is ',x)

x <- 10:30
print(x)

##vector

 a <- c(0.5, 0.6) ## numeric
 a
 a <- c(TRUE, FALSE) ## logical
 a
 a <- c(T, F) ## logical
 a
 a <- c("a", "b", "c") ## character
 a
 a <- 9:29 ## integer
 a
 a <- c(1+0i, 2+4i) ## complex
 a

v10 <- vector("numeric", length = 10)
v10
v10[1] =20
v10

y <- c(1.7, "a") ## character
y
y <- c(TRUE, 2) ## numeric
y
y <- c("a", TRUE) ## character
y


 no<- 0:6
 class(no)
 as.numeric(no)
 as.logical(no)
 as.character(no)
 a = c("a", "b", "c")
 as.numeric(a)

##Matrix
 m <- matrix(nrow = 3, ncol = 3)
dim(m)
attributes(m)

 m <- matrix(1:6, nrow = 3, ncol = 3)
m

m <- 1:8
dim(m) <- c(2, 4)
m

x <- 1:3
y <- 10:12 
s = cbind(x, y)
print('s')
print(s)
rbind(x, y)
##Array

a <- array(c('green','yellow'),dim=c(3,3,2))
print(a)
##List
x <- list(1, "a", TRUE, 1 + 4i)
x
x <- vector("list", length = 5)
x
x <- c(1, 2, NA, 10, 3)
is.na(x)
x <- c(1, 2, NaN, NA, 4)
is.nan(x)
x <- data.frame(age = 1:4, bool = c(T, T, F, F))
x

print(ls())
print(ls(pattern="var"))
print(ls(all.name=TRUE))



