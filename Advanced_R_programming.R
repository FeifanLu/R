#Advanced R programming




#Section 56 Built_in R features
#seq()
#sort()
#rev()
#str()
#append()


plot(mtcars)
pairs(mtcars)
#Create a sequence with a stepsize of 2
seq(0,10,by=2)
#
#Sort the sequence
v <- c(1,4,7,2,13,3,11)
sort(v)
sort(v,decreasing=TRUE)
#R treat the capital letter equally with the lower cases
cv <- c('b', 'd', 'a','C','A')
sort(cv, decreasing=TRUE)
#
#Reverse the sequence
rev(v)
#
#Show the structure of an object
str(v)
#
#Merge objects together
v <- 1:10
v2 <- 35:40
append(v,v2)
#
#Check the data type
is.vector(v)
is.data.frame(v)
is.data.frame(mtcars)
#
#Convert the data type
as.matrix(v)
#
#Array, is showed by sliced matrices
#in essence, the matrix is a two-dimensional array

a <- 1:72
dim(a)=c(3,3,2,2,2)
a




#Section 57  Apply
#Sample function
print(sample(x = 1:100,3))

#Apply

v <- c(1,2,3,4,5)

addrand <- function(x){
  ran <- sample(1:100,1)
  return(x+ran)
}

print(addrand(10))

#lapply take something, apply function and return a list
#base version is lapply
result <- lapply(v,addrand)
print(result)

#sapply return a vector

result2 <- sapply(v, addrand)
print(result2)


v <- 1:5
times2 <- function(num){
  return(num*2)
}

result3 <- sapply(v, times2)

print(result3)


#apply() takes Data frame or matrix as an input and gives output in vector, 
#list or array. apply() Function is primarily used to avoid explicit uses of loop constructs. 
#It is the most basic of all collections can be used over a matrice.
#apply(X, MARGIN, FUN)
#Here:
 # -x: an array or matrix
#-MARGIN:  take a value or range between 1 and 2 to define where to apply the function:
 # -MARGIN=1`: the manipulation is performed on rows
#-MARGIN=2`: the manipulation is performed on columns
#-MARGIN=c(1,2)` the manipulation is performed on rows and columns
#-FUN: tells which function to apply. Built functions like mean, median, sum, min, max and even user-defined functions can be applied>


mat <- matrix(1:50, byrow=T, nrow=5)
mat
result4 <- apply(mat,2,times2)
result4


# Anonymous Functions
# same with the lamda in python 
# delete the name, put all things in one line
addrand <- function()
  
v <- 1:5

result5 <- sapply(v, function(num){num*2})

print(result5)


#

add_choice <- function(num, choice){
  return(num+choice)
}

print(add_choice(2,10))

sapply(v, add_choice) #wrong here, need one more arguement

print(sapply(v,add_choice,choice=100))


#section 58  Math functions with R

abs(-2)
sum(1,2)
mean(c(4,5,6,7,8,9)) # mean only take one argument
round(2.3333,digits=2)


#secciton 59 regexp
#grepl general regular expression logical
#grep

text <- 'Hi there, do you know who you are voting for?'
text
grepl('voting', text)
grepl('dog',text)
grepl('do you',text)

v <- c('a','a','b','c','d','d')
v

grepl('b',v)
grep('b',v)


#Date and Timestamps
Sys.Date()
#Date has its own class
today <- Sys.Date()
today
class(today)

#transform a charater date into a date date
c <- "1990-01-01"
class(c)
c <- as.Date(c)
class(c)
#irregular format

as.Date('November-03-1990') #fail

my.date <- as.Date('Nov-03-90', format = "%b-%d-%y")
my.date

# %d  day of the month (decimal number)
# %m Month (decimal number)
# %b Month( abbreviated)
# %B Month (full name)
# %y Year (2 digit)
# %Y  Year (4 digit)

as.Date("June,01,2002", format = "%B,%d,%Y")
#transform the timestamp
#Portable operating system interface 
as.POSIXct('11:02:03', format = '%H:%M:%S')


#str string parse time
help(strptime)
strptime("11:02:03", format = "%H:%M:%S")

#POSIXct calender time which stores seconds since UNIX epoch (+some other data),
#POSIlct local time which stores a list of day, month, year, hour, minute, second, etc.

date.hour=strptime("2011-03-27 01:30:00", "%Y-%m-%d %H:%M:%S")

date=c("26/10/2016")

time=c("19:51:30")

day<-paste(date,"T", time)

day.time1=as.POSIXct(day,format="%d/%m/%Y T %H:%M:%S",tz="Europe/Paris")

day.time1

day.time1$year

day.time2=as.POSIXlt(day,format="%d/%m/%Y T %H:%M:%S",tz="Europe/Paris")

day.time2

day.time2$year


