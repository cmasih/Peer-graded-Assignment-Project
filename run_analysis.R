### 1. Merges the training and the test sets to create one data set.
library(dplyr)
## combining test and train data 
# measurement
test <- read.table("UCI HAR Dataset/test/X_test.txt")
train <- read.table("UCI HAR Dataset/train/X_train.txt")
measurement<- rbind(test,train)

# activity
testact<- read.table("UCI HAR Dataset/test/y_test.txt")
trainact<- read.table("UCI HAR Dataset/train/y_train.txt")
activity<- rbind(testact,trainact)
activity<- rename(activity,activity=V1)

# subject
testsub<- read.table("UCI HAR Dataset/test/subject_test.txt")
trainsub<- read.table("UCI HAR Dataset/train/subject_train.txt")
subject<-rbind(testsub,trainsub)
subject<- rename(subject,subjectid=V1)

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

## the features file lists the 561 variables that were measured during the exp
## this corresponds to the columns in the measurement data
features<- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

## extract mean and standard deviation variable names.
features<- filter(features,grepl("mean\\(",V2) | grepl("std\\(",V2))
indices<-features[,1]
measurement<- measurement[,indices]

### 3. Uses descriptive activity names to name the activities in the data set

activity[,1]<- gsub("1","walking",activity[,1])
activity[,1]<- gsub("2","walkingupstairs",activity[,1])
activity[,1]<- gsub("3","walkingdownstairs",activity[,1])
activity[,1]<- gsub("4","sitting",activity[,1])
activity[,1]<- gsub("5","standing",activity[,1])
activity[,1]<- gsub("6","laying",activity[,1])



### 4. Appropriately labels the data set with descriptive variable names.

## as per the features info doc
## prefix t denotes time
## Acc is acceleration
## f is frequency
## Mag is magnitude
## Gyro is gyroscope 

features$V2<- gsub("std","standarddeviation",features$V2)
features$V2<- gsub("t[Bb]ody","time",features$V2)
features$V2<- gsub("f[Bb]ody","frequency",features$V2)
features$V2<- gsub("[Mm]ag", "magnitude",features$V2)
features$V2<- gsub("[Gg]yro","gyroscope",features$V2)
features$V2<- gsub("[Aa]cc","acceleration",features$V2)
features$V2<- gsub("Jerk","jerk",features$V2)

## removing - and ()
features$V2<- gsub("-","",features$V2)
features$V2<- gsub("\\()","",features$V2)
features<- rename(features,variable=V2)

names(measurement)<- features$variable


### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## combine activity, subject and measurement
tidydata<- cbind(activity,measurement)
tidydata<- cbind(subject,tidydata)

tidydata$subjectid<- as.factor(tidydata$subjectid)
tidydata$activity<- as.factor(tidydata$activity)

## gathering variables in tidy data to create a measurement column
measurement<- tidydata %>% 
  gather("variable","measurement",-subjectid,-activity)

## group tidy data by variable, activity and subject id and fill mean values of measurements in measurement column.
tidydata<-measurement %>% 
  group_by(variable,activity,subjectid) %>% 
  summarise(mean(measurement))
tidydata<- rename(tidydata,average= 'mean(measurement)')

## import tidy data file. 
write.table(tidydata,"tidydata.txt")

