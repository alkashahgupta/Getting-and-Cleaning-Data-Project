##You will be required to submit:
#1) a tidy data set as described below,
#2) a link to a Github repository with your script for performing the analysis, and 
#3) a code book that describes the variables, the data, and any transformations or
#   work that you performed to clean up the data called CodeBook.md. 
#4)You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

## You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

#setwd("~/Dropbox/Coursera/Data Science Specialization/Data Cleaning")

#Download the dataset in your working directory and unzip it
fileurl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(fileurl,destfile="./dataset.zip",method="curl")
unzip("dataset.zip")

#read the activity labels and features dataset with their column names
activitylabels<-read.table("./UCI HAR Dataset/activity_labels.txt", col.names=c("activityId","activitylabels"))
features<- read.table("./UCI HAR Dataset/features.txt",col.names = c("featureId","featuresNames"))

#read the test data and assign column names
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names = "subjectId")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(xtest)<-features$featuresNames
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names="activityId")

#read the train data and assign it column names
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names = "subjectId")
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(xtrain)<-features$featuresNames
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names="activityId")

#Create single test and single train dataset with its subject and activity labels
testdata<- cbind(xtest,subjecttest,ytest)
traindata<- cbind(xtrain,subjecttrain,ytrain)

### Merges the training and the test sets to create one data set
dataset <- rbind(traindata,testdata)

###Extracts only the measurements on the mean and standard deviation for each measurement
index <- grepl("[mM]ean|[sS]td|activityId|subjectId",names(dataset))
newdataset<- dataset[,index]

###Uses descriptive **activity names** to name the activities in the data set
newdataset_with_activitynames<- merge(newdataset,activitylabels,by="activityId")

### Appropriately labels the data set with **descriptive variable names**
#Remove '-','(',')', and ',' from the column names (variable names).
#Replace mean with Mean, std with Std and bodybody with Body to make the features names tidy and descriptive
colnames<-names(newdataset_with_activitynames)
tidycolnames<-gsub("[-|(|)|,]","",colnames)
tidycolnames<-gsub("mean","Mean",tidycolnames)
tidycolnames<-gsub("std","Std",tidycolnames)
tidycolnames<-gsub("[bB]ody[bB]ody","Body",tidycolnames)
colnames(newdataset_with_activitynames)<-tidycolnames

### Creates a second, independent **tidy data set** with the **average** of **each variable** for **each activity and each subject**
newdataset_without_activityType <- newdataset_with_activitynames[,names(newdataset_with_activitynames)!="activitylabels"]
Initialtidydata <- aggregate(newdataset_without_activityType[,names(newdataset_without_activityType)!= c("activityId","subjectId")],by =list(subjectId = newdataset_without_activityType$subjectId,activityId=newdataset_without_activityType$activityId),mean)
tidydata<- merge(Initialtidydata,activitylabels,by = "activityId")
tidydata <- tidydata[,c(89,1:88)]

# Write the row and tidy dataset
write.table(dataset,"./UCI HAR Dataset/rawdata.csv",sep = ",",row.names=FALSE)
write.table(tidydata,"./UCI HAR Dataset/tidydata.csv",sep=",",row.names=FALSE)







