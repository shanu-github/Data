# Create data for the graph.
v <-  c(9,13,21,8,36,22,12,41,31,33,19)



# Create the histogram.
hist(v,xlab = "Weight",col = "yellow",border = "blue")

# Give the chart file a name.
png(file = "histogram.png")

# Save the file.
dev.off()

# Create data for the graph.
v <- c(9,13,21,8,36,22,12,41,31,33,19)



# Create the histogram.
hist(v,xlab = "Weight",col = "green",border = "red", xlim = c(0,40), ylim = c(0,5),
   breaks = 5)

# Give the chart file a name.
#png(file = "histogram_lim_breaks.png")

dev.copy(pdf,"myplot.pdf", width=4, height=4)

getwd()

# Save the file.
dev.off()