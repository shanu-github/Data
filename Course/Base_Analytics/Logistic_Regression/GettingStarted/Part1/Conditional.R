x = 7
y <- c(8:17)
if (x < y) x else y

a <- c("a", "a", "a", "a", "a")
b <- c("b", "b", "b", "b", "b")
ifelse(c(TRUE, FALSE, TRUE, FALSE, TRUE), a, b)

sample.if.then <- function(x) {
 if (x == "us")
 "dollars"
 else if (x == "uk")
 "pounds"
 else if (x == "in")
 "rupees"
 else
 "nothing"
 };
sample.switch <- function(x) {
 switch(x,
 "us"="dollars",
 "uk"="pounds",
 "in"="rupees",
 "nothing")
 };

sample.if.then("in")
sample.switch("us")