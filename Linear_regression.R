#mean reversion = regression to mean
#Francis Galton
library(tidyverse)
library(ggthemes)
library(corrgram)
library(corrplot)
library(caTools) #for random seed and data split
#89
myfiel <- file.choose()
myfiel
df <- read.csv("C:\\Users\\lufei\\Desktop\\R\\R_Bootcamp\\student\\student-mat.csv",sep =';',stringsAsFactors = T)

head(df)
summary(df)
any(is.na(df))
glimpse(df)
#Num only sapply return the vector, lapplay return the list, apply allows you to choose apply with 
#col or row
num.cols <- sapply(df, is.numeric)
num.cols
is.data.frame(num.cols)
#filter
cor.data <- cor
#corrplot, before using ,have to subset the dataset to only keep numeric data
print(corrplot(cor.data,method='color'))
#corrgram, allow you directly use original dataframe
#very useful !!!
corrgram(df, order=TRUE, lower.panel = panel.shade,
         upper.panel=panel.pie, text.panel=panel.txt)

#
ggplot(df, aes(x=G3)) + geom_histogram(bins=20, alpha=0.5, fill='blue')

summary(df)

#90 linear regression 2
#split the data set
library(caTools)
set.seed(101)
#Split up sample
sample <- sample.split(df$G3,SplitRatio = 0.7)

# 70 % -> train
train <- subset(df, sample == TRUE)
# 30% -> test
test <- subset(df, sample=False)

# TRIAN and Build Model
model <- lm(G3~., data=train)
mean(df$G3)

#Run model



#Interpret model
print(summary(model))

res <- residuals(model)
res <- as.data.frame(res)
head(res)

plot(density(residuals(model)))
ggplot(res, aes(res)) + geom_histogram(fill='blue', alpha=0.5)

#deal with the left skew 
plot(model)

#Predictions

G3.predictions <- predict(model, test)
G3.predictions

results <- cbind(G3.predictions,test$G3)

colnames(results) <- c('predicted', 'actual')

results <- as.data.frame(results)
head(results)
#take care of neg values
to_zero <- function(x){
  if(x<0){
    return(0)
  }else{
    return(x)
  }
}
min(results)
# use the sapply to apply this function to every observation of the predicted column
results$predicted <- sapply(results$predicted, to_zero)

min(results)

## Mean Squared Error
mse <- mean((results$actual-results$predicted)^2)
print(mse)

#RMSE
print(mse^0.5)

#SSE
mean(df$G3)
mean(test$G3)
mean(train$G3)
SSE <- sum((results$predicted- results$actual)^2)
SST <- sum((results$actual - mean(df$G3))^2)

R2 <- 1 - SSE/SST
R2
