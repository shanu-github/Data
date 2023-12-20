library(foreign)
data(mtcars)
a<-mtcars
getwd()
write.dbf(a,"1.dbf")
write.dta(a,"1.dta")
write.foreign(a,"1.dat","1.sps",package="SPSS")
write.foreign(a,"2.dat","2.sas",package="SAS")
