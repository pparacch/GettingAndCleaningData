setwd("/Users/thePierLo/courseraSpecialization//git_repos/GettingAndCleaningData_cp/")
library(dplyr)

#################################
###     Get the Raw Data      ###
#################################
#THINK ABOUT!! For Reproducibility - the raw data used to extract the tidy set is provided as "rawData.zip"

#How to Download the raw data file in a "data" folder
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#Download the zip file
download.file(fileUrl, destfile = "./rawData.zip", method = "curl")

#Unzip the data source in the "data" folder in the working directory
#Check if the "data" folder exists in the working directory
#If the folder does not exist - create it
if(file.exists("./data")){
        dir.create("./data")
}

#Unzip the file in the "data" folder
unzip("./rawData.zip", exdir = "./data")

################################################################
## 1. Merges the training and test sets to create one dataset ##
################################################################

## 1.1 Load the list of all features & extract the names
# List of all features is in "./data/UCI HAR DataSet/features.txt"
# when loading the data remember to set the stringsAsFactors to FALSE
# otherwise feature names will be loaded as a factor.
path_to_features <- file.path("./data", "UCI HAR Dataset", "features.txt")
features_list <- read.table(path_to_features, stringsAsFactors = FALSE)

#list of all features is a 'data.frame': 561 obs. of 2 variables
#V1: 1 2 3 4 ... & V2: <names of features> (no NAs in the provided values)
#extract the names of all of the features
names_features <- features_list[,2]

##1.2 Create the test data set from TEST raw data
##1.2.1 Load the test set
# Test observations are in "./data/UCI HAR DataSet/test/X_test.txt"
#(2947 obs. & 561 features/ variables), (No NAs in the collected values)
path_to_test_data <- file.path("./data", "UCI HAR Dataset", "test", "X_test.txt")
test_data <- read.table(path_to_test_data)

##1.2.2 Load the test labels
# Test labels are in "./data/UCI HAR DataSet/test/y_test.txt"
# It contains the type of activity associated for each obs. present in the test data
# (2947 obs. & 1 variable), (No NAs in the collected values)
# Summary shows us that the values are between 1 and 6
path_to_test_labels <- file.path("./data", "UCI HAR Dataset", "test", "y_test.txt")
test_labels <- read.table(path_to_test_labels)

##1.2.3 Load the test subjects
# Test subjects are in "./data/UCI HAR DataSet/test/subject_test.txt"
# It contains the subject who performed the activity for each obs. present in the test data
# (2947 obs. & 1 variable), (No NAs in the collected values)
path_to_test_subject <- file.path("./data", "UCI HAR Dataset", "test", "subject_test.txt")
test_subjects <- read.table(path_to_test_subject)

##1.2.4 Create the complete test data set
# The complete test data set is obtained adding the following info to the test data/ test obs.
# - subject connected with the observation (test_subjects)
# - activity performed during the observation (test_labels)
# (2947 obs. & 563 variables), (No NAs in the collected values)

test_data_set <- cbind(test_subjects, test_labels, test_data)
names <- c("subject", "activity", names_features)
names(test_data_set) <- names

##1.2.5 Remove unnecessary objs from memory associated with Test processing
rm("path_to_features", "path_to_test_data", "path_to_test_labels", "path_to_test_subject")
rm("features_list", "test_data", "test_labels", "test_subjects")

##TRAINING
path_to_train_data <- file.path("./data", "UCI HAR Dataset", "train", "X_train.txt")
training_data <- read.table(path_to_train_data)

path_to_train_labels <- file.path("./data", "UCI HAR Dataset", "train", "y_train.txt")
training_labels <- read.table(path_to_train_labels) #Activity Info [1..6]

path_to_train_subjects <- file.path("./data", "UCI HAR Dataset", "train", "subject_train.txt")
training_subjects <- read.table(path_to_train_subjects)

training_data_set <- cbind(training_subjects, training_labels, training_data)
names(training_data_set) <- names

merged_data_set <- rbind(test_data_set, training_data_set)

rm("path_to_train_data", "path_to_train_labels", "path_to_train_subjects")
rm("training_data", training_labels, "training_subjects")
rm("test_data_set", "training_data_set")
rm("names", "names_features")

################################################################
## 2. Extracts only measurements on mean & standar deviation  ##
################################################################
names_merged_data_set <- names(merged_data_set)
data_set <- merged_data_set[,c(1, 2, grep("*std\\(\\)|*mean\\(\\)", names_merged_data_set, ignore.case = TRUE))]

rm("names_merged_data_set")
rm("merged_data_set")

################################################################
## 3. Use descriptive activity names to name the activities   ##
################################################################
path_to_activity_labels <- file.path("./data", "UCI HAR Dataset", "activity_labels.txt")
activity_labels <- read.table(path_to_activity_labels, stringsAsFactors = FALSE)
data_set$activity <- activity_labels[match(data_set$activity, activity_labels$V1), "V2"]

rm("path_to_activity_labels", "activity_labels")

##########################################################################
## 4. Appropiately labels the data set with descriptive variable names   ##
##########################################################################
names(data_set) <- sub("^t", "time", names(data_set))
names(data_set) <- sub("^f", "frequency", names(data_set))
names(data_set) <- sub("Acc", "Accelerometer", names(data_set))
names(data_set) <- sub("Gyro", "Gyroscope", names(data_set))
names(data_set) <- sub("Mag", "Magnitude", names(data_set))

##########################################################################
## 5. create a second independent tidy data set with the average of     ##
##    each variable for each activity and each subject                  ##
##########################################################################
averages_by_activity_and_subject_data_set <- aggregate(. ~ activity + subject, data_set, mean)
write.table(averages_by_activity_and_subject_data_set, "tidy_data_set.txt", row.names = FALSE)
