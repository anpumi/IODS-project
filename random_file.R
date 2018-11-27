hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
# http://hdr.undp.org/en/content/human-development-index-hdi
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
# http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf

library(tidyr)
library(dplyr)

dim(hd)
str(hd)
summary(hd)
colnames(hd)
colnames(hd)[1] <- "HDI_rank"
colnames(hd)[2]<- "country"
colnames(hd)[3]<- "HDI"
colnames(hd)[4]<- "expect"
colnames(hd)[5] <- "edu"
colnames(hd)[6] <- "medu"
colnames(hd)[7] <- "GNIpc"
colnames(hd)[8] <- "GNIHDIrank"
colnames(hd)

dim(gii)
str(gii)
summary(gii)
colnames(gii)

colnames(gii)[1]<- "GII_rank"
colnames(gii)[2]<- "country"
colnames(gii)[3]<- "GII"
colnames(gii)[4]<- "mort_rate"
colnames(gii)[5]<-"ado_birth"         
colnames(gii)[6]<- "rep_par"
colnames(gii)[7]<-"edu_F"
colnames(gii)[8]<- "edu_M"
colnames(gii)[9]<- "lab_F"
colnames(gii)[10]<-"lab_M"

colnames(gii)

edu_ratio <- gii$edu_F/gii$edu_M
lab_ratio <- gii$lab_F/gii$lab_M

gii_new <- mutate(gii, edu_ratio)
gii_new <- mutate(gii_new, lab_ratio)
colnames(gii_new)[2]<-"country"

library(dplyr)
join_by <- c("country")
HDI_GII <- inner_join(hd, gii_new, by = join_by)

colnames(HDI_GII)
dim(HDI_GII)
str(HDI_GII)
human <- HDI_GII
class(human)
dim(human)

pca_human <- prcomp(human, scale. = TRUE)
pca_human

# create and print out a summary of pca_human
s <- summary(pca_human)
s

# rounded percentages of variance captured by each PC
pca_pr <- round(100*s$importance[2,], digits = 1) 

# print out the percentages of variance
pca_pr

# create object pc_lab to be used as axis labels
pc_lab <- paste0(names(pca_pr), " (", pca_pr, "%)")

# draw a biplot
biplot(pca_human, cex = c(0.6, 1), col = c("grey40", "deeppink2"), xlab = pc_lab[1], ylab = pc_lab[2])
pca_human





humans <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)
library(stringr)
str_replace(humans$GNI, pattern=",", replace ="") %>% as.numeric$GNI
humans$GNI <- as.numeric(human$GNI)
keep <- c("HDI", "Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
humans <- select(humans, one_of(keep))
complete.cases(humans)
data.frame(humans[-1], comp = complete.cases(humans))
humans <- filter(humans, complete.cases(humans))
tail(humans, 10)
last <- nrow(humans) - 7
humans <- humans[1:last, ]
rownames(humans) <- humans$Country
humans <- select(humans, -Country)
str(humans)
write.csv(humans, file = "create_humans.csv", row.names=TRUE)

humans$devt[humans$HDI>=0.800]<-"Very High"
humans$devt[humans$HDI>=0.700 & humans$HDI<0.799]<-"High"
humans$devt[humans$HDI>=0.550 & humans$HDI<0.699]<-"Medium"
humans$devt[humans$HDI<0.550]<-"Low"

humans

pca_humans <- prcomp(~ . -HDI -Country -GNI, data=humans, scale. = TRUE)
s <- summary(pca_humans)
s
biplot(pca_humans, cex = c(0.6, 1), col = humans$devt, xlab = "PC1", ylab = "PC2")

install.packages("devtools")
install.packages("R6")
library(devtools)
install_github("vqv/ggbiplot")

library(ggbiplot)

g <- ggbiplot(pca_humans, obs.scale = 1, var.scale = 1, 
              groups = humans$devt, ellipse = TRUE, 
              circle = TRUE)
g <- g + scale_color_discrete(name = '')
g <- g + theme(legend.direction = 'horizontal', 
               legend.position = 'top')
print(g)
remove.packages("Rcpp")
