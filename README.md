Course-Project
==============

Getting and Cleaning Data - Part 3 of JHU Data Science Specialization on Coursera
Course Project

This course project creates a tiny data set from raw data. This repository contains three files: run_analysis.R, a code book, and a text file that contains the run_analysis output.

Below is the course project assignment:

You should create one R script called run_analysis.R that does the following:
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names. 
  5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

A tiny data set has four components:

1. Each variable you measure should be in one column
2. Each different observation of that variable should be in a different row
3. There should be one table for each "kind" of variable
4. If you have multiple tables, they should include a column in the table that allows them to be linked
(Source: http://jtleek.com/modules/03_GettingData/01_03_componentsOfTidyData/#4)

The Raw Data Set
The data set used in this project is from the Human Activity Recognition Using Smartphones Dataset. The data set is here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
The web site for the project is here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.


The raw data is split into two folders, train and test. There is also an activity_labels.txt, features_info.txt, and features.txt files that apply to the train and test folders. Within each train and test file, there are

Tidying Up The Data

The column names in the xtest/xtrain text files within the train and test folders correspond to the row names from the features file.

Step 1. Load packages into R: plyr and data.table

Step 2. Read features.txt file into R
  2a. Create object feat based on features.txt. The object has the variable names that are measured by test and train subject and activity
  2b. Transpose feat from rows to columns because these correspond to the xtest/xtrain columns
  2c. Remove the first row from the tranposed features
  2d. Create a data set for features that keep only the mean() and std() variable names that we will average later

Step 3. Read activity_labels.txt file into R
  These activity labels are the six activities that are tested: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING  

Step 4. Read test folder files into R
  4a. Read in subject text file
  4b. Read in X_test file
  4c. Rename the X_test columns to those from the features file (used data.table package, setnames function)
  4d. Remove the columns (variables) from xtest that we don't need
    4d-i. I remove the meanFreq() variables in a separate line of code because they were in the original grep() function
  4e. Read in the y_test file and replace column V1 to Activity
  4f. Bind the subject file to the ytest object after changing subjtest column to Subject
  4g. Bind the y and x data frames together

Step 5. Read train folder files into R
  The same steps are used for the train folder files as the test folder files 

Step 6. Combine test and train data into one data set

Step 7. Create the tidy data set in R
  7a. Find colMeans by Activity and by Subject for each variable

Step 8. Create a text file with the tidy data set










