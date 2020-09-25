library(rpart)
library(cluster)
library(maptree)

x<-read.csv("D:\\address...")

rpart.fit <- rpart(label~. , data = x)
draw.tree(rpart.fit)

k<-rpart.fit$variable.importance

barplot(rpart.fit$variable.importance)
write.csv(k, file="D:\\paper\\DNA Binding protein\\data\\umap-Dimensionality reduction\\compare\\Isomap\\Isomap_BP594_1.csv")


