v=c(1,2,3,NA)
sum(v)
sum(v,na.rm=TRUE)

x <- c(1, 2, NA, 4, NA, 5)
naindexes <- is.na(x)
x[!naindexes ]

x <- c(1, 2, NA, 4, NA, 5)
y <- c("a", "b", NA, "d", NA, "f")
good <- complete.cases(x, y)