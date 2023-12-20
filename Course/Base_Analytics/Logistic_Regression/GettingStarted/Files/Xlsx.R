library("xlsx")
data(mtcars)
a <- mtcars
getwd()
write.xlsx(mtcars, file="1.xlsx", sheetName="cars")
res <- read.xlsx(file="1.xlsx", 1)
print(res)