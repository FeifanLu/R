#Section 62 using dpylr

library(dplyr)
library(nycflights13)
head(flights)
summary(flights)

#filter() select rows by conditions
head(filter(flights, month == 11, day ==3, carrier =='AA'))
#filter does not need logical operator, but only work on rows/ its counterpart is select which only works on columns
#subset is like [], works both on rows and columns.However both of them need logical operators
subset(mtcars, mpg > 20 & cyl == 6, c('mpg', 'cyl', 'hp') )


#slice()  select rows by position
slice(flights, 1:10)


#arrange() order the rows. ascending is always the default 
head(arrange(flights,year,month,day,arr_time))
head(arrange(flights,year,month,day,desc(arr_time)))


#Section 63 dyplr part 
#select ()
head(select(flights,carrier))

#rename()  new name on the left
head(rename(flights, airline_carrier=carrier))

#distinct(), is useful to nest select or filter inside the distinct function
distinct(select(flights,carrier))

#mutate() create a new col based on the existed col
head(mutate(flights, new_col = arr_delay-dep_delay))

#transmute() only returns the mutated col 
head(transmute(flights, new_col = arr_delay-dep_delay))

#summarise() aggregate the value
summarise(flights, avg_air_time=mean(air_time, na.rm=TRUE))
summarise(flights, counts=n()) # eqauls with count() but count() works with group , does not work in summarise

#sample()

sample_n(flights,10)

sample_frac(flights,0.001)




#Section 64  Pipe Operator

df <- mtcars
#Nesting, diffcult to read
result <- arrange(sample_n(filter(df, mpg > 20), size=5),desc(mpg))
print(result)

#Multiple assignments, variables take the memory
a <- filter(df,mpg>20)
b <- sample_n(a,size =5)
result1 <- arrange(b, desc(mpg))
result1

#piepline
result2 <- df %>% filter(mpg>20) %>% sample_n(size=5) %>% arrange(desc(mpg))
result2

#Exercise
#1
a <- mtcars %>% filter(mpg>20, cyl==6)
is.data.frame(a)
#2
arrange(mtcars,cyl,desc(wt))
#3
select(mtcars, mpg,hp)
#4
unique(select(mtcars,gear)) == distinct(select(mtcars,gear))
#5
mtcars %>% mutate(Performance = hp/wt)
#6
mtcars %>% summarise(avg_mpg=mean(mpg))
mean(mtcars[,1])
#7
mtcars %>% filter(cyl==6) %>% summarise(mean(hp))






#68 Tidyr

library(tidyverse)


#gather()
comp <- c(1,1,1,2,2,2,3,3,3)
yr <- c(1998,1999,2000,1998,1999,2000,1998,1999,2000)
q1 <- runif(9, min=0, max=100)
q2 <- runif(9, min=0, max=100)
q3 <- runif(9, min=0, max=100)
q4 <- runif(9, min=0, max=100)

df <- data.frame(comp=comp,year=yr,Qtr1 = q1,Qtr2 = q2,Qtr3 = q3,Qtr4 = q4)
df

gather(df, Quarter,Revenue,Qtr1:Qtr4)

df %>% gather(Quater, Revenue, Qtr1:Qtr4)

#spread()

stocks <- data.frame(
  time = as.Date('2009-01-01') + 0:9,
  X = rnorm(10, 0, 1),
  Y = rnorm(10, 0, 2),
  Z = rnorm(10, 0, 4)
)
stocks

stocks.gathered <- stocks %>% gather(stock, price, X,Y,Z)
stocks.gathered

stocks.gathered %>% spread(stock,price)
spread(stocks.gathered, time, price)


#separate()
df <- data.frame(x = c(NA, "a-x", "b-y", "c-z"))
df
separate(df,x,c('ABC', 'XYZ'))

#unite()

df.sep <- separate(df,x,c('ABC', 'XYZ'))
df.sep
unite(df.sep,new.joined.col, ABC,XYZ, sep = '---')
