# Process the UCI HAR Dataset and calculate the average of mean and standard deviation values by subject and activity

# Precondition: the UCI HAR Dataset zip file should be unzipped into the working directory

if (!dir.exists("./UCI HAR Dataset")) stop("Please unzip the UCI HAR Dataset file into your working directory")

# Set the working directory to the subdirectory where our data has been unzipped

setwd("./UCI HAR Dataset")

# Load the training data

xtrain <- read.table("./train/x_train.txt")
ytrain <- read.table("./train/y_train.txt")
subjecttrain <- read.table("./train/subject_train.txt")

# Load the test data

xtest <- read.table("./test/x_test.txt")
ytest <- read.table("./test/y_test.txt")
subjecttest <- read.table("./test/subject_test.txt")

# Load the activity labels

activitylabels <- read.table("activity_labels.txt")

# Load the feature list

features <- read.table("features.txt")

# Merge the training and test data by concatenation of the rows

# IMPORTANT: all row merge ops must occur in the same order. We will append in the order: test, train

xmerged <- rbind(xtest, xtrain)

ymerged <- rbind(ytest, ytrain)

subjectmerged <- rbind(subjecttest, subjecttrain)

# Set the column name of subjectmerged to "subject"

colnames(subjectmerged) <- c('subject')

# Extract the features and use to set the column names of the x data

xcolheader <- as.vector(features$V2)
colnames(xmerged) <- xcolheader

# Merge the activity list with the x data

library("dplyr")
# activityMethods implements a lookup function getActivity
source("activityMethods.R")
tblymerged <- tbl_df(ymerged)
yactivities <- mutate(tblymerged, activity = getActivity(V1))
tblxmerged <- tbl_df(xmerged)

# Now merge our x and y data
xydata <- cbind(yactivities, tblxmerged)

# Now merge the subject list with the x and y data set by appending subject as the first column

complete <- cbind(subjectmerged, xydata)

# OK we now have our complete set, now let's extract the columns of interest for analysis

# Create a list of the columns we want to include in the tidy set. It will 
# contain subject, activity, and the mean and std columns. We can grep the colnames to find
# the latter two. This also groups our means and stds.

selected <- c(1,2,3,grep("mean", names(complete)), grep("std", names(complete)))


# subset the selected columns in a new tidy set

meanstd <- complete[,selected]

# calculate the average of each measurement for each subject and activity

avgbysubjectandactivity <- aggregate(meanstd[,4:82], list(meanstd$activity,meanstd$subject),mean)
# modify the column names of grouping criteria
colnames(avgbysubjectandactivity)[1:2] <- c("activity","subject")
# modify the labels of the averaged columns to accurately reflect that they are summarized
colnames(avgbysubjectandactivity)[3:81] <- paste('Avg_',colnames(avgbysubjectandactivity)[3:81],sep='')

# write the table to a file

write.table(agg, file="avgbysubjectactivity.txt",row.names=FALSE)

