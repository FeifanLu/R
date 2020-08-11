#69 Overview of ggplot2

#95 Intro
#data
#aesthetic
#geometries
#facets
#statistics
#coordinates
#theme

library(ggplot2)
#70 Histogram
install.packages('ggplot2movies')
library(ggplot2movies)
#Data Aesthetic
pl <- ggplot(movies, aes(x=rating))
#Geometry
print(pl+geom_histogram(binwidth = 0.1, color='red',fill='pink',alpha=0.5))

#

plt2 <- pl+geom_histogram(binwidth = 0.1, color='red',fill='pink',alpha=0.5)
# sepcial fill, use the internal varibale count to fill the bar
plt2 <- pl+geom_histogram(binwidth = 0.1,aes(fill=..count..))
plt2

pl3 <- plt2 + xlab('Movie Rating') + ylab('My Count') 

pl3


pl3 + ggtitle('My TITLE') +  theme(plot.title = element_text(hjust = 0.5))


#71 Scatterplots

df <- mtcars

#Data & Aesthetic

pl <- ggplot(df, aes(x=wt, y=mpg))

#Geomtry
pl + geom_point(size =5,alpha=0.5 )
glimpse(mtcars)
#since the cyl is categorical variable, we need to make it as factor
pl + geom_point(aes(size=factor(cyl)))
pl + geom_point(aes(shape=factor(cyl),color=factor(cyl)), size=5)
#color-hex code
pl + geom_point(aes(shape=factor(cyl)),color='#53886d',size=5)
pl2 <- pl + geom_point(aes(color=hp), size=5)

pl2 + scale_color_gradient(low='blue', high='red')

ggplot(movies, aes(year,rating)) + geom_density2d()
head(movies)

#Barplots

df <- mpg
head(df)
glimpse(df)
pl <- ggplot(df, aes(x=class)) + geom_bar(color='blue', fill='blue')
pl

pl2 <- ggplot(df, aes(x=class)) + geom_bar(aes(fill=drv),position='dodge')
pl2

pl3 <- ggplot(df, aes(x=class)) + geom_bar(aes(fill=drv),position='fill')
pl3

#73Boxplots

df <- mtcars

pl <- ggplot(df,aes(x=factor(cyl), y=mpg))

print(pl+geom_boxplot())

pl2 <- pl+geom_boxplot() + coord_flip()

pl2

pl3 <- pl + geom_boxplot(aes(fill=factor(cyl))) + theme_bw()
pl3

#section 74 two variables Plotting
pl <- ggplot(movies, aes(x=year, y=rating))
print(pl+geom_bin2d(binwidth=c(3,1)))

pl2 <- pl+geom_bin2d(binwidth=c(3,1)) + scale_fill_gradient(high='red', low='blue')
pl3 <- pl + geom_hex() + scale_fill_gradient(high='red', low='blue')
pl3

pl4 <- pl + geom_density2d()
pl4

#section 75 Coordinating and Faceting
mpg
pl <- ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()
#transform the cartesian to zoom in 
pl2 <- pl + coord_cartesian(xlim = c(1,4), ylim=c(15,30))
pl2
#change the Y/X ratio
pl3 <- pl + coord_fixed(ratio = 1/3)
pl3
#facets

pl4 <- pl + facet_grid( .~cyl)
pl4

pl5 <- pl +facet_grid(drv~.)
pl5

pl6 <- pl + facet_grid(drv ~ cyl)
pl6

#Themes
#set the theme
theme_set(theme_minimal())
pl <- ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()
pl
print(pl+theme_dark())

#call the gg theme
library(ggthemes)
print(pl + theme_economist() )


#Exercise
glimpse(mpg)
#1 stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
ggplot(mpg, aes(x=hwy)) + geom_histogram(fill='red',bins=20,alpha=0.5,aes(y=..density..)) + geom_density()

#2
ggplot(mpg, aes(x=manufacturer)) + geom_bar(aes(fill=factor(cyl))) 
ggplot(mpg, aes(x=manufacturer)) + geom_bar(aes(fill=factor(cyl)), positon='dodge')

#3
head(txhousing)

ggplot(txhousing,aes(x=sales, y=volume))+geom_point(color='green', alpha=0.5) + geom_smooth(color='red')

#4


