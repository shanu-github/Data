#install.packages("party")
library(party)

# Create the input data frame.
input.dat <- readingSkills[c(1:105),]


# Create the tree.
  output.tree <- ctree(
  nativeSpeaker ~ age + shoeSize + score, 
  data = input.dat)


# Plot the tree.
plot(output.tree)

# Give the chart file a name.
png(file = "decision_tree.png")

# Save the file.
dev.off()