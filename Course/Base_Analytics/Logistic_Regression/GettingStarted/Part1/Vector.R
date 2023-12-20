a =1:6
paste('length of a',length(a))
b=seq(from = 4.5, to = 2.5, by = -0.5)
paste(b)
c= seq(from = -2.7, to = 1.3, length.out = 9)
paste(c)

v1 = c(1,2,3)
v2 = c(5,6,7)
v3 = c(v1,v2)
v3
r1= rep(c(1, 2, 3), each = 3)
r1
r2=rep(c(1, 4), times = c(4,2))
r2
v11=50:1
indices <- c(5,11,3)
v11[indices]
v11[4]
v11[-4]
sum(v11)
min(v11)
max(v11)
prod(v11)
cumsum(v11)
cummin(v11)
cummax(v11)
diff(v11)
which(v11>25)
boolv=c(T,F,F)
any(boolv)
boolv = c(F,F)
any(boolv)