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

## ~ ~ Data Wrangling for Chapter 5 ~ ~
# Annukka Puotiniemi
# 21.11.2018
# Data wrangling exercise
# This is my script file for chapter 5 data wrangling, continued from last week.
# Link to the original data source (2 files, that I have already combined to the "human" data found below):
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv


# Load the human data into R. Explore the structure and the dimensions of the data. Describe the data briefly.

human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)
str(human) # the data has 195 observations and 19 variables, as it should.
head(human)
summary(human)
names(human)

# This data originates from the United Nations Development Programme. The Human Development Index (HDI) was created
# to emphasize that, for an assesment of the development of a country, economic growth is not enough as a measure.
# Instead, people and their capabilities should be the assesment criteria. The HDI is made up of three indices:
# Life Expectancy Index, Education Index, and GNI Index.
# More information about the index can be found here: http://hdr.undp.org/en/content/human-development-index-hdi
# The data combines several indicators, collected from most countries in the world. The descriptions of the
# variables can be found here: https://raw.githubusercontent.com/TuomoNieminen/Helsinki-Open-Data-Science/master/datasets/human_meta.txt

# 1. Mutate the data: transform the Gross National Income (GNI) variable to numeric 

library(stringr)
str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric$GNI
human$GNI <- as.numeric(human$GNI)
human$GNI

# 2. Exclude unneeded variables: keep only the columns matching the following variable names (described in the meta
# file above):  "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"

# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))

# 3. Remove all rows with missing values

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human <- filter(human, complete.cases(human))

# 4. Remove the observations which relate to regions instead of countries

# look at the last 10 observations
tail(human, 10)

# last indice we want to keep
last <- nrow(human) - 7

# choose everything until the last 7 observations
human <- human[1:last, ]

# 5. Define the row names of the data by the country names and remove the country name column from the data. 
# The data should now have 155 observations and 8 variables. 
# add countries as rownames
rownames(human) <- human$Country


# remove the Country variable
human <- select(human, -Country)

str(human) # 155 observations and 8 variables, correct!

# Save the human data in your data folder including the row names. You can overwrite your old 'human' data. 
write.csv(human, file = "create_human.csv", row.names=TRUE)
 
## ~ ~ End of Data Wrangling ~ ~
