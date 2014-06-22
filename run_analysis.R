# Getting and Cleaning Data - Course Project

# Creates a tidy data set based on the Human Activity Recognition Using Smartphones Dataset
# Data Set: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Information on the Project: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# You should create one R script called run_analysis.R that does the following: 
# 	1. Merges the training and the test sets to create one data set.
#	2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#	3. Uses descriptive activity names to name the activities in the data set
#	4. Appropriately labels the data set with descriptive variable names. 
#	5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Packages - plyr, data.table
library("plyr", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
library("data.table", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")


### === Features === 
# Each feature vector is a row on the text file.

# Set working directory for Features
setwd("~/Documents/Coursera - Data Science Specialization/Part 3 - Getting and Cleaning Data/UCI Har Dataset/")

feat <- read.table("features.txt") # 561 rows; 2 columns
tfeat <- t(feat) # transposes feat rows to columns
feat <- tfeat[2,] # singles out only the features

featgrep <- grep("\\mean()|std()", feat$V2)
featsub <- feat$V2[featgrep] # need to remove rows 47:49, 56:58, 65:67,70,73,76,79 -> meanFreq()
featnew <- featsub[c(-47:-49,-56:-58,-65:-67,-70,-73,-76,-79)] # removes the "-meanFreq()" features from featsub

featnew <- as.data.frame(featnew) # converts the factor vector to a data frame

# I think xtest & xtrain column names are the row names from feat

### === Activity Labels ===
# Same wd as Features
# These labels correstpond to the y files
labels <- read.table("activity_labels.txt")

### === Test Set ===
# Set working directory for Test folder
setwd("~/Documents/Coursera - Data Science Specialization/Part 3 - Getting and Cleaning Data/UCI Har Dataset/test")

# Reads in Test folder data
subjtest <- read.table("subject_test.txt") #2947 rows; 1 column "V1"
xtest <- read.table("X_test.txt") #2947 rows; 561 col V1:V561

setnames(xtest, old = colnames(xtest), new = t(feat)) # xtest column names to features; data.table package

# Need to remove columns from xtest I don't need

xtestgrep <- grep("\\mean()|std()", colnames(xtest))
xtestsub <- xtest[xtestgrep] # need to remove rows 47:49, 56:58, 65:67,70,73,76,79 -> meanFreq()
xtestnew <- xtestsub[c(-47:-49,-56:-58,-65:-67,-70,-73,-76,-79)] # removes the "-meanFreq()" features from xtestsub

ytest1 <- read.table("y_test.txt") #2947 rows; 1 col "V1"; Activity Labels
ytest2 <- rename(ytest1, replace=c("V1" = "Activity")) # Rename ytest column
subjtest2 <- rename(subjtest, replace=c("V1" = "Subject"))
ytest3 <- cbind(subjtest2,ytest2)
testbind1 <- cbind(ytest3,xtestnew)

# add a column to the right of Activity called "Data" and add "test" in every row
testbind1["Data"] <- "test"
testbind2 <- subset(testbind1, select=c(Data, Subject, Activity:67)) # reorder columns

# === Training Set ===
# Set working directory for Train folder
setwd("~/Documents/Coursera - Data Science Specialization/Part 3 - Getting and Cleaning Data/UCI Har Dataset/train")

# Reads in Train folder data
subjtrain1 <- read.table("subject_train.txt") #7352 rows; 1 column "V1"
xtrain <- read.table("X_train.txt") #7352 rows; 561 col V1:V561

setnames(xtrain, old = colnames(xtrain), new = t(feat)) # xtrain column names to features; data.table package

# Need to remove columns from xtrain I don't need
xtraingrep <- grep("\\mean()|std()", colnames(xtrain))
xtrainsub <- xtrain[xtraingrep] # need to remove rows 47:49, 56:58, 65:67,70,73,76,79 -> meanFreq()
xtrainnew <- xtrainsub[c(-47:-49,-56:-58,-65:-67,-70,-73,-76,-79)] # removes the "-meanFreq()" features from xtrainsub

ytrain1 <- read.table("y_train.txt") #7352 rows; 1 col "V1"; Activity Labels
ytrain2 <- rename(ytrain1, replace=c("V1" = "Activity"))# Rename ytrain column
subjtrain2 <- rename(subjtrain1, replace=c("V1" = "Subject"))
ytrain3 <- cbind(subjtrain2,ytrain2)
trainbind1 <- cbind(ytrain3,xtrainnew)

# add a column to the right of Activity called "Data" and add "train" in every row
trainbind1["Data"] <- "train"
trainbind2 <- subset(trainbind1, select=c(Data, Subject, Activity:67)) # reorder columns

### === Combine Test and Train into One Data Set ===
df <- rbind(testbind2,trainbind2)

### === Average of each variable for each activity and each subject === 

# Average of each variable by Activity
# Activity: Column 3 of df
# Variable: Column 4:68 of df
colMeans(df[4:68])


### === Create tidy data set ===

# set correct working directory
setwd("~/Documents/Coursera - Data Science Specialization/Part 3 - Getting and Cleaning Data/Course Project/")

# write.table
write.table(df, file = "tidydata.txt")