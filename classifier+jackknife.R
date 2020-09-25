library(rpart)
library(lattice)
library(ggplot2)
library(caret)
library(foreach)
library(iterators)
library(parallel)
library(doParallel)
library(adabag)
library(C50)

x<-read.csv("D\\address\\...")
x$label <- as.factor(x$label)
folds <- createFolds(y = x$label, k=nrow(x))
for(i in 1:nrow(x)){
  traindata<-x[-folds[[i]], ]
  testdata <- x[folds[[i]], ]
  print("***Group number***")
  print(i)
  
  x_adaboost <- boosting(label~. , data = traindata, mfinal = 260)
  pre_data <- predict(x_adaboost , newdata = testdata)$class
  pre_data <- as.factor(pre_data)
  value <- confusionMatrix(testdata$label , pre_data)
  print(value)
}
