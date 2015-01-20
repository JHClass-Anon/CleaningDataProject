##
##Script does tasks below as described in detail in the README.md file
##
##Merges the training and the test sets to create one data set.
##Extracts only the measurements on the mean and standard deviation for each measurement. 
##Uses descriptive activity names to name the activities in the data set
##Appropriately labels the data set with descriptive variable names. 
##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##Part One - read in data files from directory and merge files

require(dplyr)

subjectTest <- read.table("subject_test.txt")
activityTest <- read.table("y_test.txt")
measuresTest <- read.table("X_test.txt")

measuresTest <- cbind(measuresTest, activityTest[1])
measuresTest <- subset(measuresTest, select=c(562,1:561))

measuresTest <- cbind(measuresTest, subjectTest[1])
measuresTest <- subset(measuresTest, select=c(563,1:562))

subjectTrain <- read.table("subject_train.txt")
activityTrain <- read.table("y_train.txt")
measuresTrain <- read.table("X_train.txt")

measuresTrain <- cbind(measuresTrain, activityTrain[1])
measuresTrain <- subset(measuresTrain, select=c(562,1:561))

measuresTrain <- cbind(measuresTrain, subjectTrain[1])
measuresTrain <- subset(measuresTrain, select=c(563,1:562))

##append the train and test databases
fullMeasures <- rbind_list(measuresTrain, measuresTest)

##Read activity table names
activityLabels <- read.table("activity_labels.txt", stringsAsFactors = FALSE)


##Part Two - Extract std and mean
##
##Read features file - 33 std and mean pairs

features <- read.table("features.txt")
t1 <- grep("mean\\(", features$V2)
t1 <- sort(c(t1, grep("std\\(", features$V2)))
t1 <- t1 + 2
t1 = c(1:2, t1)


##Part Three - Replace activity numbers with names
meanStdMeasures <- subset(fullMeasures, select=(t1))
meanStdMeasures <- rename(meanStdMeasures, subject_id = V1, activity = V1.2)
meanStdMeasures$activity_name <- sapply(meanStdMeasures$activity, switch, "WALKING","WALKING UPSTAIRS", "WALKING DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
meanStdMeasures <- subset(meanStdMeasures, select=c(1,2,69,3:68)) 


##Part 4 - label data set with var names
t1 <- sort(c(grep("mean\\(", features$V2), grep("std\\(", features$V2)))
t1 <- features[features$V1 %in% t1,]

t1 <- sub("\\(\\)","",sub("\\.\\.\\.","",sub("BodyBody","Body",t1$V2)))
t1 <- gsub("-","",sub("std","_Std", sub("mean","_Mean",t1)))

colnames(meanStdMeasures) <- c("subject", "activity", "activity_name", t1)


##Part 5 - create tidy data set 
by_sub_act <- meanStdMeasures %>% group_by(subject, activity)
final <- by_sub_act %>% summarise_each(funs(mean), -activity_name)
final$activity <- sapply(final$activity, switch, "WALKING","WALKING UPSTAIRS", "WALKING DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

write.table(final, file="finaltidy.txt", row.name = FALSE)

