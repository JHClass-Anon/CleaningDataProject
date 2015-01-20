

##README 

There are four items in the dataset package.  

1. README.md (which you are currently reading)  
2. CodeBook.md which contains data information  
3. tidy data set loaded through class web site  
4. R script file named run_analysis.R contained in GitHub (link loaded through web site)  

####The script performs the following tasks. 

#####Merges the training and the test sets to create one data set. 
It is assumed that all of the required files listed below are in the current working directory.  
-"subject_test.txt"  
-"y_test.txt"  
-"X_test.txt"  
-"subject_train.txt"  
-"y_train.txt"  
-"X_train.txt"  
-"features.txt"   
-"activity_labels.txt"  
The required files are found at "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

Each train/test file set has a file for subject ID ("subject_"), activity ID ("_test") and data (_train).  
Each entry in the train/test file set corresponds on a one to one basis to the corresponding data.  
To merge the files, the columns in the subject and activity files are added to the data set files.  
After they are added, the files are transformed by moving the new columns to the front of the data sets for easier reading.


#####Extracts only the measurements on the mean and standard deviation for each measurement.  
It was decided to only extract pairs of mean/std. As a result, angle information which had no corresponding std information was omitted (last 6 fields in "features.txt"). All other columns were dropped from the data set.
  
#####Uses descriptive activity names to name the activities in the data set  
Information from the "activity_labels.txt" was used to replace the activity codes provided therein.  

#####Appropriately labels the data set with descriptive variable names.  
Parentheses and hyphens were removed from the feature names. std and mean were replaced by Std and Mean, respectively and "BodyBody" was replaced by "Body  "  

#####From the data set above, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
A tidy set was created that summarises the requested information for each subject and their respective activities.  
The data set is tidy based on:
  - One column per variable
  - One observation for each variable per row
  
A text file produced with write.file where "row.name = FALSE" is uploaded to the web site.





