## Download the files

fileName <- "UCI_HAR_Dataset.zip"

## check zip file exists in working directory

if (!file.exists(fileName)){
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,fileName,method="curl")
}

## check for folder before unzipping the file

if (!file.exists("UCI HAR Dataset")){
  unzip(fileName)
  }

## Read the file and assign to data frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("Index","featureName"))
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityID","acivityName"))
Xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names =features$featureName) 
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names ="Label")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names ="Subject") 
Xtest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names =features$featureName) 
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names ="Label")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names ="Subject") 

## Merges the training and the test sets to create one data set.
XData <- rbind(Xtrain,Xtest)
yData <- rbind(ytrain,ytest)
subjectData <- rbind(subjectTrain,subjectTest)

MergedData <- cbind(subjectData,yData,XData)

##Extracts only the measurements on the mean and standard deviation for each measurement. 
extract_cols <- grep("mean|std", names(MergedData),value=TRUE)
FilteredData <- cbind(MergedData$Subject,MergedData$Label,MergedData[,extract_cols])
names(FilteredData)[1] <- "Subject"
names(FilteredData)[2] <- "Label"


##Uses descriptive activity names to name the activities in the data set
FilteredData$Label <-activityLabels[FilteredData$Label,2]

##Appropriately labels the data set with descriptive variable names. 
names(FilteredData)[2] <- "Activity"
names(FilteredData) <- gsub("^t","Time",names(FilteredData))
names(FilteredData) <- gsub("^f","Frequency",names(FilteredData))
names(FilteredData) <- gsub("Acc","Accelerometer",names(FilteredData))
names(FilteredData) <- gsub("Gyro","Gyroscope",names(FilteredData))
names(FilteredData) <- gsub("BodyBody","Body",names(FilteredData))
names(FilteredData) <- gsub("Mag","Magnitude",names(FilteredData))

## Tidy Data set
TidyDataSet <- FilteredData


##From the data set in step 4, creates a second, independent tidy data set with 
##the average of each variable for each activity and each subject.

FinalTidyDataSet <- TidyDataSet %>%
             group_by(Subject, Activity) %>%
            summarise_all(mean)

write.table(FinalTidyDataSet, "./getting-and-cleaning-data-course-project/FinalTidyData.txt", row.name=FALSE)





