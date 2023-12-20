library(stringdist)
# lets see which sci-fi heroes are stringdistantly nearest
amatch("leia",c("uhura","leela"),maxDist=5)
# we can restrict the search
amatch("leia",c("uhura","leela"),maxDist=1)
# we can match each value in the find vector against values in the lookup table:
amatch(c("leia","uhura"),c("ripley","leela","scully","trinity"),maxDist=2)
# setting nomatch returns a different value when no match is found
amatch("leia",c("uhura","leela"),maxDist=1,nomatch=0)
# this is always true if maxDist is Inf
ain("leia",c("uhura","leela"),maxDist=2)
# Let's look in a neighbourhood of maximum 2 typo's (by default, the OSA algorithm is used)
ain("leia",c("uhura","leela"), maxDist=2)
# define o-umlaut
ouml <- intToUtf8("0x00F6")
x <- c("Motorhead", paste0("Mot",ouml,"rhead"))
# second element contains a non-ascii character
printable_ascii(x)
qgrams('hello world',q=3)
# q-grams are counted uniquely over a character vector
qgrams(rep('hello world',2),q=3)
# q-grams are counted uniquely over a character vector
qgrams(rep('hello world',2),q=3)
# to count them separately, do something like
x <- c('hejllo', 'world')
lapply(x,qgrams, q=3)
# output rows may be named, and you can pass any number of character vectors
x <- "I will not buy this record, it is scratched"
y <- "My hovercraft is full of eels"
z <- c("this", "is", "a", "dead","parrot")
qgrams(A = x, B = y, C = z,q=1)
# a tonque twister, showing the effects of useBytes and useNames
x <- "peter piper picked a peck of pickled peppers"
qgrams(x, q=2)
qgrams(x, q=2, useNames=FALSE)
qgrams(x, q=2, useBytes=TRUE)
qgrams(x, q=2, useBytes=TRUE, useNames=TRUE)
stringdist("ca","abc")
# The same example using Damerau-Levenshtein distance (multiple editing of substrings allowed)
stringdist("ca","abc",method="dl")
# string distance matching is case sensitive:
stringdist("ABC","abc")


agrep("lasy", "1 lazy 2",value = TRUE)
agrep("lasy", "1 lazy 2", max = list(sub = 0))
agrep("laysy", c("1 lazy", "1", "1 LAZY"), max = 2)
agrep("laysy", c("1 lazy", "1", "1 LAZY"), max = 2, value = TRUE)
pmatch(c("med", "mod"), c("mean", "median", "mode"))






###################################
#Text Mining Method 1
###################################
library(cba)
word <- 'test'
words <- c('Teest','teeeest','New York City','yeast','text1','Test23')
ClosestMatch <- function(string,StringVector) {
  matches <- agrep(string,StringVector,value=TRUE,ignore.case=TRUE)
  distance <- sdists(string,matches,method = "ow")
  matches <- data.frame(matches,as.numeric(distance))
  matches <- subset(matches,distance==min(distance))
  as.character(matches$matches)
}
ClosestMatch(word,words)



matches <- agrep(word,words,value=TRUE)
matches$distance

distance <- sdists(word,matches,method = "ow")
matches <- data.frame(matches,as.numeric(distance))
matches <- subset(matches,distance==min(distance))



###################################
#Text Mining Method 2
###################################
library(stringdist)

ClosestMatch2 = function(string, stringVector){
  
  stringVector[amatch(string, stringVector, maxDist=Inf)]
  
}
ClosestMatch2(word,words)

###################################
#Text Mining Method 3
###################################
library(RecordLinkage)
word <- 'test'
word<-tolower(word)
words <- c('Teest','teeeest','New York City','yeast','text','Test')
words<-tolower(words)
ClosestMatch2 = function(string, stringVector){
  
  distance = levenshteinSim(string, stringVector);
  stringVector[distance == max(distance)]
  
}
ClosestMatch2(word,words)

distance = levenshteinSim(word, words);

###################################
#Text Mining Method 4
###################################

library(vwr)
levenshtein.distance(word,words)







