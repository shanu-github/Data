df1 = data.frame(CustomerId = c(1:6), Product = c(rep("Toaster", 3), rep("Radio", 3)))
df2 = data.frame(CustomerId = c(2, 4, 6), State = c(rep("Alabama", 2), rep("Ohio", 1)))
# Outer join
merge(x = df1, y = df2, by = "CustomerId", all = TRUE)

# Left outer
merge(x = df1, y = df2, by = "CustomerId", all.x = TRUE)
# Right outer
merge(x = df1, y = df2, by = "CustomerId", all.y = TRUE)
merge(x = df1, y = df2, by = "CustomerId", all = FALSE)

# Cross join
merge(x = df1, y = df2, by = NULL)