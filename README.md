---
title: "Getting and Cleaning Data Course Project README"
author: "Ala Salem"
date: "November 22, 2015"
---

## Project Description
The purpose of the project is collect and clean the Human Activity and Recognition
Using Smartphone Data Set and obtain averages for subjects and activites for a subset
of the data (those measurement that are a mean or standard deviation).

Link to Data Set Page: https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Link to download data set: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Description of Script

###Guide to create the tidy data file
1. Place run_analysis.R in your working directory
2. Source run_analysis.R it will create a text file tidy_data_set.txt in your working directory

###How the script works
1. Check if data ("Dataset.zip") is available in working directory
  A. If not it will download "Dataset.zip"
2. Unzip "Dataset.zip" into working directory
3. Read in test data (subject_test.txt, X_test.txt, Y_test.txt)
4. Read in train data (subject_train.txt, X_train.txt, Y_train.txt)
5. Join together test and train data
6. Determine what values to keep via read in "features.txt" (any with mean or std in name)
7. Read in activity data (activity_labels.txt)
8. Replace coded values with descriptive activity names
9. All data binded together in data_set with subject first, activity second,
   and relevant data points following
10. Calculate the mean of data set by activity and subject
11. Write out tidy data set ("tidy_data_set.txt") to working dirctory