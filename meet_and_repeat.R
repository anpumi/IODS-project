<<<<<<< HEAD
# Annukka Puotiniemi
# 30.11.2018
# Data wrangling exercise for week 6

#~~~ BPRS Data Wrangling ~~~

# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

# Look at the (column) names of BPRS
names(BPRS)

# Look at the structure of BPRS
str(BPRS)

# print out summaries of the variables
summary(BPRS)

# The BPRS data includes 40 observations and 11 variables. The variables are all in
# integer format. The first two variables, treatment and subject, are the identifying
# variables. The rest of the variables specify the BPRS score throughout the
# treatment weeks. If you wanted to look at the scores of an individual test subject,
# you would read the data line by line. So, subject number 1 (who received treatment 1)
# has a BPRS score from week 0 to week 8 of 42, 36, 36, 43, 41, 40, 38, 57 and 51.

# The following is the description of the data set from DataCamp:
# "40 male subjects were randomly assigned to one of two treatment groups and each
# subject was rated on the brief psychiatric rating scale (BPRS) measured before 
# treatment began (week 0) and then at weekly intervals for eight weeks. The BPRS 
# assesses the level of 18 symptom constructs such as hostility, suspiciousness, 
# hallucinations and grandiosity; each of these is rated from one (not present) to
# seven (extremely severe). The scale is used to evaluate patients suspected of 
# having schizophrenia."

# Therefore, subject number one, in week 0, scored an average of 2.33 from each of
# the 18 symptom construct measurements. By the last week, the average for this
# subject was 2.83. 

# Access the packages dplyr and tidyr
library(dplyr)
library(tidyr)

# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# Take a glimpse at the BPRSL data
glimpse(BPRSL)

# In the long form, the data consists of 360 observations and 5 variables. Now the 
# data is in long form, all of the 40 BPRS scores for each week can be found
# listed vertically in a column, hence "long" form. In the "wide" form we read the
# data horizontally.

write.table(BPRSL, file = "bprsl.csv", row.names=FALSE)

#~~~ RATS Data Wrangling ~~~

# read the RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Also, take a look at the data sets: check their variable names, 
# view the data contents and structures, and create some brief summaries of 
# the variables, so that you understand the point of the wide form data.

# Factor variables ID and Group
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Glimpse the data
glimpse(RATS)

# Convert data to long form
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

# Glimpse the data
glimpse(RATSL)

# In the wide form, the dataset consists of 16 observations and 13 variables.
# In the long form, there are 176 observations of 5 variables. The same principle
# for wide vs long applies here as it did in BPRSL.

# RATS is from a "nutrition study conducted in three groups of rats (Crowder and 
# Hand, 1990). The three groups were put on different diets, and each animal's body 
# weight (grams) was recorded repeatedly (approximately weekly, except in week 
# seven when two recordings were taken) over a 9-week period. The question of most
# interest is whether the growth profiles of the three groups differ". p. 22
# here: https://mooc.helsinki.fi/pluginfile.php/29659/course/section/2208/MABS4IODS-Part6.pdf

write.table(RATSL, file = "ratsl.csv", row.names=FALSE)

=======
# Annukka Puotiniemi
# 30.11.2018
# Data wrangling exercise for week 6

#~~~ BPRS Data Wrangling ~~~

# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

# Look at the (column) names of BPRS
names(BPRS)

# Look at the structure of BPRS
str(BPRS)

# print out summaries of the variables
summary(BPRS)

# The BPRS data includes 40 observations and 11 variables. The variables are all in
# integer format. The first two variables, treatment and subject, are the identifying
# variables. The rest of the variables specify the BPRS score throughout the
# treatment weeks. If you wanted to look at the scores of an individual test subject,
# you would read the data line by line. So, subject number 1 (who received treatment 1)
# has a BPRS score from week 0 to week 8 of 42, 36, 36, 43, 41, 40, 38, 57 and 51.

# The following is the description of the data set from DataCamp:
# "40 male subjects were randomly assigned to one of two treatment groups and each
# subject was rated on the brief psychiatric rating scale (BPRS) measured before 
# treatment began (week 0) and then at weekly intervals for eight weeks. The BPRS 
# assesses the level of 18 symptom constructs such as hostility, suspiciousness, 
# hallucinations and grandiosity; each of these is rated from one (not present) to
# seven (extremely severe). The scale is used to evaluate patients suspected of 
# having schizophrenia."

# Therefore, subject number one, in week 0, scored an average of 2.33 from each of
# the 18 symptom construct measurements. By the last week, the average for this
# subject was 2.83. 

# Access the packages dplyr and tidyr
library(dplyr)
library(tidyr)

# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# Take a glimpse at the BPRSL data
glimpse(BPRSL)

# In the long form, the data consists of 360 observations and 5 variables. Now the 
# data is in long form, all of the 40 BPRS scores for each week can be found
# listed vertically in a column, hence "long" form. In the "wide" form we read the
# data horizontally.

write.table(BPRSL, file = "bprsl.csv", row.names=FALSE)

#~~~ RATS Data Wrangling ~~~

# read the RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Also, take a look at the data sets: check their variable names, 
# view the data contents and structures, and create some brief summaries of 
# the variables, so that you understand the point of the wide form data.

# Factor variables ID and Group
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Glimpse the data
glimpse(RATS)

# Convert data to long form
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

# Glimpse the data
glimpse(RATSL)

# In the wide form, the dataset consists of 16 observations and 13 variables.
# In the long form, there are 176 observations of 5 variables. The same principle
# for wide vs long applies here as it did in BPRSL.

# RATS is from a "nutrition study conducted in three groups of rats (Crowder and 
# Hand, 1990). The three groups were put on different diets, and each animal's body 
# weight (grams) was recorded repeatedly (approximately weekly, except in week 
# seven when two recordings were taken) over a 9-week period. The question of most
# interest is whether the growth profiles of the three groups differ". p. 22
# here: https://mooc.helsinki.fi/pluginfile.php/29659/course/section/2208/MABS4IODS-Part6.pdf

write.table(RATSL, file = "ratsl.csv", row.names=FALSE)

>>>>>>> c1c63f1f2bba6b41fbc657c5b20d2b946c8b8396
#~~~ End of Data Wrangling ~~~