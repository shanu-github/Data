##String
x <- "Split the words in a sentence."
strsplit(x, " ")

x <- "Split at every character."
strsplit(x, "")

x <- " Split at each space with a preceding character."
strsplit(x, ". ")

x <- "Do you wish you were Mr. Jones?"
strsplit(x, ". ")
strsplit(x, ". ", fixed=TRUE)