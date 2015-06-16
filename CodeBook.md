#Synopsis

This project deals with the data collected from the accelerometers from the Samsung Galaxy S smartphone. The data is recorded from 30 subjects performing activities of daily living while carrying a waist-mounted smartphone with embedded inertial sensors.

The data can be obtained at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

For each record in the dataset it is provided: 
  - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
  - Triaxial Angular velocity from the gyroscope. 
  - A 561-feature vector with time and frequency domain variables. 
  - Its activity label. 
  - An identifier of the subject who carried out the experiment.
  
The subjects have performed the following activities:
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

In this project, data is fetched, cleaned up and transformed so that the resulting dataset contains averages for each variable per subject and activity performed. 

# Summary of variables used
The following variables are used:
- train_X, train_Y, subject_train: train data
- test_X, test_Y, subject_test: test data
- merged_X, merged_Y, merged_subject
- features: stores variable names of the features
- data: all datasets merged
- subset_data: subsets measurements on the mean and standard deviation
- average_activity_subject: the final tidy data

# Summary of functions used
The following functions were used:
- read.table(): reads a file in table format and creates a data frame
- rbind() and cbind(): Combine R objects column- or row-wise
- rename(): used to rename the columns
- colnames(): used to obtain the names of the columns 
- gsub(): used to replace two strings by using regular expressions
- names(): used to get and set the names
- ddply(): used to apply function for each subset of a dataframe then combine results into a dataframe
- colMeans(): used to find the mean values column-wise
- write.table(): used to print the result ina file


# Data transformations: a detailed report

The data has been downloaded from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones, unzipped and stored in a directory called "data".

Libraries needed for the analysis:
 - library(dplyr) is used for data manipulation 

Train and test data are read and stored each into a separate data frame. "train_X" holds train data and "test_X" holds test data. "subject_train" and "subject_test" hold IDs of test and train subjects (people participating in a data collection process). "train_Y" and "test_Y" hold IDs of activities performed by subjects.

The separate datasets are joined vertically, row-wise by using rbind(). "merged_X", "merged_Y", and "merged_subject" hold merged datasets for test_X and test_Y, test_Y and train_Y, subject_train and subject_test datasets, respectively.

Since the column names are uninformative at this stage, rename() function has been used to rename the columns "V1" (originally taken from merged_subject dataset) into "Subject_ID", and "V1" (originally taken from merged_Y dataset) into "Activity_label". If the column names "V1" were to be left unchanged, they would have led to confusion during data transformation. Moreover, at this stage it is also convenient to rename the rest of the columns that were originally obtained from merged_X dataset. To do this, the labels are read from the features.txt file and stored into "features". Since the number of columns corresponds to the number of new & more informative labels, the new labels are assigned to the column names in the merged_X dataset by using: colnames(merged_X) <-  features[,2] (note: features[,2] is applied here because we are only interested in a second column of the "features" dataset which holds the names to be mapped to columns in a merged_X dataset). 

Now it is possible to combine all datasets column-wise. To do this cbind() is used over merged_subject, merged_X and merged_Y datasets that already hold more informative column names.

To extract measurements on the mean and standard deviation, it is sensible to use regular expressions, i.e. the grepl() function which returns a logical vector with the value TRUE if an expression has been found and FALSE otherwise. The following regular expression is used in this project: "(mean|std)\\(\\)|Activity_label|Subject_ID". We are interested in the data that corresponds to the columns that hold data about mean (mean()) and standard deviation (std()). Moreover, the new dataset should also contain information about the subjects (hence, Subject_ID) and activities performed (Activity_label). The data extracted is stored into a dataset called "subset_data". 

To tidy up the values in the rows in the new data subset, the numerical activity labels are replaced by corresponding textual activity labels, based on the information in activity_label.txt file. Function gsub() is used to replace all matches of a string. For example, gsub("1", "WALKING", ...) is used to replace every occurrence of label 1 with the appropriate textual and descriptive label "WALKING". The result applies to the activity label in the data subset (subset_data$Activity_label). The same procedure is repeated for all activities.

It is also important to set descriptive variable names. The same procedure as above is used to individually replace the abbreviated column names with a full name of the sensor/variable. For example, "Acc" is replaced by "Accelerometer", "Gyro" is replaced by "Gyroscope" and "t" is replaced by "time".

Finally, the second tidy dataset called "average_activity_subject" is created that provides the average of each variable for each subject and each activity. So far, for each subject multiple instances of activities were provided in individual rows. The new dataset calculates the mean of, for example, all sitting activities for subject 1. This is done by using ddply() function that applies mean() column-wise.

The resulting dataset is written into a new file called average_activity_subject.txt and stored into a directory "data", where the data downloaded for this analysis are stored.
