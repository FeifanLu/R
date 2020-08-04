#Section 9 R data frame

#33 R data frame basics
#dataframe allows mixed data types
state.x77
summary(state.x77)
head(state.x77)
str(state.x77)
#create our own dataframe
days <- c('Mon', 'Tue', 'Wed','Thursday','Friday')
temp <- c(22.2, 21, 23,24.3, 25)
rain <- c(T,T,F,F,T)
data.frame(days, temp, rain)
df <- data.frame(days, temp, rain)
df
str(df)


#34 Data Frame Indexing
df[1,]
df[,1]
df[,c('rain','days')]
df[1:5,]
# use the $, you will get a vector
df$days
is.vector(df$days)
df$temp
# use[], you will get a dataframe
df['days']
is.data.frame(df['days'])

#subset function , much like the filter, but does not require the dpylr
#subset can be used on matrices
#filter can be used on databases
#filter drops row names
#subset has a select argument
subset(df, subset = rain==T)
?subset()
subset(df, subset = temp >23)
filter(df, rain==T)
#use the order function to return the sorted row index
sorted.temp <- order(df$temp)
sorted.temp
df[sorted.temp,]
#in descending order
desc.temp <- order(-df['temp'])
df[desc.temp,]

#35.Overview of Data frame Operations Part1
empty <- data.frame()
c1 <- 1:10
letters
c2 <- letters[1:10]
df <- data.frame(col.name1 =c1, col.name2=c2)
df
df <- read.csf('some_file.csv')
write.csv(df, file='saved.csv')
df2 <- read.csv('saved.csv')
df2
#Getting information about data frame
df[,2] <- as.factor(df[,2])
nrow(df)
ncol(df)
colnames(df)
rownames(df)
str(df)
summary(df)
#Referencing cells
df[5,2]
#[] return the container including the data

#[[]] only return the content data 

#pass a value
df[[2,'col.name1']] <- 9999
df
head(mtcars)

#get columns
mtcars$mpg
mtcars[,'mpg']
mtcars[,1]
#return as a vector
mtcars[['mpg']]
is.vector(mtcars[['mpg']])
#return as a dataframe
mtcars['mpg']
is.data.frame(mtcars['mpg'])
#return multiple column
mtcars[c('mpg', 'cyl')]

#36 Overview of dataframe operations 2
df2 <- data.frame(col.name1=2000, col.name2 ='new')
df2
df
# new row
dfnew <- rbind(df,df2)
dfnew
# new column 
df$newcol <- 2*df$col.name1
#get a copy column
df$newcol.copy <- df$newcol
df[,'newcol.copy2'] <- df$newcol
df
colnames(df) <- c('1','2', '3', '4', '5')
df
colnames(df)[1] <-'New COL NAME'
df

#Select multiple rows
df[1:10,]
head(df,10)
#select all but second row
df[-2,]
# subset the datframe based on conditions

mtcars[mtcars$mpg>20,]
mtcars[ (mtcars$mpg >20 & mtcars$cyl ==6) ,]
mtcars[ (mtcars$mpg >20 & mtcars$cyl ==6) ,c('mpg', 'cyl', 'hp')]

#use subset function 
subset(mtcars, mpg > 20 & cyl == 6, c('mpg', 'cyl', 'hp') )


#Finding missing data
df[1,1] <- NA
df
df[[2,2]] <- NA
df[[3,3]] <- NA
df
is.na(df)
is.na(mtcars)
any(is.na(df))
any(is.na(mtcars$mpg))
df$'3'
mtcars$mpg
df[is.na(df$'3')] <- 0
mtcars$mpg[is.na(mtcars$mpg)] <- mean(mtcars$mpg)
#both '' and `` work for choosing clolumns but 
#in ggplot aes, `` works , '' does not
#because aes is mapping, '' make the value a string
df$'New COL NAME'
df$`New COL NAME`
colnames(df)[2] <- 'Temp (C)'
df$'Temp (C)'
df

#Exercise

#1.
#Create columns
Age <- c(22,25,26)
Weight <- c(150,165,120)
Sex <- c('M','M','F')
Name <- c('Sam', 'Frank', 'Amy')
#Combine it as a dataframe

df.1 <- data.frame(row.names = Name, Age, Weight,Sex)
df.1
#2
is.data.frame(mtcars)
#3.
mat <- matrix(1:25, nrow =5)
mat
as.data.frame(mat)
#4
df <- mtcars
#5
head(df)
#6
summary(df)
mean(df$mpg)
#7
df[df$cyl==6,]
#8
#column without ','
df['am']
# row must follow ith ','
df['Volvo 142E',]
df[c('am', 'gear','carb')]
#R in default will accept string as col name, so without comma, it still runs
df[, c('am', 'gear','carb')]
#9
df$performance <- df$hp/df$wt
df
#10
df$performance <- round(df$performance,2)
df
#11
#identify the column first
mean(df$mpg[df$hp > 100 & df$wt >2.5])
#identify the column later, so you need the comma to specify to want all columns at first stage
mean(df[df$hp > 100 & df$wt >2.5,]$mpg)
mean(subset(df, hp > 100 & wt > 2.5)$mpg)
#12
df$mpg[rownames(df) == "Hornet Sportabout"]
df['Hornet Sportabout',]$mpg
