The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

Data Sources
=============
 File Location -> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Data Set Information
=====================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.




Step1: Download the dataset
===========================
Dataset downloaded and extracted under the folder called UCI HAR Dataset


Step2: Assign each files to data frames
=======================================

features       -> UCI HAR Dataset/features.txt
activityLabels -> UCI HAR Dataset/activity_labels.txt
Xtrain         -> UCI HAR Dataset/train/X_train.txt 
ytrain         -> UCI HAR Dataset/train/y_train.txt
subjectTrain   -> UCI HAR Dataset/train/subject_train.txt
Xtest          -> UCI HAR Dataset/test/X_test.txt
ytest          -> UCI HAR Dataset/test/y_test.txt
subjectTest    -> UCI HAR Dataset/test/subject_test.txt

Step3: Merges the training and the test sets to create one data set
====================================================================

XData ('data.frame':10299 obs, 561 variables) is created by merging X_train and X_test using rbind() function
yData ('data.frame':10299 obs, 1 variable) is created by merging y_train and y_test using rbind() function
subjectData ('data.frame':10299 obs, 1 variable) is created by merging subject_train and subject_test using rbind() function
MergedData ('data.frame':10299 obs, 563 variables) is created by merging Subject, yData and XData using cbind() function

step4: Extracts only the measurements on the mean and standard deviation for each measurement
=============================================================================================
create a filtered data (FilteredData set by using grepl function to get only mean and std colmns and the cbind with subject and label to create the 
full filtered set ('data.frame':10299 obs, 88 variables)

Step5: Uses descriptive activity names to name the activities in the data set
==============================================================================

Entire numbers in code column of the Fileterd Data replaced with corresponding activity taken from second column of the activities variable

Step6: Appropriately labels the data set with descriptive variable names
=========================================================================
Label column renamed to Activity
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time

RENAMED FilterdData to TidyDataSet

Step 7: From the data set in step 6(step4 in assignment), creates a second, independent tidy data set with the average of each variable for each activity and each subject
========================================================================================================================================================

FinalTidyDataSet (180 rows, 81 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export FinalTidyDataSet into FinalTidyData.txt file.
