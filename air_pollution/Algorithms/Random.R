setwd("C:/Users/optra/Desktop/Pollution_final/Air_pollution/air_pollution/Data/Orginal_datas")
air_rand <- read.csv(file = "orginal_4.csv")

str(air_rand)
summary(air_rand)

#partition

set.seed(1234)
ind <- sample(2, nrow(air_rand),replace = TRUE, prob = c(0.7, 0.3))
train <- air_rand[ind==1,]
test <- air_rand[ind==2,]
View(train)
#random forest

install.packages("randomForest")
library(randomForest)
set.seed(222)
rf <- randomForest(PM25~., air_rand=train)
print(rf)
attributes(rf)

#prediction and confusion matrix -train data

library(caret)
