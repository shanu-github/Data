library(ggplot2)
library(scales)
data("mtcars")
# geom_bar is designed to make it easy to create bar charts that show
# counts (or sums of weights)
g <- ggplot(mpg, aes(class))
# Number of cars in each class:
g + geom_bar()

#colouring
g + geom_bar(fill="Purple")+geom_hline(yintercept = 30)

# Total engine displacement of each class
g + geom_bar(aes(weight = displ))

aggregate(mpg$displ, by=list(mpg$class), sum)

# Bar charts are automatically stacked when multiple bars are placed
# at the same location
g + geom_bar(aes(fill = drv))

# You can instead side by side, or fill them
g + geom_bar(aes(fill = drv), position = "dodge")

# want to see in porportion
g + geom_bar(aes(fill = drv), position = "fill")

#change the width of bar
g + geom_bar(aes(fill = drv), position = "fill", width = 0.9)

#fliping the bar
g + geom_bar(aes(fill = drv), position = "fill", width = 0.9)+ coord_flip()

#colouring
g + geom_bar(fill="Purple")+facet_wrap(~ cyl)


#horizontal line
+ geom_hline(yintercept=h1)

#background white
+theme_bw()

#title
ggtitle()+
xlab("My x label") +
  ylab("My y label") 


#pie chart
ggplot(mpg, aes(x=factor(1), fill=class))+geom_bar(width=1) + coord_polar(theta="y", start=0)
  
#histogram
ggplot(mpg, aes(displ))+geom_histogram(fill= "blue")

ggplot(mpg, aes(displ, fill= as.factor(cyl)))+geom_histogram()
ggplot(mpg, aes(displ))+geom_histogram()+facet_wrap(~ cyl,scales = "free_y")

ggplot(mpg, aes(displ, colour= as.factor(cyl)))+geom_freqpoly()


#density plot
ggplot(mpg, aes(displ, colour=as.factor(cyl), fill=as.factor(cyl))) + geom_density(alpha=0.1)+ labs(colour='NEW LEGEND TITLE') 

+ xlim(55, 70)

ggplot(mpg, aes(displ, colour=as.factor(cyl))) + geom_density()+ labs(colour='CYL') 
ggplot(mpg, aes(displ, fill=as.factor(cyl))) + geom_density(alpha=0.1)+ labs(fill='CYL') 


#scatter plot
ggplot(mpg, aes(x=displ, y=hwy)) +geom_point(size=2) + geom_smooth()
ggplot(mpg, aes(x=displ, y=hwy)) +geom_point(size=2) + geom_smooth(method=lm)
ggplot(mpg, aes(x=displ, y=hwy)) +geom_point(size=2) + geom_smooth(method=lm, se=FALSE) 

ggplot(mpg, aes(x=displ, y=hwy, colour=as.factor(cyl),shape=drv)) +geom_point(size=3) +
  labs(colour="CYL") +ggtitle("Plooting\n") 

ggplot(mpg, aes(x=displ, y=hwy, colour=as.factor(cyl))) +geom_point(size=3) +
  labs(colour="CYL") +ggtitle("Plooting\n") 

ggplot(mpg, aes(x=displ, y=hwy, colour=as.factor(cyl),size=cty)) +geom_point() +
  labs(colour="CYL") +ggtitle("Plooting\n") 

#line plot time series data'
data()
View(AirPassengers)

data("diamonds")
View(diamonds)

ggplot(diamonds, aes(x=carat, y=price)) +geom_point(size=2,color="purple")
ggplot(diamonds, aes(x=carat, y=price, color=color)) +geom_point(size=2)

mtcars$gear <- factor(mtcars$gear,levels=c(3,4,5),
                      labels=c("3gears","4gears","5gears"))
mtcars$am <- factor(mtcars$am,levels=c(0,1),
                    labels=c("Automatic","Manual"))
mtcars$cyl <- factor(mtcars$cyl,levels=c(4,6,8),
                     labels=c("4cyl","6cyl","8cyl")) 

data(m)

ggplot(mtcars, aes(x=mpg, y=hp, color=as.factor(cyl))) +geom_point(size=2)

data("Titanic")
View(Titanic)
