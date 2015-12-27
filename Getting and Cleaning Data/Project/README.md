# Getting and Cleaning Data Project

This is the project repo for John Hopkins University Coursera Course.

The following steps were mentioned in the initial project

You should create one R script called run_analysis.R that does the following.
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Section 1. Merge the training and the test sets to create one data set.
Assuming that the source directory is that of data directory, the first step is to read into tables the data located in the various text files
1 features.txt
2 activity_labels.txt
3 subject_train.txt
4 x_train.txt
5 y_train.txt
6 subject_test.txt
7 x_test.txt
8 y_test.txt

After this we have to assign the column names and merge the various tables to form a single data set.

## Section 2. Extract only the measurements on the mean and standard deviation for each measurement. 
Next we create a logical vector which contains TRUE values for the ID, mean and Standard Deviation columns and FALSE values for others
We then use the logical vector to subset only those columns from the data which have mean and stddev in their names

## Section 3. Use descriptive activity names to name the activities in the data set
Now we merge the data subset with the activityLabels table to include the descriptive activity names

## Section 4. Appropriately label the data set with descriptive activity names.
The gsub function is used to substitute the column names with appropriate names to make it understandeble to non-domain users. 

## Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
As required in the project description, we get the final tidyData which contains the means for each variable of each activity and subject
