# Create character vector
data.lines.comma <- c("Grade,Age,Code,Amount,Start",
                      "A,23,ABC,48.982,2014-01-01",
                      "B,56,DEF,2.7183,2014-01-02",
                      "F,,,0,",
                      "B,35,XYZ,3.1416,2014-01-05")
data.lines.comma

# Write comma-separated-values (.csv) file to disk
writeLines(data.lines.comma, "Sample.csv")

# Change comm\as (",") to tabs ("\t")
data.lines.tab <- gsub(",", "\t", data.lines.comma)
data.lines.tab

# Write tab-separated-values (.tsv) file (sometimes .txt or .tab) to disk
writeLines(data.lines.tab, "Sample.tsv")

###########################################################################
### Read csv from disk to verify write was successful

data.lines.copy.comma <- readLines("Sample.csv")
data.lines.copy.comma

# Compare with original
data.lines.copy.comma == data.lines.comma
all(data.lines.copy.comma == data.lines.comma)


### Read tsv from disk to verify write was successful
data.lines.copy.tab <- readLines("Sample.tsv")
data.lines.copy.tab

# Compare with original
data.lines.copy.tab == data.lines.tab
all(data.lines.copy.tab == data.lines.tab)