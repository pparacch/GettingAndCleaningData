#Getting And Cleaning Data: Course Project
Repository connected with the __Course Project__ of __"Getting And Cleaning Data"__ course on Coursera, January 2015 edition.

##Course Project Information
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

You will be required to submit:

1. a tidy data set, 
2. a link to a __Github repository__ with 
	* your __script__ for performing the analysis, and
	* a __code book__ that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md
	* a __README.md__ in the repo with your scripts explaining how all of the scripts work and how they are connected.

###Description
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

A full description is available at the site where the data was obtained: 

[Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 

Here are the data for the project: 

[Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

You should create one R script called __run_analysis.R__ that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##What's available in the repository
* __README.md__
* __codebook.md__, information about each variable and its values in the tidy data set
* __run_analysis.R__, the script used to generate the tidy data (from the raw data)
* __HUCI\_HAR\_Dataset.zip__, the raw data (as reference)
* __tidy\_dataset__, the tidy data set as negerated by run_analysis.R  Pro(as reference)