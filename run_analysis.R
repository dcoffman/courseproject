#Getting and Cleaning Data Course Project
#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#Creates a second, independent tidy data set with the average of each variable for each 
#activity and each subject. 

rm(list=ls(all=TRUE))
setwd("C:\\Users\\dlc30\\Cloud Drive\\Videos\\Getting and Cleaning Data\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset")

#library(Hmisc)

#Appropriately labels the data set with descriptive variable names
feature.names <- scan("features.txt", what=character())
feature.names <- feature.names[seq(2, length(feature.names), 2)]
activity.labels <- scan("activity_labels.txt", what=character())
activity.labels <- activity.labels[seq(2, length(activity.labels), 2)]

#Read in the data
Xtest <- read.table("./test/X_test.txt", col.names=feature.names)
ytest <- read.table("./test/y_test.txt", col.name="activity")
Xtrain <- read.table("./train/X_train.txt", col.names=feature.names)
ytrain <- read.table("./train/y_train.txt", col.name="activity")

subject <- scan("./test/subject_test.txt")
Xtest <- cbind(Xtest, subject)
subject <- scan("./train/subject_train.txt")
Xtrain <- cbind(Xtrain, subject)

#merge training and test data sets
Xcombined <- rbind(Xtest, Xtrain)
Ycombined <- rbind(ytest, ytrain)
all <- cbind(Xcombined, Ycombined)

#Use descriptive activity names to name the activities in the data set
all$activity.f <- factor(all$activity, labels = activity.labels)
walking <- all[all$activity.f=="WALKING",562]

#Extract only the measurements on the mean and standard deviation
varlist <- function (df=NULL,type=c("numeric","factor","character"), pattern="", exclude=NULL) {
     vars <- character(0)
     if (any(type %in% "numeric")) {
          vars <- c(vars,names(df)[sapply(df,is.numeric)])
     }
     if (any(type %in% "factor")) {
          vars <- c(vars,names(df)[sapply(df,is.factor)])
     }  
     if (any(type %in% "character")) {
          vars <- c(vars,names(df)[sapply(df,is.character)])
     }  
     vars[(!vars %in% exclude) & grepl(vars,pattern=pattern)]
}

subsetAll <- all[,varlist(all, pattern="mean|std")]
subsetAll <- cbind(subsetAll, all$activity, all$activity.f, all$subject)

#Create a second, independent tidy data set with the average of each variable
#for each activity and each subject.
library(reshape2)
var.names <- names(subsetAll[1:79])

AvgMelt <- melt(subsetAll, id=c("all$subject", "all$activity.f"), 
                measure.vars=var.names)
head(AvgMelt)
tail(AvgMelt)

AvgData <- dcast(AvgMelt, all$subject + all$activity.f ~ variable, mean)

write.table(AvgData, file = "tidydat.txt")