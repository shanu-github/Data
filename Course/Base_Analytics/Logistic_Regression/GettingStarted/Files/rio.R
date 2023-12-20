library("rio")

x <- import("mtcars.csv")
y <- import("mtcars.rds")
z <- import("mtcars.dta")


export(mtcars, "mtcars.csv")
export(mtcars, "mtcars.rds")
export(mtcars, "mtcars.dta")

# export to sheets of an Excel workbook
export(list(mtcars = mtcars, iris = iris), "multi.xlsx")

# export to an .Rdata file
## as a named list
export(list(mtcars = mtcars, iris = iris), "multi.rdata")

## as a character vector
export(c("mtcars", "iris"), "multi.rdata")


# create file to convert
export(mtcars, "mtcars.dta")

# convert Stata to SPSS
convert("mtcars.dta", "mtcars.sav")