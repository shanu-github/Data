#install.packages("XML")

# Load the package required to read XML files.
library("XML")

# Also load the other required package.
library("methods")

# Give the input file name to the function.
result <- xmlParse(file = "D:\\RProgramme\\1.xml")

# Print the result.
print(result)

rootnode <- xmlRoot(result)
print(rootnode[1])

# Find number of nodes in the root.
rootsize <- xmlSize(rootnode)

# Print the result.
print(rootsize)

xmldataframe <- xmlToDataFrame("D:\\RProgramme\\1.xml")
print(xmldataframe)