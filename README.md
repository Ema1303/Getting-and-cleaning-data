This file lists down all the scripts used to obtain the results for the final project in Getting and Cleaning Data course (Coursera). 

The dataset used can be obtained from the following website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

# Files
- CodeBook.md provides a detailed description of the variables, the functions, and all transformations performed in this project.
- run_analysis.R is the R file that contains the full code used in this project, accompanied by comments that briefly explain the role of each step taken to obtain the final result.

# Connection between the scripts
You can download the dataset from the following site: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. To reproduce this analysis, you will have to download and unzip the source files and store them into a directory called "data" (which is a subdirectory of your working directory). This is where all your source files are stored and where the final tidy data will be stored.

To obtain the final result, download the script "run_analysis.R" from this repository. The file merges the training and the test datasets, extracts the mean and standard deviation measurements, renames activities and labels the column names with appropriate names. Finally, the script creates a tidy dataset with the average of each variable for each subject and activity performed by the subject. The final dataset is written into a new file called average_activity_subject.txt (and stored into a subdirectory "data"). 


