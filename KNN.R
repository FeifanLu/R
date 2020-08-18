#K neighbors 
#work terribly on high dimensinonal big dataset and categorical variable

#GET THE DATA
library(ISLR)
str(Caravan)
summary(Caravan$Purchase)

any(is.na(Caravan))

#standarlize 
var(Caravan[,1])
var(Caravan[,2])
#create the prediction label
purchase <- Caravan[,86]
#standardized the data without the label
standardized.Caravan <- scale(Caravan[,-86])
#
print(var(standardized.Caravan[,1]))
print(var(standardized.Caravan[,2]))

#Train test split

test.index <- 1:1000
test.data <- standardized.Caravan[test.index,]
test.purchase <- purchase[test.index]
train.data <- standardized.Caravan[-test.index,]
train.purchase <- purchase[-test.index]


#KNN MODEL

library(class)
set.seed(101)

predicted.purchase <- knn(train.data, test.data, train.purchase,k=5)
print(head(predicted.purchase))

misclass.error <- mean(test.purchase != predicted.purchase)
misclass.error

####CHOOSING THE K value

predicted.purchase <- NULL
error.rate <- NULL 
for (i in 1:20) {
  set.seed(101)
  predicted.purchase <- knn(train.data, test.data, train.purchase, k = i)
  error.rate[i]<- mean(test.purchase != predicted.purchase)
  
}
print(error.rate)


##Visualize the k elbow method

library(ggplot2)
library(ggthemes)
k.values <- 1:20
error.df <- data.frame(error.rate,k.values)
error.df

ggplot(error.df, aes(k.values,error.rate)) + geom_point() + geom_line(lty='dotted', color='red') +
scale_x_continuous(breaks = 1:20)  + theme_wsj() 


 