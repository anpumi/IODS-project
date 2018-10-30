# Annukka Puotiniemi
# 25.10.2018
# This is my data wrangling exercise file

mydata <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header=TRUE, sep="\t")
str(mydata)
mydata

# The data frame consist of 183 observations of 60 variables, all of which are integers.

# Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points 
# by combining questions in the learning2014 data, as defined in the datacamp exercises and also on 
# the bottom part of the following page (only the top part of the page is in Finnish).
# http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS2-meta.txt. Scale all combination variables to the 
# original scales (by taking the mean). Exclude observations where the exam points variable is zero. 
# (The data should then have 166 observations and 7 variables)

gender <- mydata$gender
age <- mydata$Age
attitude <- mydata$Attitude
d_sm <- mydata$D03+mydata$D11+mydata$D19+mydata$D27
d_ri <- mydata$D07+mydata$D14+mydata$D22+mydata$D30
d_ue <- mydata$D06+mydata$D15+mydata$D23+mydata$D31
deep <- d_sm+d_ri+d_ue
st_os <- mydata$ST01+mydata$ST09+mydata$ST17+mydata$ST25
st_tm <- mydata$ST04+mydata$ST12+mydata$ST20+mydata$ST28
stra <- st_os+st_tm
su_lp <- mydata$SU02+mydata$SU10+mydata$SU18+mydata$SU26
su_um <- mydata$SU05+mydata$SU13+mydata$SU21+mydata$SU29
su_sb <- mydata$SU08+mydata$SU16+mydata$SU24+mydata$SU32
surf <- su_lp+su_um+su_sb
points <- mydata$Points
analysis_dataset <- data.frame(gender, age, attitude, deep, stra, surf, points)
a_dataset <- analysis_dataset[apply(analysis_dataset!=0, 1, all),] #I found this solution for excluding
# zero value observations in StackOverflow. I now have the correct number of observations and variabes, 
# but this method would exclude all other zero rows too I think...

# Set the working directory of you R session the iods project folder (study how to do this with RStudio). 
# Done by choosing 'Session' > 'Set Working Directory' > 'Choose Directory...'

# Save the analysis dataset to the 'data' folder, using for example write.csv() or write.table() functions. 
# You can name the data set for example as learning2014(.txt or .csv). See ?write.csv for help or search the 
# web for pointers and examples. Demonstrate that you can also read the data again by using read.table() or 
# read.csv().  (Use `str()` and `head()` to make sure that the structure of the data is correct). 
write.csv(a_dataset, file = "learning2014.csv")
a_data <- read.csv("learning2014.csv")
str(a_data)
head(a_data)
