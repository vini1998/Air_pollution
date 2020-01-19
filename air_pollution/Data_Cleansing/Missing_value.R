setwd("C:/Users/optra/Desktop/pollution")
pollu.full <- read.csv(file = "new_orginal.csv")
               str(pollu.full)
View(pollu.full)
head(pollu.full)
summary(pollu.full)
install.packages("ggplot2")

dim(pollu.full)

names(pollu.full)

library(dplyr)
glimpse(pollu.full)

summary(pollu.full)

hist(pollu.full$X_wdire)

#install.packages("VIM")
library(VIM)
?kNN()

pollu.find <- kNN(pollu.full, variable = c("SO_2","PM10"), k=6)
summary(pollu.find)

pollu.impute <- kNN(pollu.full)
summary(pollu.impute)

head(pollu.impute)

pollu.impute <- subset(pollu.impute, select =T:PM.2.5 )
head(pollu.impute)

write.csv(pollu.impute, file = "new_orginal.csv")

#install.packages("keras")

library(keras)
