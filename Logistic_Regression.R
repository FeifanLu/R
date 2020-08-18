# Logistic regression project
library(tidyverse)
library(ggthemes)
library(corrgram)
library(corrplot)
library(Amelia)
library(mice)
myfile <- file.choose()
myfile
#Age is numeric, so the missing values are transformed into NA when read this csv file into R
#However, Cabin, Embarked are characters, so they have to be changed to empty strings
#if we don't set the na.string parameter

df.train <- read.csv("C:\\Users\\lufei\\Desktop\\R\\R_Bootcamp\\R-Course-HTML-Notes\\R-Course-HTML-Notes\\R-for-Data-Science-and-Machine-Learning\\Machine Learning with R\\titanic_train.csv",
                     stringsAsFactors = TRUE,
                     na.strings = "")

df.test <- read.csv("C:\\Users\\lufei\\Desktop\\R\\R_Bootcamp\\R-Course-HTML-Notes\\R-Course-HTML-Notes\\R-for-Data-Science-and-Machine-Learning\\Machine Learning with R\\titanic_test.csv",
                    stringsAsFactors = TRUE,
                    na.strings = "")

head(df.train)
glimpse(df.train)
#Amelia for NA values
#installed.packages('Amelia')
help("missmap")
missmap(df.train, main='Missingmap', col=c
        ('yellow', 'black'),legend=FALSE)
missing <- aggr(df.train)
summary(missing)
any(is.na(df.train$Cabin))
#locate the na in train dataset
na.train=data.frame(is.na(df.train))%>%map_int(sum) 
na.train
#locate the na in test dataset
na.test=data.frame(is.na(df.test))%>%map_int(sum) 
na.test

#EDA
ggplot(df.train,aes(Survived)) + geom_bar()
ggplot(df.train, aes(Pclass)) + geom_bar(aes(fill=factor(Pclass)))
ggplot(df.train, aes(Sex)) + geom_bar(aes(fill=factor(Sex)))
ggplot(df.train, aes(Age)) + geom_histogram(bins=20, alpha=0.5,fill='blue',aes(y=..density..)) +geom_density()
ggplot(df.train, aes(SibSp)) + geom_bar()
ggplot(df.train, aes(Fare)) + geom_histogram(fill='Green', color='black')

#fill the age by the passenger class instead of filling the average age,
#because age has different distributions in different passenger classes
#so the correlation between the age and passenger class is mitigated less compared with using
#the average age(but still mitigated)
#and it still undermine the variance
#median better for there is outliers
#mode for categorical
pl <- ggplot(df.train, aes(Pclass, Age))
pl1 <- pl + geom_boxplot(aes(group=Pclass, fill=factor(Pclass), alpha=0.4))
pl1
#reset the y scale, the better the passenger class, the older the age
pl2 <- pl1 + scale_y_continuous(breaks=seq(min(0), max(80),by=2)) + theme_bw()
pl2


##Imputation use the median instead of the mean because the effect of outliers.
#for iteration has two ways
#1. for (temp_var in vec){
#print(temp_var)
#}

#2. for (i in 1:length(vec)){
#print(vec[i])
#}

# we want the index for us to choose the class for the conditional equation.so we choose the second
impute_age <- function(age, class){
  out <- age
  for (i in 1:length(age)){
    
    if(is.na(age[i])){
      
      if(class[i]==1){
        out[i] <- 37
        
      }else if (class[i] ==2 ){
        out[i] <- 29
        
      }else{
        out[i] <- 24
      }
    }else{
      out[i] <- age[i]
    }
  }
  return(out)
}

fixed.ages <- impute_age(df.train$Age, df.train$Pclass)

class(fixed.ages)
head(fixed.ages)

###
df.train$Age <- fixed.ages
###
missmap(df.train, main='Imputation Check', col=c('yellow','black'), legend =FALSE)


##Drop the Ticket, Cabin, name,passenger ID because too many levels 
#requires feature engineering to extract useful information
#such as group the name by title, "Sir", "Don" 
#use cabin level as feature
glimpse(df.train)
summary(df.train)
df.train <- select(df.train, -Cabin, -Name, -PassengerId,-Ticket)
#find the mode
#use table function transform the vector into frequency table
#use which.max to find the biggest frequency value
table(df.train$Embarked)
which.max(table(df.train$Embarked))

#use the mode to replace NA. R does not have the default function
df.train$Embarked[is.na(df.train$Embarked)] <- 'S'
any(is.na(df.train$Embarked))

#Build the model
df.train$Survived <- factor(df.train$Survived)
df.train$Pclass <- factor(df.train$Pclass)
df.train$Parch <- factor(df.train$Parch)
df.train$SibSp <- factor(df.train$SibSp)
str(df.train)
summary(df.train)
log.model <- glm(Survived ~. , family=binomial(link='logit'), data=df.train)
summary(log.model)

library(caTools)

set.seed(101)
split <- sample.split(df.train$Survived,SplitRatio=0.7)
final.train <- subset(df.train, split= TRUE)
final.test <- subset(df.train, split == FALSE)
final.log.model <- glm(Survived ~., family=binomial(link='logit'), data = final.train)
summary(final.log.model)
#classification, so type = 'response', forecast the probability of response
fitted.probabilities <- predict(final.log.model, final.test, type='response')
#ifelse shortcut way of writing an actual function with if else
fitted.results <- ifelse(fitted.probabilities>0.5, 1, 0)
#forecasting failure return 1, the total sum of the amount of forecasting failure / total amount of records
#mean() take the true of false vector and calculate the average
misClassError <- mean(fitted.results != final.test$Survived)
print(1- misClassError)
#Confusion Matrix
#TURE 1, False 0, True 0 type 1, False 1 type 2
table(final.test$Survived)# 0 164, 1 103
table(fitted.probabilities > 0.5)# False 170, True 98
table(final.test$Survived, fitted.probabilities>0.5)#0,false 143 ; 1,false 27; 0, true 22; 1,true 76


#Predict the test data
#clean the df.test
missing.test <- aggr(df.test)
summary(missing.test)
fixed.ages.test <- impute_age(df.test$Age, df.test$Pclass)
df.test$Age <- fixed.ages.test
summary(df.test)
# by using boxplot we see a lot of outliers, so mean is not a good choice, we decide to use median
ggplot(df.test, aes(x=Fare)) + geom_boxplot()
glimpse(df.test)
#find the mode 7.75
which.max(table(df.test$Fare))
#replace it
df.test$Fare[is.na(df.test$Fare)] <- 7.75
df.test <- select(df.test, -Cabin, -Name, -PassengerId,-Ticket)
glimpse(df.test)
summary(df.test)
df.test$Survived <- factor(df.test$Survived)
df.test$Pclass <- factor(df.test$Pclass)
df.test$Parch <- factor(df.test$Parch)
df.test$SibSp <- factor(df.test$SibSp)
fitted.probabilities.test <- predict(final.log.model, df.test, type='response')
fitted.results <- ifelse(fitted.probabilities.test>0.5, 1, 0)
