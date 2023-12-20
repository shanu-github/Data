#install.packages("rjson")
# Load the package required to read JSON files.
library("rjson")

# Give the input file name to the function.
result <- fromJSON(file = "D:\\RProgramme\\1.json")

# Print the result.
print(result)
json_data_frame <- as.data.frame(result)

print(json_data_frame)