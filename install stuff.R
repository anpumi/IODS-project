install.packages("corrplot")
install.packages("tidyr")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("GGally")
library(ggplot2)
library(dplyr)
library(GGally)
library(tidyr)
library(corrplot)

names(km)
  
#  [1] "cluster"      "centers"      "totss"        "withinss"    
#[5] "tot.withinss" "betweenss"    "size"         "iter"        
#[9] "ifault"  

cluster <- km$cluster
str(cluster)
cluster <- as.data.frame(cluster)
str(cluster)
str(boston_K2_scaled)
bonus_data <- merge(boston_K2_scaled, cluster)
str(bonus_data)
bonus_data
cluster
# access the centers component in the kmeans data
km_cluster <- as.data.frame(km$cluster)
# number of rows in the km dataset 
n <- nrow(km_cluster)
n

# choose randomly 80% of the rows
ind <- sample(n,  size = n * 0.8)

# create train set
train <- km_cluster[ind,]

# create test set 
test <- km_cluster[-ind,]

# linear discriminant analysis
lda.fit <- lda(crim ~ ., data = train)

# print the lda.fit object
lda.fit

matrix_product

cor(human) %>% corrplot
