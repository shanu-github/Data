#install.packages("philentropy")

# define a probability density function P
P <- 1:10/sum(1:10)
# define a probability density function Q
Q <- 20:29/sum(20:29)

# combine P and Q as matrix object
x <- rbind(P,Q)

library(philentropy)

# compute the Euclidean Distance with default parameters
distance(x, method = "euclidean")
getDistMethods()