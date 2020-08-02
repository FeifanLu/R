library(readxl)
library(dplyr)
library(tidyverse)

movies <- read.csv(file.choose())
head(movies)
colnames(movies) <- c("Film", "Genre", "CriticRating", "AudienceRating", "BudgetMillions","Year")
head(movies)
tail(movies)
str(movies)
#Transform the year into factor
movies$year <- as.factor(movies$Year)
glimpse(movies)

#------------------Aesthetics

#add geometry
ggplot(movies, aes(x=CriticRating, y=AudienceRating)) + geom_point()

#add colour
ggplot(movies, aes(x=CriticRating, y=AudienceRating,
                   colour=Genre)) + 
  geom_point()

#add size
ggplot(movies, aes(x=CriticRating, y=AudienceRating,
                   colour=Genre, size=BudgetMillions)) + 
  geom_point()
#>>>>> this #1 will improve

#--------------- Plotting with layers

p<-ggplot(movies, aes(x=CriticRating, y=AudienceRating,
                  colour=Genre, size=BudgetMillions)) 
#point
p + geom_point()
#lines
p + geom_line()
#multiple layer

p + geom_point() + geom_line()

#lay points over lines
p + geom_line() + geom_point()

#-------------------Overriding Aesthtics

q<-ggplot(movies, aes(x=CriticRating, y=AudienceRating,
                      colour=Genre, size=BudgetMillions)) 

q + geom_point()

#overriding aes
#the size has been overridden, although the lab is sill the Budget
q + geom_point(aes(size=CriticRating))
#q remains the same
q + geom_point()

#ex3

q + geom_point(aes(x=BudgetMillions)) +
  xlab("Budget Millions$$$")

#ex4
q + geom_line() + geom_point()

#reduce the line size

q + geom_line(size=1) + geom_point()


#----------------------- Mapping vs Setting

r <- ggplot(movies, aes(x=CriticRating, y=AudienceRating)) 
r + geom_point()

#Add colour
#1. Mapping (what we've done so far)

r + geom_point(aes(colour=Genre))

#2. Setting:

r + geom_point(colour="DarkGreen")

#Error: mix the setting and mapping. 
r + geom_point(aes(colour="DarkGreen"))

#1.Mapping
r + geom_point(aes(size=BudgetMillions))

#2.Setting
r + geom_point(size=10)

#Error
r + geom_point(aes(size=10))

#--------------------Histograms and Density Charts

s <- ggplot(data=movies, aes(x=BudgetMillions))
  
s + geom_histogram(binwidth=10)

#add colour

s + geom_histogram(binwidth=10,aes(fill=Genre))

#add a border

s + geom_histogram(binwidth=10,aes(fill=Genre),colour="Black")
#>>>3 we will improve it

#Sometimes you may need the density charts:
#Hard to explain
s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre),position="stack")


#---------------Starting layers

t <- ggplot(movies, aes(x=AudienceRating))
t + geom_histogram(binwidth=10,fill="White", colour="Blue")

#another way:
t <- ggplot(movies)
t + geom_histogram(binwidth=10,
                   aes(x=AudienceRating),
                   fill="White", colour="Blue")

#>>> 4  you can change the mapping of dataset without overriding
t + geom_histogram(binwidth=10,
                   aes(x=CriticRating),
                   fill="White", colour="Blue")
#>>>5

t<-ggplot()

#------------------ Statistical Transformation

?geom_smooth

u <- ggplot(movies, aes(x=CriticRating, y=AudienceRating, colour=Genre))
u + geom_point() + geom_smooth(fill=NA)

#boxplots
u <- ggplot(movies, aes(x=Genre, y=AudienceRating, colour=Genre))

u + geom_boxplot(size=1.2) + geom_point()

#tip / hack : jitter, for x is a categorical variable, adding jitter to
#seperate points, since the x is a categorical varibal, the 
#x vlaue of points does not have meanings

u + geom_boxplot(size=1.2) + geom_jitter()

#another way: box on top with a certian level of transparency 
u +  geom_jitter() + geom_boxplot(size=1.2, alpha=0.5) 

#>>6

v <- ggplot(movies, aes(x=BudgetMillions))
v + geom_histogram( aes(fill=Genre), binwidth=10,colour="Black")

#facets let the scale changes freely
v + geom_histogram( aes(fill=Genre), binwidth=10,colour="Black") +
  facet_grid(Genre~., scale='free')
#scatterplots:

w<-ggplot(movies, aes(x=CriticRating, y=AudienceRating, colour=Genre))
w + geom_point(size=3)

#facets
w + geom_point(size=3)+
  facet_grid(Genre~.)

w + geom_point(size=3)+
  facet_grid(Year~.)

w + geom_point(size=3)+
  facet_grid(.~Year)

