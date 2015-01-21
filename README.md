#Getting And Cleaning Data
Repository connected with the __Course Project__ of __"Getting And Cleaning Data"__ course on Coursera, January 2015.

##Course Project Information

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.

### The Goal

Prepare a tidy dataset that can be used for later analysis and required supporting materials for sharing data with a statistician.

### Expected Deliveries

1. the tidy data set, 
2. a link to a __Github repository__ containing the required supporting material 
	* the __script__ (__run_analisys.R__), the exact recipe used to go from the raw dataset to tidy dataset  , and
	* the __code book__ that describes the variables, the data, and any transformations or work that you performed to clean up the data (__CodeBook.md__)
	* __README.md__ file explaining how all of the scripts work and how they are connected.

###Description of Assignment
*One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.*

*A full description is available at the site where the data was obtained:*

[Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 

*Here are the data for the project:*

[Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

*You should create one R script called __run_analysis.R__ that does the following.*

1. *Merges the training and the test sets to create one data set.*
2. *Extracts only the measurements on the mean and standard deviation for each measurement.* 
3. *Uses descriptive activity names to name the activities in the data set*
4. *Appropriately labels the data set with descriptive variable names.* 
5. *From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.*

##What's available in the repository
* __README.md__ (this file)
* __codebook.md__, describing the variables, the data, and any transformations or work that you performed to clean up the data 
* __run_analysis.R__, the script used to generate the tidy data (from the raw data)
* __rawData.zip__, the raw data (as reference - downloaded on 20.01.2015)
* __tidy\_data\_set.txt__, the tidy data set as generated by run_analysis.R script (as reference)

##How to generate the tidy dataset
* Clone the repository `git clone https://github.com/pparacch/GettingAndCleaningData.git`
* Open a R console (R or RStudio)
* __Important!__ Remember to set the __working directory__ to the folder containing the cloned repository
* run `run_analisys.R` using `source("run_analisys.R")` in the R console to create the tidy_dataset (___tidy\_data\_set.txt__)
	* unzip the raw dataset (rawData.zip) in a "data" folder in the working directory. The folder is created if it does not exist.
	* load and process the required data
	* save the tidy dataset (__tidy\_data\_set.txt__) in the working directory

##The Recipe: run_analisys.R
__run_analisys.R__ script uses the local copy of the raw data (__rawData.zip__) for the generation of the tidy dataset (__tidy\_data\_set.txt__).

The script performs the following steps:

* unzip the raw data into a __"data"__ folder in the working directory
	* __rawData.zip__ must be in the working directory
	* If the __"data"__ folder does not exist in the working directory, it is created
* merges the training and test sets to create one dataset
* extracts only measurements on mean & standar deviation features/ variables from the dataset
* use descriptive activity names to name the activities in the relevant feature/ variable
* appropiately labels the data set with descriptive variable names
* from the dataset created in the previous step, generate an independent tidy dataset (__tidy\_data\_set.txt__) in the working directory

If you want to have more information  please read the comments available in __run_analisys.R__.

__Note!__ If you want to dowload a more recent version of the raw data please use the following code in a R console
	
	fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file(fileUrl, destfile = "./rawData.zip", method = "curl")


