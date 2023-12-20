df = data.frame(CustomerId = c(1:6), Product = c(rep("Toaster", 3), rep("Radio", 
    3)))



df3 = rbind(df, df)
df3
duplicated(df3[, c("CustomerId")])
df3[!duplicated(df3[, c("CustomerId")]), ]