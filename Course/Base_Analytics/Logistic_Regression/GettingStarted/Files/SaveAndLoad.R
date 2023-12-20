marks <- c(90, 78, 56, 89, 90)
subjects <- c("CSM", "MM", "PHY", "CHEM", "ENG")
df <- data.frame(subjects , marks )
fix(df)
print(df)
save(df,file="D://RProgramme//df.RData")


df
load(file="D://RProgramme//df.RData")
print(df)

##header
df <- read.table("D://RProgramme//salary.csv", header=TRUE, sep=",", quote="\"")
print(df)
print(df$name.last[1])
