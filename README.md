# GettingCleaningData
The objective of the run_analysis.R script is to perform all five of the following steps:
1) Merge the training data and test sets into one data set
2) Extract only the measurements on the mean and standard deviations
3) Use descriptive activity names to name the variables within the dat set
4) Label the data set
5) From the newly created dataset, create and output text file (Tidy Data set) with the average of each variable for each activity

The first step clears your Global enviroment via the rm() function

Next we load the plyr, dply, and data.table packages which will come into play later

We'll assign the file paths to the Main Dir, testDir, and trainDir variables.

Load the data into data frames

Change the column names from V1- V561 using the "Features" variable, which was derived from the features.txt file

Now, the code will join the two datasets (Xtrain and Xtest)

Once joined, the next step is part of the third assignment, which is to label our dataset with descriptive names

After names are appended/renamed, now the arithmetic takes place as well as subsetting the data

Once subsetted along with the means & standardeviations subsetted, this data is then exported into the StatsTD.txt file


