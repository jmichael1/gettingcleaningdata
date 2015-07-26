# UCI HAR Dataset Analysis

##Summary

The provided scripts merge UCI HAR Dataset into a tidy data set and then calcuate an average of each measurement attribute grouped by Activity and Subject. The data set may be downloaded from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Scripts

activityMethods.R - Implements function getActivity which looks up an activity name given an activity code.

run_analysis.R - Processes the UCI HAR Dataset and performs the following operations:

1. Determines if target directory exists and exits if not
2. Sets the working directory to the subdirectory where the data has been unzipped
3. Loads the training data
4. Loads the test data
5. Load the activity labels
6. Load the feature list
7. Merges the training and test data via concatenation of rows
8. Sets the column name of subjectmerged to "subject"
9. Extracts the features and uses to set the column names of the x data
10. Merges the activity list with the x data
11. Merges x and y data
12. Merges the subject list with the x and y data set by appending subject as the first column

Next, extracts the columns of interest for analysis

13. Creates a list of the columns to include in the tidy set which will contain subject, activity, and the mean and std columns and groups means and standard deviation measurements.
14. Subsets the selected columns into a new tidy set
15. Calculates the average of each measurement for each subject and activity
16. Outputs result to a file

