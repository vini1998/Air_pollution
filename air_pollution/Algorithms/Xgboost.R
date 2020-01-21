library(xgboost)
library(magrittr)
library(dplyr)
library(Matrix)
library(caret)



data <- read.csv(file = "orginal_4.csv")
str(data)


#partitioning 

set.seed(1234)
ind <- sample(2, nrow(data), replace = T, prob = c(0.8, 0.2))
train <- data[ind==1,]
test <- data[ind==2,]


#matrix

trainm <- sparse.model.matrix(PM25 ~ .-1, data = train)
head(trainm)
train_label <- train[,"PM25"]
train_matrix <- xgb.DMatrix(data = as.matrix(trainm), label = train_label)


testm <- sparse.model.matrix(PM25~.-1, data = train)
test_label <- train[,"PM25"]
test_matrix <- xgb.DMatrix(data = as.matrix(testm), label = test_label)



#parameters


nc <- length(unique(train_label))
nc
xgb_params <- list("objective" = "multi:softprob",
                   "eval_metric" = "mlogloss",
                   "num_class" = nc)
watchlist <- list(train =train_matrix, test = test_matrix)


#Xgboost Model

bst_model <-xgb.train(params = xgb_params,
                      data = train_matrix,
                      nrounds = 100,
                      watchlist = watchlist) 
                      #eta = 0.3
                      # max.depth = 6  tree depth setting
                      # gamma = 0    larger value more conservative algorithm
                      # subsample = 1   0 to 1 to prevent overfitting
                      # colsample_bytree = 1
                      # missing = NA
                      # seed = 333
                      


#training and testing error plot
 e <- data.frame(bst_model$evaluation_log)
plot(e$iter, e$train_mlogloss, col = 'blue')
lines(e$iter, e$train_mlogloss, col = 'red')

min(e$train_mlogloss)
e[e$train_mlogloss == 2.858893, ]



#feature importence

imp <- xgb.importance(colnames(train_matrix), model = bst_model)
print(imp)
xgb.plot.importance(imp)



#prediction and confustion matrix - testdata

p <- predict(bst_model, newdata = test_matrix)
head(p)
pred <- matrix(p, nrow = nc, ncol = length(p)/nc) %>%
  t() %>%
  data.frame() %>%
  mutate(label = test_label, max_prob = max.col(., "last")-1)
head(pred)


table(Prediction = pred$max_prob, Actual = pred$label)

plot(pred)

