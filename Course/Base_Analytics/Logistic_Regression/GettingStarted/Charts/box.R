A <- c(3, 2, 5, 6, 4, 8, 1, 2, 3, 2, 4)
boxplot(A)
input <- mtcars[,c('mpg','cyl')]
print(head(input))



# Plot the chart.
boxplot(mpg ~ cyl, data = mtcars, xlab = "Number of Cylinders",
   ylab = "Miles Per Gallon", main = "Mileage Data")

# Give the chart file a name.
png(file = "boxplot.png")
# Save the file.
dev.off()



# Plot the chart.
boxplot(mpg ~ cyl, data = mtcars, 
   xlab = "Number of Cylinders",
   ylab = "Miles Per Gallon", 
   main = "Mileage Data",
   notch = TRUE, 
   varwidth = TRUE, 
   col = c("green","yellow","purple"),
   names = c("High","Medium","Low")
)

png(file = "boxplot_with_notch.png")
# Save the file.
dev.off()