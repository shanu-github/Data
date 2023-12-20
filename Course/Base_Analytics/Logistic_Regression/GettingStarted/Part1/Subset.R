df = data.frame(CustomerId = c(1:6), Product = c(rep("Toaster", 3), rep("Radio", 
    3)))
subset(df, CustomerId > 3)
subset(df, CustomerId > 3 & CustomerId < 6)
subset(df, CustomerId > 3, select = c(Product))
subset(df, subset = CustomerId %in% c(1, 3, 5))
#The with( ) function applys an expression to a dataset
with(df, CustomerId > 3)
df[with(df, CustomerId > 3), ]


