install.packages('rpart')
library(rpart)
str(kyphosis)
head(kyphosis)


tree <- rpart(Kyphosis ~., method = 'class', data=kyphosis)
#print cp = complexity parameter
printcp(tree)
plot(tree,uniform = T, main='Kyphosis Tree')
text(tree, use.n = T , all=T)

install.packages('rpart.plot')

library(rpart.plot)

prp(tree)

#Rndom forest
#generate a large number of bootstrpping trees for bagging trees with random freatures



install.packages('randomForest')
library(randomForest)
rf.model <- randomForest(Kyphosis ~. , data=kyphosis)
print(rf.model)

#the model output itself is a list, you can grab elements out of it 
rf.model$predicted

rf.model$ntree

rf.model$confusion
