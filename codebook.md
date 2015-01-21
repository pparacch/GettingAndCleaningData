#Information about the Raw Data
Information about the raw data can be found in the links below and the __README.txt__ file contained in the raw data.

[Human Activity Recognition Using Smartphones] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) [1]

[raw data (ZIP format)](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

###Relevant excerpts from the supporting documentation 

*"The experiments have been carried out with a group of __30 volunteers__ within an age bracket of 19-48 years. Each person performed __six activities__ (__WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING__) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The __obtained dataset has been randomly partitioned into two sets__, where __70% of the volunteers__ was selected for generating the __training data__ and __30% the test data__."*

...

*"For each record it is provided ...*


- *__A 561-feature vector__ with time and frequency domain variables.*

- *__Its activity label.__* 

- *__An identifier of the subject who carried out the experiment.__*"

...

*"The dataset includes the following files ...*

- *'features_info.txt': Shows __information__ about the __variables used on the feature vector__.*


- *'features.txt': __List of all features__.*



- *'activity_labels.txt': Links the __class labels__ with their __activity name__.*



- *'train/X_train.txt': __Training set__.*



- *'train/y_train.txt': __Training labels__.*



- *'test/X_test.txt': __Test set__.*



- *'test/y_test.txt': __Test labels__.*


...


*"The following files are available for the train and test data. Their descriptions are equivalent. ...*


- *'train/subject_train.txt': Each row __identifies the subject who performed the activity for each window sample__. Its range is from 1 to 30.*"


#Study Design
For the creation of the tidy dataset the following main design decisions have been taken.
## Merging the training and test data to create one dataset
The __README.txt__ file in the raw data provides some direction where to find the training and test relevant files.


Test relevant files:

- 'test/X_test.txt' contains the Test set
- 'test/y_test.txt' contains the Test labels
- 'test/subject_test.txt' contains info about the subjects

Training relevant files:

- 'train/X_train.txt' contains the Train set
- 'train/y_train.txt' contains the Train labels
- 'train/subject_train.txt" contains info about the subjects

The chosen approach has been to create the 2 test data (test and training) separately and then merging them to create one dataset.

### Creating test data from relevant files
#### Loading the files
Opening the files with a text editor we can see that 

- no header is provided, 
- all values are numeric
- separation character is "white space"

For reading the files a `read.table(file)` has been used.

Some exploration of the loaded datasets has been done in order to have an overview of the provided data and avoid surprises. An example of the exploration done on the dataset can be found below.

__test\_data ('test/X_test.txt') Summary__

Structure: as expected the set contains 561 variables/ features

	> str(test_data)
	'data.frame': 2947 obs. of  561 variables:
 	$ V1  : num  0.257 0.286 0.275 0.27 0.275 ...
	$ V2  : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
 	...
 	
Verify that all of the variables are "numeric"

	all(sapply(test_data, class) == "numeric")
	[1] TRUE 

Checking for Missing Values

	> all(colSums(is.na(test_data)) != 0)
	[1] FALSE

__test\_labels ('test/y_test.txt') Summary__

Structure (2947 observations/ rows)

 	> str(test_labels)
 	'data.frame':	2947 obs. of  1 variable:
 	$ V1: int  5 5 5 5 5 5 5 5 5 5 ...

Summary

From the summary we can see that there are not NAs and the values range between [1..6] 

	> summary(test_labels)
	       V1       
	 Min.   :1.000  
	 1st Qu.:2.000  
	 Median :4.000  
	 Mean   :3.578  
	 3rd Qu.:5.000  
	 Max.   :6.000
	 
__test\_subjects ('test/subject_test.txt') Summary__

Structure (2947 observations/ rows)

 	> str(test_subjects)
	'data.frame':	2947 obs. of  1 variable:
	 $ V1: int  2 2 2 2 2 2 2 2 2 2 ...

Summary

From the summary we can see that there are not NAs and the values range between [2..24] 

	> summary(test_subjects)
	       V1       
	 Min.   : 2.00  
	 1st Qu.: 9.00  
	 Median :12.00  
	 Mean   :12.99  
	 3rd Qu.:18.00  
	 Max.   :24.00

Please note how the loaded datasets have the same number of observations as expected.

### Merging the loaded datasets
From the summary we can verify that the loaded datasets `test_data`, `test_labels` and `test_subjects` have the same number of observations as expected.

The test_data_set has been done adding the test_subjects and test_labels to the test_data as columns 

	test_data_set <- cbind(test_subjects, test_labels, test_data)

### Adding the feature/ column names
The feature/ columns names are contained in the 'features.txt' file.

Opening the file with a text editor we can see that 

- no header is provided, 
- values in the first row are numerics, values in the second row are strings
- separation character is "white space"

For reading the file a `read.table(file, stringsAsFactors = FALSE)` has been used. `stringAsFactors`has been set to `FALSE` in order to be able to load the string values as `character`.

	path_to_features <- file.path("./data", "UCI HAR Dataset", "features.txt")
	features_list <- read.table(path_to_features, stringsAsFactors = FALSE)

`feature_list` contains 561 observations as the number of variables in `test_data`.

	> str(features_list)
	'data.frame':	561 obs. of  2 variables:
	 $ V1: int  1 2 3 4 5 6 7 8 9 10 ...
	 $ V2: chr  "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" "tBodyAcc-std()-X" ...
	 
Adding the name to the features/ columns in `test_data_set` - notes that names are "subject", "activity" and then the feature names.

	#extract the names of all of the features
	names_features <- features_list[,2]
	names <- c("subject", "activity", names_features)
	names(test_data_set) <- names

Remember that the `test_data_set` (563 columns) contains the `test_subjects` (1st column), `test_labels` (2nd column) and `test_set`(561-features).

### Creating training data from relevant files
Same process as the one followed for __creating test data from relevant files__ but using the training files for creating `training_data_set`.

### Merging test data & training data to create one data set
The two datasets `test_data_set` & `training_data_set` contains respectively the  observations for test subjects and training subjects (same number of variables).

The merging of the two datasets has been done using a `rbind` to create a `merged_data_set`

	#Merge the test dataset and training dataset (row wise)
	merged_data_set <- rbind(test_data_set, training_data_set)

## Naming of variables
For increasing clarity around the name of variables/ columns in the data set the following changes have been made
  
  * "t" prefix -> "time"
  * "f" prefix -> "frequency"
  * "Acc" -> "Accelerometer"
  * "Gyro" -> "Gyroscope"
  * "Mag" -> "Magnitude"
  * "BodyBody" -> "Body" (possible error)

based on information provided in the 'features_info.txt' file.

#Code book
The created tidy dataset satisfies the general principles of tidy data

* each variable is in one column
* each different observation of a variable is in a different row
* there is one table/ file for each "kind" of variable

##Data dictionary

Please note that '-XYZ' is used to denote 3-axial variables in the X, Y and Z directions.

	"activity" 
		activity identifier - "LAYING", "SITTING", "STANDING", "WALKING", "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS"
	
	"subject" 
		subject identifier - range form 1..30

	"timeBodyAccelerometer-mean()-XYZ" 
		average of the body accelleration mean (time domain)
		unit: "g"

	"timeBodyAccelerometer-std()-XYZ"
		average of the body accelleration standard deviation (time domain)
		unit: "g"
		
	"timeGravityAccelerometer-mean()-XYZ"
		average of the gravity accelleration mean (time domain)
		unit: "g"
		
	"timeGravityAccelerometer-std()-XYZ"
		average of the gravity accelleration standard deviation (time domain)
		unit: "g"
		
	"timeBodyAccelerometerJerk-mean()-XYZ" 
		average of the body accelleration Jerk mean (time domain)
		unit: "g"
		
	"timeBodyAccelerometerJerk-std()-XYZ" 
		average of the body accelleration Jerk standard deviation (time domain)
		unit: "g"
		
	"timeBodyGyroscope-mean()-XYZ"
		average of the body angular velocity mean (time domain)
		unit: "radians/ second"
		
	"timeBodyGyroscope-std()-XYZ"
		average of the body angular velocity standard deviation (time domain) 
		unit: "radians/ second"
		
	"timeBodyGyroscopeJerk-mean()-XYZ" 
		average of the body angular velocity Jerk mean (time domain)
		unit: "radians/ second"
		
	"timeBodyGyroscopeJerk-std()-XYZ"
		average of the body angular velocity Jerk standard deviation (time domain)
		unit: "radians/ second"
		
	"timeBodyAccelerometerMagnitude-mean()"
		average of the body acceleration magnitude mean (time domain)
		unit: "g"
		
	"timeBodyAccelerometerMagnitude-std()"
		average of the body acceleration magnitude standard deviation (time domain)
	 	unit: "g"
	 	
	"timeGravityAccelerometerMagnitude-mean()"
		average of the gravity acceleration magnitude mean (time domain)
		unit: "g"
		
	"timeGravityAccelerometerMagnitude-std()"
		average of the gravity acceleration magnitude standard deviation (time domain)
		unit: "g"
		
	"timeBodyAccelerometerJerkMagnitude-mean()"
		average of the body acceleration Jerk magnitude mean (time domain)
		unit: "g"
		
	"timeBodyAccelerometerJerkMagnitude-std()" 
		average of the body acceleration Jerk magnitude standard deviation (time domain)
		unit: "g"
		
	"timeBodyGyroscopeMagnitude-mean()"
		average of the body angular velocity magnitude mean (time domain)
		unit: "radians/ second"
		
	"timeBodyGyroscopeMagnitude-std()" 
		average of the body angular velocity magnitude standard deviation (time domain)
		unit: "radians/ second"
		
	"timeBodyGyroscopeJerkMagnitude-mean()"
		average of the body angular velocity Jerk magnitude mean (time domain)
		unit: "radians/ second"
		 
	"timeBodyGyroscopeJerkMagnitude-std()"
		average of the body angular velocity Jerk magnitude standard deviation (time domain) 
		unit: "radians/ second"
	
	"frequencyBodyAccelerometer-mean()-XYZ"
		average of the body accelleration mean (frequency domain)
		unit: "g"
	
	"frequencyBodyAccelerometer-std()-XYZ"
		average of the body accelleration mean for standard deviation (frequency domain)
		unit: "g"
		
	"frequencyBodyAccelerometerJerk-mean()-XYZ"
		average of the body accelleration Jerk mean (frequency domain)
		unit: "g"
		
	"frequencyBodyAccelerometerJerk-std()-XYZ"
		average of the body accelleration Jerk standard deviation (frequency domain)
		unit: "g"
	
	"frequencyBodyGyroscope-mean()-XYZ"
		average of the body angular velocity mean (frequency domain)
		unit: "radians/ second"
	
	"frequencyBodyGyroscope-std()-XYZ"
		average of the body angular velocity standard deviation (frequency domain)
		unit: "radians/ second"
		
	"frequencyBodyAccelerometerMagnitude-mean()"
		average of the body acceleration magnitude mean (frequency domain)
		unit: "g"
		
	"frequencyBodyAccelerometerMagnitude-std()"
		average of the body acceleration magnitude standard deviation (frequency domain)
		unit: "g"
	
	"frequencyBodyAccelerometerJerkMagnitude-mean()"
		average of the body acceleration Jerk magnitude mean (frequency domain)
		unit: "g"
		 
	"frequencyBodyAccelerometerJerkMagnitude-std()" 
		average of the body acceleration Jerk magnitude standard deviation (frequency domain)
		unit: "g"
		
	"frequencyBodyGyroscopeMagnitude-mean()"
		average of the body angular velocity magnitude mean (frequency domain)
		unit: "radians/ second"
		 
	"frequencyBodyGyroscopeMagnitude-std()" 
		average of the body angular velocity magnitude standard deviation (frequency domain)
		unit: "radians/ second"
			
	"frequencyBodyGyroscopeJerkMagnitude-mean()"
		average of the body angular velocity Jerk magnitude mean (frequency domain)
		unit: "radians/ second"
		
	"frequencyBodyGyroscopeJerkMagnitude-std()"
		average of the body angular velocity Jerk magnitude standard deviation (frequency domain)
		unit: "radians/ second"

__References__

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012