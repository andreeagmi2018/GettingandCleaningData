### Coursera: Getting and Cleaning Data Course Project

### Download data
setwd("./Coursera")

url<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile = "./Coursera/x.zip")

folder_path <- file.path("./Coursera")
unzip(zipfile=file.path("./Coursera/x.zip"), exdir=folder_path)
library(dplyr)

setwd("C:/Users/Andreea/Documents/Coursera/UCI HAR Dataset")

### Q1: Merges the training and the test sets to create one data set.

feat <- read.table("./features.txt", col.names = c("n","functions"))
activLabel <- read.table("./activity_labels.txt", col.names = c("code", "activity"))
### Read training data
subTrain <- read.table("./train/subject_train.txt", col.names = "subject")
xTrain <- read.table("./train//X_train.txt", col.names = feat$functions)
yTrain <- read.table("./train/y_train.txt", col.names = "code")
### Read Test data
subTest <- read.table("./test/subject_test.txt", col.names = "subject")
xTest <- read.table("./test/X_test.txt", col.names = feat$functions)
yTest <- read.table("./test/y_test.txt", col.names = "code")
### Merge using rbind

Activity <- rbind(yTrain,yTest)
names(Activity)<- c("activity")

Subject <- rbind(subTrain, subTest)
names(Subject)<-c("subject")

# Get features, combine rows, set names
Features <- rbind(xTrain,xTest)
Feature_names <- feat[,2]
names(Features)<- as.character(Feature_names)

# Combine with all subject,activity and features
data_comb_sub <- cbind(Subject,Activity,Features)

### Q2: Extracts only the measurements on the mean and standard deviation for each measurement.
Feature_name_list <- Feature_names[grepl("(mean|std)\\(\\)",Feature_names)]
req_cols <-c(as.character(Feature_name_list), "subject", "activity" )
data_comb<- data_comb_sub[,req_cols]

### Q3: Uses descriptive activity names to name the activities in the data set
act_label <- activLabel[,2]
data_comb$activity<-factor(data_comb$activity,labels=act_label)

### Q4: Appropriately labels the data set with descriptive variable names. 
names(data_comb)<-gsub("^t", "time", names(data_comb))
names(data_comb)<-gsub("^f", "frequency", names(data_comb))
names(data_comb)<-gsub("BodyBody", "body", names(data_comb))

### Q5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data_final<-aggregate(. ~subject + activity, data_comb, mean)
data_final<-data_final[order(data_final$subject,data_final$activity),]
write.table(data_final, file = file.path("./Coursera/UCI HAR Dataset","tidydata.txt"),row.name=FALSE, sep = ',')
