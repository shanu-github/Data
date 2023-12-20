print(getwd())
# Set current working directory.
setwd("D://ip")
# Get and print current working directory.

print(getwd())
data <- read.csv("student.csv")
names(data)
retval <- subset(data, data$marks== max(data$marks,na.rm=TRUE))
print(retval)

extcVal <- subset( data, dept == "EXTC")
print(extcVal)

dualCondVal <-  subset(data, marks> 1000 & dept == "EXTC")
print(dualCondVal)

retval <- subset(data, as.Date(addate) > as.Date("01/01/2037"))
print(retval)