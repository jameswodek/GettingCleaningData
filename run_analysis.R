###############################################################################
## Week 3 Course Project
## 1. Merge training and test sets into one data set
## 2. Extract only the measurements on the mean and standard deviation
## 3. Use descriptive activity names to name the variables in the data set
## 4. Label the data set with descriptive variable names
## 5. From the data set in step 4, create a independent tidy data set with
##      the average of each variable for each activity and each subject
###############################################################################

# Clear your global enviroment
rm(list = ls())

# Load the ply and dplyr packacges. This will be used later
library(plyr)  
library(dplyr)


# This code assumes that you've already downloaded and extracted your data
# to your current working directory under the "UCI HAR Dataset" folder

#temp <- tempfile()
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)

#unzip(temp, list = TRUE) #This provides the list of variables and I choose the ones that are applicable for this data set

# Load data.table for fast subsetting, grouping, and updating
library(data.table)

MainDir <- file.path("UCI HAR Dataset")
testDir <- file.path("UCI HAR Dataset", "test")
trainDir <- file.path("UCI HAR Dataset","train")

Features <- read.table("UCI HAR Dataset/features.txt")
Activity <- read.table("UCI HAR Dataset/activity_labels.txt")

# Move to the test directory and pull all the subsequent files
Ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
Xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
SubjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Move to the train directory and pull all the subsequent files
Ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
Xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
SubjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")


# Now lets fix the column names because they are currently display as "V1 - V561"
# We'll use the Features file (now variable) to do so
# t() is a transpose function for Data Frames. We are transposing the names within
# the second column of the Features variable onto the columns of the XTrain
# variable. The same will be done for XTest. 
# Transpose has a similiar functionalty the to Microsoft Excel transpose feature
# I trust this because nrow(Features) and ncol(Xtrain) are equal lengths
colnames(Xtrain) <- t(Features[2])
colnames(Xtest) <- t(Features[2])
names(Activity) <- c("ID", "Activity")

# Now that the Xtrain and Xtest have column names, we assign an ID to the
# appropriate data sets.
Xtrain$variableID <- Ytrain[, 1]
Xtrain$users <- SubjectTrain[, 1]
Xtest$variableID <- Ytest[, 1]
Xtest$users <- SubjectTest[, 1]

##### Assignment 1: Time to merge the test and training data sets #####
Stats2 <- join(Xtrain, Xtest)

##### Assignment 2: get the mean and standard deviation ####

Mean2 <- grep("mean()", names(Stats2), value = FALSE, fixed = TRUE)


MeanStats2 <-Stats2[Mean2]

SDeviation2 <- grep("std()", names(Stats2), value = FALSE)


SDStats2 <- Stats2[SDeviation2]

# Assignment 3: Use descirpt acitivty names to name the variables (Activity variable)
Stats2$variableID[Stats2$variableID == 1] <- "WALKING"
Stats2$variableID[Stats2$variableID == 2] <- "WALKING UPSTAIRS"
Stats2$variableID[Stats2$variableID == 3] <- "WALKING DOWNSTAIRS"
Stats2$variableID[Stats2$variableID == 4] <- "SITTING"
Stats2$variableID[Stats2$variableID == 5] <- "STANDING"
Stats2$variableID[Stats2$variableID == 6] <- "LAYING"


#### Assignment 4: Create names ####
# Cleans up the hyphens
names(Stats2) <- gsub("-","",names(Stats2))

# Clean up SDeviation, Acc, Gyro, Mag, time, frequency
names(Stats2) <- gsub("SDeviation", "StandardDeviation", names(Stats2))
names(Stats2) <- gsub("Acc", "Accelerate", names(Stats2))
names(Stats2) <- gsub("Mag", "Magnitude", names(Stats2))
names(Stats2) <- gsub("Gyro", "Gyroscope", names(Stats2))
names(Stats2) <- gsub("^t", "Time", names(Stats2))
names(Stats2) <- gsub("^f", "Trequency", names(Stats2))


StatsTidyData <- data.table(Stats2)
# Take the mean by users and variables
StatsTD <- StatsTidyData[, lapply(.SD, mean), by = 'users,variableID']
# Output the tidy data set into a txt file called StatsTD
write.table(StatsTD, file = "StatsTD.txt", row.names = FALSE)