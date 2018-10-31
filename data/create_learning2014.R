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
# original scales (by taking the mean) (https://campus.datacamp.com/courses/helsinki-open-data-science/regression-and-model-validation?ex=2).
# Exclude observations where the exam points variable is zero. 
# (The data should then have 166 observations and 7 variables)

gender <- mydata$gender
age <- mydata$Age
attitude <- mydata$Attitude/10
d_sm <- mydata$D03+mydata$D11+mydata$D19+mydata$D27
d_sm <- d_sm/4
d_ri <- mydata$D07+mydata$D14+mydata$D22+mydata$D30
d_ri <- d_ri/4
d_ue <- mydata$D06+mydata$D15+mydata$D23+mydata$D31
d_ue <- d_ue/4
deep <- d_sm+d_ri+d_ue
deep <- deep/3
st_os <- mydata$ST01+mydata$ST09+mydata$ST17+mydata$ST25
st_os <- st_os/4
st_tm <- mydata$ST04+mydata$ST12+mydata$ST20+mydata$ST28
st_tm <- st_tm/4
stra <- st_os+st_tm
stra <- stra/2
su_lp <- mydata$SU02+mydata$SU10+mydata$SU18+mydata$SU26
su_lp <- su_lp/4
su_um <- mydata$SU05+mydata$SU13+mydata$SU21+mydata$SU29
su_um <- su_um/4
su_sb <- mydata$SU08+mydata$SU16+mydata$SU24+mydata$SU32
su_sb <- su_sb/4
surf <- su_lp+su_um+su_sb
surf <- surf/3
points <- mydata$Points
analysis_dataset <- data.frame(gender, age, attitude, deep, stra, surf, points)
#analysis_dataset <- filter(analysis_dataset, points > 0)
#analysis_dataset does not work after this, prints all NA values
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
a_data

# Analysis (max 15 points)
mydata <- read.csv("learning2014.csv")
mydata <- mydata[-1]
mydata
install.packages('ggplot2')
library(ggplot2)
p1 <- ggplot(mydata, aes(x = attitude, y = points, col = gender))
p2 <- p1 + geom_point()
p3 <- p2 + geom_smooth(method = "lm")
p3
summary(mydata)
