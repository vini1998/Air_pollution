# install.packages("neuralnet")
# install.packages("mlbench")
library(keras)
library(mlbench)
library(dplyr)
library(magrittr)
library(neuralnet)

air <- read.csv(file = "orginal_4.csv")
str(air)
n <- neuralnet(PM25 ~ Temperature+Rainfall+Humidity+Wind.Speed..km.h.+Visibility+Pressure+so2+no2+PM10,
               data = air,
               hidden = c(10,5),
               linear.output = F,
               lifesign = 'full',
               rep = 1)
plot(n,
     col.hidden = 'darkgreen',
     col.hidden.synapse = 'darkgreen',
     show.weights = F,
     information = F,
     fill = 'lightblue')


#matrix
air <- as.matrix(air)
dimnames(air) <- NULL

#partitioning
set.seed(1234)
ind <- sample(2,nrow(air), replace = T, prob = c(.7, .3))
training <- air[ind==1,1:10]
testing <- air[ind==2,1:10]
trainingtarget <- air[ind==1, 10]
testingtarget <- air[ind==2, 10]


#Normalization

m <- colMeans(training)
s <- apply(training, 2, sd)

training <- scale(training, center = m, scale = s)

testing <- scale(testing, center = m, scale = s)

View(training)




# create model

model <- keras_model_sequential()
model %>%
  layer_dense(units = 5, activation = 'relu', input_shape = c(10)) %>%
  layer_dense(units = 1)

#compile

model %>% compile(loss ='mse', 
                  optimizer = 'rmsprop', 
                  metrics = 'mae')



mymodel <- model %>%
  fit(training,trainingtarget,
      epochs = 100,
      batch_size = 32,
      validation_split = 0.2)


#evaluate
model %>% evaluate(testing,testingtarget)

pred <- model %>% predict(testing)
mean((testingtarget-pred)^2)

plot(testingtarget, pred)



#fineTune model

model <- keras_model_sequential()
model %>%
  layer_dense(units = 10, activation = 'relu', input_shape = c(10)) %>%
  layer_dense(units = 5, activation = 'relu',) %>%
  layer_dense(units = 1)

summary(model)
#compile

model %>% compile(loss ='mse', 
                  optimizer = 'rmsprop', 
                  metrics = 'mae')



mymodel <- model %>%
  fit(training,trainingtarget,
      epochs = 100,
      batch_size = 32,
      validation_split = 0.2)


#evaluate
model %>% evaluate(testing,testingtarget)

pred <- model %>% predict(testing)
mean((testingtarget-pred)^2)

plot(testingtarget, pred)

#again fine tune

model <- keras_model_sequential()
model %>%
  layer_dense(units = 100, activation = 'relu', input_shape = c(10)) %>%
  layer_dropout(rate = 0.4) %>%
  layer_dense(units = 50, activation = 'relu',) %>%
  layer_dropout(rate = 0.3) %>%
  layer_dense(units = 20, activation = 'relu',) %>%
  layer_dropout(rate = 0.2) %>%
  layer_dense(units = 1)

summary(model)
#compile

model %>% compile(loss ='mse', 
                  optimizer = optimizer_rmsprop(lr = 0.002), 
                  metrics = 'mae')



mymodel <- model %>%
  fit(training,trainingtarget,
      epochs = 100,
      batch_size = 32,
      validation_split = 0.2)


#evaluate
model %>% evaluate(testing,testingtarget)

pred <- model %>% predict(testing)
mean((testingtarget-pred)^2)

plot(testingtarget, pred)




mean(pred)
