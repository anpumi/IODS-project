# Annukka Puotiniemi
# 8.11.2018
# Data wrangling exercise
# This is my script file for chapter 3 exercise, for which the data was downloaded from the UC Irvine Machine Learning Repository.
# P. Cortez and A. Silva. Using Data Mining to Predict Secondary School Student Performance. In A. Brito and J. Teixeira Eds., Proceedings of 5th FUture BUsiness TEChnology Conference (FUBUTEC 2008) pp. 5-12, Porto, Portugal, April, 2008, EUROSIS, ISBN 978-9077381-39-7.

# Read the two csv files and explore the structure and dimensions of the data:

math <- read.table("student-mat.csv", sep = ";" , header=TRUE)
str(math)
head(math)

por <- read.table("student-por.csv", sep = ";" , header=TRUE)
str(por)
head(por)

# Join the two data sets. Keep only the students present in both data sets. Explore the structure and dimensions of the joined data
library(dplyr)
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))
str(math_por)
head(math_por)
colnames(math_por)
glimpse(math_por)

# print out the column names of 'math_por'
colnames(mat_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)

# Take the average of the answers related to weekday and weekend alcohol consumption to create a new column
# 'alc_use' to the joined data. Then use 'alc_use' to create a new logical column 'high_use' which is TRUE
# for students for which 'alc_use' is greater than 2 (and FALSE otherwise).

library(dplyr); library(ggplot2)
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)

# Glimpse at the joined and modified data to make sure everything is in order. The joined data should now 
# have 382 observations of 35 variables. Save the joined and modified data set to the 'data' folder, using 
# for example write.csv() or write.table() functions.

glimpse(alc)
write.csv(alc, file = "create_alc.csv", sep = ";", header = TRUE)
alc_data <- read.table("create_alc.csv", sep = ";" , header=TRUE)
alc_data

## ~ ~ End of Data Wrangling ~ ~