# install.packages("dplyr")
# install.packages("caret")
# install.packages("ggplot2")

# set directory and read csv file
setwd("C:/Users/optra/Desktop/data")
padipp <- read.csv(file = "orginal_2.csv")
 
# Removing the first column
library("dplyr")
padipp %>% select(-1) -> padipp
View(padipp)

#install.packages("caTools")
library(caTools)

# Splitting data

sample.split(padipp$Rainfall,SplitRatio = 0.65) -> split_values
subset(padipp,split_values==T) -> train_set
subset(padipp,split_values==F) -> test_set

str(padipp)


#classification Prediction
# Recursive partitioning
#install.packages("rpart")
# library(rpart)
# rpart(PM25~.,data = train_set)->mod_set
# predict(mod_set,test_set,type = "vector")->result_class
# table(test_set$PM25,result_class)



library(ggplot2)
View(padipp)
sample.split(padipp$Temperature..,SplitRatio = 0.65) -> split_values
subset(padipp,split_values==T) -> train_set
subset(padipp,split_values==F) -> test_set

# prediction Regression

lm(PM25~.,data = train_set) -> mod_set
predict(mod_set,test_set) -> result_class
cbind(actual=test_set$PM25,predicted=result_class) -> final_data
as.data.frame(final_data) -> final_data

View(final_data)



#finding Errors
(final_data$actual- final_data$predicted) -> error
cbind(final_data,error) -> final_data

#finding root mean Square (lower the rmse value means that better the model)
rmse <- sqrt(mean(final_data$error^2))
rmse

table(final_data$actual)

install.packages("caret")

 