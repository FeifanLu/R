library(ISLR)
print(head(iris))
install.packages('e1071')
library(tidyverse)
library(e1071)
help("svm")
model <- svm(Species ~., data =iris)
summary(model)
#choose the columns by using index, you can discard the comma before it. However, if choose rows, have to include it
# feed the model 1-4 columns of dataset
pred.values <- predict(model,iris[1:4])
pred.values
#combine the predicted values and the acutal numbers as a frequency table
table(pred.values, iris[,5])
#large gamma high bias, low variance 
iris[5]
glimpse(iris)
tune.results <- tune(svm,train.x=iris[1:4],train.y=iris[,5],kernel='radial',
                     ranges=list(cost=10^(-1:2), gamma=c(.5,1,2)))

tune.results
tune.results <- tune(svm,train.x=iris[1:4],train.y=iris[,5], kernel='radial',
                     ranges=list(cost=c(0.1,1,10), gamma=c(.5,1,2)))
tune.results                  
summary(tune.reuslt)


tune.results <- tune(svm,train.x=iris[1:4],train.y=iris[,5], kernel='radial',
                     ranges=list(cost=c(0.5,1,1.5), gamma=c(0.1,0.5,0.7)))
tune.results  

tuned.svm <- svm(Species ~., data =iris, kernel='radial', coas=1.5, gamma=0)
summary(tuned.svm)
