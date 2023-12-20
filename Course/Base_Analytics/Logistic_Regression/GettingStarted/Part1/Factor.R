# factor is like integer vector where each index has an able
x <- factor(c("yes", "yes", "no", "yes", "ee"))
x
table(x)
unclass(x)
attr(x,"levels")