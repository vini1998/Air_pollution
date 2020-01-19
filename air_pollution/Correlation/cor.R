setwd("C:/Users/optra/Desktop/data")
air_pollu <- read.csv(file = "orginal_2.csv")
str(air_pollu)
table(is.na(air_pollu))
 
# Correlation of one by one features

res <- cor.test(air_pollu$PM25, air_pollu$Pressure..millibars., method = "kendall")
res


res <- cor.test(air_pollu$PM25, air_pollu$Temperature.., method = "kendall")
res


res <- cor.test(air_pollu$PM25, air_pollu$Rainfall, method = "kendall")
res


res <- cor.test(air_pollu$PM25, air_pollu$Humidity, method = "kendall")
res


res <- cor.test(air_pollu$PM25, air_pollu$Wind.Speed..km.h., method = "kendall")
res


res <- cor.test(air_pollu$PM25, air_pollu$Visibility..km., method = "kendall")
res


head(air_pollu)

res <- cor(air_pollu)
res
 
# install.packages("Hmisc")

library("Hmisc")
 
# Finding correlation matrix

res2 <- rcorr(as.matrix(air_pollu))
res2


res2$r

res2$P



# Correlation matric graph

#install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)


chart.Correlation(air_pollu, histogram=TRUE, pch=19)


# Splitting data
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










