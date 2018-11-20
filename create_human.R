# Annukka Puotiniemi
# 20.11.2018
# Data wrangling exercise
# This is my script file for chapter 5 data wrangling, done in week 4.

# Part 1. - create new script file is done, hence you're reading this :)

# Part 2. Read the two csv files

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Part 3. See the structure and dimensions of the data, and create summaries of the variables

str(hd)
head(hd)
summary(hd)

str(gii)
head(gii)
summary(gii)

# Part 4. Look at the meta files and rename the variables with (shorter) descriptive names

names(hd)
names(gii)

colnames(hd) <- c("HDI.Rank","Country","HDI","Life.Exp","Edu.Exp","Edu.Mean","GNI","GNI.Minus.Rank")
colnames(gii) <- c("GII.Rank", "Country", "GII","Mat.Mor","Ado.Birth","Parli.F","Edu2.F","Edu2.M","Labo.F","Labo.M")

# Part 5. Mutate the "Gender inequality" data and create two new variables. The first one should be the ratio of 
# Female and Male populations with secondary education in each country. (i.e. edu2F / edu2M). The second new 
# variable should be the ratio of labour force participation of females and males in each country
# (i.e. labF / labM).

gii <- mutate(gii, Edu2.FM = Edu2.F/Edu2.M)
gii <- mutate(gii, Labo.FM = Labo.F/Labo.M)

# Part 6. Join together the two datasets using the variable Country as the identifier. Keep only the countries 
# in both data sets (Hint: inner join). The joined data should have 195 observations and 19 variables. Call the
# new joined data "human" and save it in your data folder.

library(dplyr)
human <- inner_join(hd, gii, by = "Country")
str(human) # making sure that the data has 195 obs and 19 variables

write.csv(human, file = "create_human.csv", row.names=FALSE)
human <- read.table("create_human.csv", sep = "," , header=TRUE)
human

## ~ ~ End of Data Wrangling ~ ~
