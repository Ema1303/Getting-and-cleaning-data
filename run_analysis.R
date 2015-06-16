#####################
#THE TASK DESCRIPTION
#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#####################

# Libraries
library(dplyr) # used for data manipulation 

# the data has been downloaded, unzipped and stored in a directory called "data"

# READ train and test data and STORE each into a separate data frame
train_X <- read.table("data/train/X_train.txt")
train_Y <- read.table("data/train/y_train.txt")
subject_train <- read.table("data/train/subject_train.txt")

test_X <- read.table("data/test/X_test.txt")
test_Y <- read.table("data/test/Y_test.txt")
subject_test <- read.table("data/test/subject_test.txt")

# MERGING DATASETS
merged_X <- rbind(train_X, test_X)
merged_Y <- rbind(train_Y, test_Y)
merged_subject <- rbind(subject_train, subject_test)

# RENAME COLUMN NAMES
merged_subject <- rename(merged_subject, Subject_ID = V1)
merged_Y <- rename(merged_Y, Activity_label = V1)

features <- read.table("data/features.txt")
colnames(merged_X) <-  features[,2]

# MERGE ALL DATASETS
data <- cbind(cbind(merged_subject, merged_X), merged_Y)


# EXTRACT MEASUREMENTS ON THE MEAN AND STD DEVIATION 
mean_deviation <- grepl("(mean|std)\\(\\)|Activity_label|Subject_ID", colnames(data))
subset_data <- data[ , mean_deviation == TRUE]

# USE DESCRIPTIVE ACTIVITY NAMES
# replace the numerical activity label to its corresponding textual activity label
# the information about which numerical label maps to which textual label is given in activity_label.txt file
subset_data$Activity_label <- gsub("1", "WALKING", subset_data$Activity_label)
subset_data$Activity_label <- gsub("2", "WALKING_UPSTAIRS", subset_data$Activity_label)
subset_data$Activity_label <- gsub("3", "WALKING_DOWNSTAIRS", subset_data$Activity_label)
subset_data$Activity_label <- gsub("4", "SITTING", subset_data$Activity_label)
subset_data$Activity_label <- gsub("5", "STANDING", subset_data$Activity_label)
subset_data$Activity_label <- gsub("6", "LAYING", subset_data$Activity_label)

# SET DESCRIPTIVE VARIABLE NAMES
# rename the column names into more meaningful/descriptive names
names(subset_data) <- gsub("Acc", "Accelerometer", names(subset_data))
names(subset_data) <- gsub("Gyro", "Gyroscope", names(subset_data))
names(subset_data) <- gsub("Mag", "Magnitude", names(subset_data))
names(subset_data) <- gsub("^t", "time", names(subset_data))
names(subset_data) <- gsub("^f", "frequency", names(subset_data))

# CREATE A SECOND TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
# create a dataset in which for every subject average (mean) is calculated for all instances of a specific activity
# e.g. calculate the mean of all sitting activities for subject 1
average_activity_subject <- ddply(.data = subset_data, .variable = c("Subject_ID","Activity_label"), function(x) colMeans(x[, 2:67]))
write.table(average_activity_subject, "data/average_activity_subject.txt", row.name=FALSE)
