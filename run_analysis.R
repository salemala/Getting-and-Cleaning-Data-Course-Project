## Getting and Cleaning Data Course Project

## Check if Samsung data is in the directory if not Download
if(!file.exists("Dataset.zip"))
{
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile = "./Dataset.zip")
}

## Extract Samsung data in working dirctory
unzip("Dataset.zip")

## Save location of working directory
path <- getwd()

## 1. Merge the training and the test sets to create one data set.

## Obtian test data
setwd("./UCI HAR Dataset/test")
subject_test <- read.table("subject_test.txt", header = FALSE)
X_test <- read.table("X_test.txt", header = FALSE)
Y_test <- read.table("Y_test.txt", header = FALSE)
setwd(path)

## Obtain train data
setwd("./UCI HAR Dataset/train")
subject_train <- read.table("subject_train.txt", header = FALSE)
X_train <- read.table("X_train.txt", header = FALSE)
Y_train <- read.table("Y_train.txt", header = FALSE)
setwd(path)

## Merge test and train data
subject_data <- rbind(subject_test, subject_train)
X_data <- rbind(X_test, X_train)
Y_data <- rbind(Y_test, Y_train)


## 2. Extract only the measurements on the mean and standard deviation for each measurement.

## Read in features information
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)

## Find mean and standard deviation values
mean_and_std <- grep(".mean.*|.std.*", features[,2], ignore.case = TRUE)

## Create key that has only data we are interested in
key_features <- features[mean_and_std,]


## 3. Use descriptive activity names to name the activities in the data set

## Read in activity data
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

## Give descriptive names to activities
names(activity_labels) <- c('Activity_Number', 'Activity_Name')


## 4. Appropriately label the data set with descriptive variable names. 

## Place descriptive names on the data
names(X_data) <- features[,2]

## Limit data to values we are interested in
X_data <- X_data[,key_features[,1]]

## Update coded activity with descriptive names
Y_data <- data.frame(Activity = activity_labels[match(Y_data$V1,
                                activity_labels$Activity_Number), 2])

## Update subject data with descriptive names
names(subject_data) <- c('Subject')

## Combine all data sets with descriptive names
data_set <- cbind(subject_data, Y_data, X_data)


## 5. From the data set in step 4, create a second, independent tidy data set
##    with the average of each variable for each activity and each subject.

## Obtain mean of data set by activity and subject
tidy_data_set <- aggregate(data_set, by = list(Subject = data_set$Subject,
                           Activity = data_set$Activity), mean)

## Drop unencessary columns
tidy_data_set[,3] <- NULL
tidy_data_set[,3] <- NULL

## Write out tidy data set
write.table(tidy_data_set, "tidy_data_set.txt", row.names = FALSE)