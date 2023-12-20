x = 'Hello vishwa'
is.character(x)
length(x)
nchar(x)
x = c("Hello","vishwa")
length(x)
nchar(x)
ch =letters
ch
chUp=LETTERS
chUp

letters[10:26]
tail(ch,10)
head(ch,10)
chUp=toupper(ch)
chUp
chLwr=tolower(chUp)
chLwr
paste(chLwr, collapse="*")
paste(chLwr, sep="*")
paste(LETTERS[1:5], 1:5, sep="_", collapse="---")
paste("Hello",1:5)
sort(chLwr,decreasing=TRUE)
chLwr
city=c("Nava Delhi","Mumbai","Navi Mumbai")
grep("Nav",city)
city[grep("Nav",city)]
city[grep("nav",city)]
color = c('light red','light green','dark yellow','dark red')
grep("green|red",color)
color[grep('green|red',color)]