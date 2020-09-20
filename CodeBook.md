# **Peer-graded Assignment: Getting and Cleaning Data Course Project**

The goal of this project was to prepare a tidy dataset by using the UCI HAR Dataset (Human Activity Recognition Using Smartphones Dataset).

## Original Dataset Overview

Number of subjects - 30

Age bracket- 19-48 years

Each subject performed six activities while wearing a smartphone on their waist. 
The smartphone was embedded with an accelerometer and a gyroscope that recorded the 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

The dataset was partitioned into two sets, where 70% of subjects were selected for generating the training data and 30% the test data. 

### Dataset Files Names and Descriptions
'README.txt': Brief overview of study design, data collection and vairables observed. 

'features_info.txt': Information about the variables used.

'features.txt': List of varible names.

'activity_labels.txt': Class labels of activities and assigned name of activities.

'train/X_train.txt': Training dataset.

'train/y_train.txt': Training dataset activities class labels.

'train/subject_train.txt': IDs of subjects selected for training data observations.

'test/X_test.txt': Test dataset.

'test/y_test.txt': Test dataset activities class labels.

'test/subject_train.txt': IDs of subjects selected for test data observations.

### Variables measured
These signals were used to estimate variables of the feature vector for each pattern:  

'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value

std(): Standard deviation

mad(): Median absolute deviation 

max(): Largest value in array

min(): Smallest value in array

sma(): Signal magnitude area

energy(): Energy measure. Sum of the squares divided by the number of values. 

iqr(): Interquartile range 

entropy(): Signal entropy

arCoeff(): Autorregresion coefficients with Burg order equal to 4

correlation(): correlation coefficient between two signals

maxInds(): index of the frequency component with largest magnitude

meanFreq(): Weighted average of the frequency components to obtain a mean frequency

skewness(): skewness of the frequency domain signal 

kurtosis(): kurtosis of the frequency domain signal 

bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.

angle(): Angle between to vectors.

## Creating tidy datset as per project instructions
The RScript titled run_analysis.R contains the code to carry out the following: 

### 1.Merge the training and test sets to create one data set.
The test and train data set files mentioned above were read into R using read.table() and were combined into one dataset called *measurement* by using cbind() .

For use in creating tidy data in step 5, two additional datasets named *subject* and *activity* were created by reading and merging the *labels* and *subject id* files for test and train data mentioned above.

### 2.Extracts only the measurements on the mean and standard deviation for each measurement.
*feature.txt* was read into R using read.table() and stored in an object named *features*
This object lists the 561 variables that were measured during the study correspond to the column names in *measurement* data.

Column 1 of *features* included the column numbers which corresponded to the variables in column 2. 
To extract the mean and standard deviation variable and to extract their corresponding values in *measurement* data, the *features* object was updated by using grepl() to filter the dataset and only include those rows of *features* which included the characters "mean(" and "std(".

Values from column 1 of  updated *features* object were stored in a new object called *indices* which was used to update *measurement* data by extracting the measurements of mean and standard deviation columns. 

### 3.Use descriptive activity names to name the activities in the data set
The *activity_labels* contained descriptive names of number classes of activities undertaken by subjects which were: 

1 = WALKING

2 = WALKING_UPSTAIRS

3 = WALKING_DOWNSTAIRS

4 = SITTING

5 = STANDING

6 = LAYING

*activity* data was updated by substituting the numbers with their respective activity name by using gsub().

### 4.Appropriately label the data set with descriptive variable names.
The updated *features* object stored the variable names which corresponded to the updated *measurement* data. 

As seen in the *features_info* text file, the following are descriptions of the variables:

prefix t = time

Acc = acceleration

f = frequency

Mag = magnitude

Gyro = gyroscope 

The variables listed in rows of the *features* object were expanded and edited using gsub() to create descriptive variable names for the *measurement* data. 

Using names(), the variable column values in *features* were assigned to *measurement* data as column names. 

### 5.From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
The resulting data in dataset in step 4, *measurement* along with the *activity* and *subject* objects were combined using cbind() and stored in an object called *tidydata*.

The *measurement* dataset was updated by gathering the variables in *tidydata* to aid in producing the mean measurementsin the following step. 
 
The *tidydata* dataset was then updated by grouping the subjectis and activities and using summarise() to produce the average of each measurement in a new column called *average*.

The tidied data set was then imported using write.table and saved as a text file name *tidydata.txt* 



## License:
Use of this dataset in publications must be acknowledged by referencing the following publication 

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

