library(tidyverse)
library(ggthemes)
library(corrgram)
library(corrplot)
library(caTools) 
library(readxl)
library(caret)
library(xlsx)
my.file <- file.choose()
my.file

df <- read_excel("C:\\Users\\lufei\\Desktop\\MMA\\MMA_867_predictive_modelling\\Week1\\Predictive Modelling - MMA 867 - 8142020 - 1007 PM\\Sarah_Diamonds.xls",
                 sheet = 2, skip = 2)

df <- rename(df, Carat_Weight =`Carat Weight`)
head(df)
summary(df)
glimpse(df)
#Label Encoding 
unique(df$Cut)
df$Cut <- as.numeric(factor(df$Cut, levels=c('Fair','Good', 'Very Good','Ideal', "Signature-Ideal" )))
unique(df$Color)
df$Color <- as.numeric(factor(df$Color, levels=c('I','H','G', 'F','E', "D" )))
unique(df$Clarity)
df$Clarity <- as.numeric(factor(df$Clarity, levels=c("SI1", "VS1" , "VS2" , "VVS2" ,"VVS1" ,"IF"  , "FL"  )))
df[df$Clarity==2 | df$Clarity==3,]$Clarity <-2
df[df$Clarity==4 | df$Clarity==5,]$Clarity <-3
df[df$Clarity==6 | df$Clarity==7,]$Clarity <-4
unique(df$Polish)
df$Polish <- as.numeric(factor(df$Polish, levels=c("G", "VG" , "EX" , "ID" )))
df$Symmetry <- as.numeric(factor(df$Symmetry, levels=c("G", "VG" , "EX" , "ID" )))


# turn report to dummy 

df_new <- dummyVars(" ~ . ", df) 
df <- data.frame(predict(df_new, df))

glimpse(df)




#cov_pearson <- cov(df, method = 'pearson')

#corrgram
corrgram(df.model, order=TRUE, lower.panel = panel.shade,
         upper.panel=panel.pie, text.panel=panel.txt)

#num.cols <- sapply(df, is.numeric)
#num.cols

#corrplot(df.model,method= "number",diag=FALSE )

#split the data 
df.model <- df[1:6000,]
df.predict <- df[6001:9142,]

#build the model

#check the na

any(is.na(df.model))
any(is.na(df.predict))



# seperate the training and testing 
glimpse(train)
sample <- sample.split(df.model$Price, SplitRatio = 0.7)
train <- subset(df.model, sample == TRUE)
test <- subset(df.model, sample == FALSE )
head(test,100)
head(train,100)

#Build the model
#TTT
reg.model <- lm(Price ~., train)
summary(reg.model)

#Stepwise
start <- lm(Price ~1, train)
fitall <- lm(Price ~., train)
reg.stepwise <- step(start, direction ='forward',scope=formula(fitall)) # Carat_Weight + Clarity + Color + Cut + Symmetry
summary(reg.model)
summary(reg.stepwise)#Carat, Color, Clarity, Cut

reg.1<- lm(Price ~ Carat_Weight + Cut + Color + Clarity, train)
summary(reg.1)
plot(reg.1)
plot(density(residuals(reg.1)))

#
reg.2 <- lm(log(Price) ~ log(Carat_Weight)*Cut*Color*Clarity + Cut + Color*Clarity+ Clarity, train)
summary(reg.2)
plot(reg.2)
plot(density(residuals(reg.2)))

test$Carat_Weight <- (test$Carat_Weight)
test$Price <- (test$Price)
#Prediction on test dataset and evaluate the performance of our model
head(test)
Price.predictions <- predict(reg.2, test)
head(exp(Price.predictions))

results <- cbind(exp(Price.predictions),test$Price)

colnames(results) <- c('predicted', 'actual')

results <- as.data.frame(results)
head(results,100)

mse <- mean((results$actual-results$predicted)^2)
print(mse)

print(mse^0.5)

mean(df.model$Price)
mean(test$Price)
mean(train$Price)
SSE <- sum((results$predicted- results$actual)^2)
SST <- sum((results$actual - mean(df.model$Price))^2)
R2 <- 1 - SSE/SST
R2

#Predict

predicted.value <- predict(reg.2, df.predict)
predicted.value
df.predict$Price <- exp(predicted.value)
head(df.predict,20)

#Export
write.xlsx(df.predict$Price, "Price_prediction2.xlsx")

