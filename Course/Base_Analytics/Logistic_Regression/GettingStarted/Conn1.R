con <- file("D://RProgramme//salary.csv")
open(con, "r")
data <- read.csv(con)
data
close(con)