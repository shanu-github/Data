#bionomial regression does not work when collinearity exist.
#Also when input data does not have enough categories.

library(stats)
library(glmnet)
X1 <- factor(c(1,1,1,1,1,1,1,1,1,1,1,1,2),labels=c("tool1","tool2"))
X2 <- factor(c(1,1,1,1,1,1,1,1,1,1,1,3,2),labels=c("tool1","tool2","tool3")) 
Y <- c(0,0,0,0,0,0,0,0,0,0,1,1,1)
fit = glm(Y ~ X2, family="binomial")
summary(fit)

X =matrix(1,3,2)

solve(t(X)%*%X)

lambda = 3
solve(t(X)%*%X + lambda*diag(2))

X = cbind(X1, X2)
X1.encode = model.matrix(~X1-1)[,2]
X2.encode = model.matrix(~X2-1)[,2:3]

fit2 = glmnet( cbind(X1.encode,X2.encode), Y, alpha=0, lambda=0.0000000000000000001,family ="binomial")
fit2$beta
