library(RCurl)
library(reshape2)

zipurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
tempdir <- tempdir()
tempfile <- paste(tempdir, "/data.zip", sep="")
#download.file(zipurl, tempfile, method="wget")
setwd(tempdir)
unzip(tempfile)
l=list.files(paste(tempdir,"/UCI HAR Dataset", sep=""))
features <- read.table("./UCI HAR Dataset/features.txt", sep=" ")
features <- features[2]

##-------------test-------------------------------
##test data setup
test_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test_act <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE, col.names=features[[1]], row.names=NULL)

#add the subject and activity and sourc columns
test_data$subject <- unlist(test_sub)
test_data$activity <- unlist(test_act)
test_data$sourc <- "test"
##-------------test--------------------------------


##-------------train----------------------
##training data setup (good idea to make this and above into fuction)
train_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train_act <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE, col.names=features[[1]], row.names=NULL)

#add the subject, activity, and sourc columns
train_data$subject <- unlist(train_sub)
train_data$activity <- unlist(train_act)
train_data$sourc <- "train"
##-------------train-----------------------


#mergeing the test and train data frames
both <- rbind(test_data, train_data)

# Map the activity column to the descriptive name
act_label <- read.table("./UCI HAR Dataset/activity_labels.txt")
both$act_desc <- as.character(both$activity)
for (i in unlist(act_label[1]) ) {
  replace <- as.character(i)
  both$act_desc[both$act_desc == replace] <- as.character(act_label[i,2])
}


# search the feature list for "mean" and "std" using grep
# drop the columns that do not match
columns <- colnames(both)
index<- c(grep("mean", columns, ignore.case=TRUE), grep("std", columns, ignore.case=TRUE))
drpped <- subset(both, select=c(columns[index], "subject", "act_desc"), drop=TRUE)

# convert subject and act_desc to factor
# aggregate on those 2 with the function as MEAN
#colna <- colnames(drpped)[0:106]
t2 <- aggregate(drpped[,1:86], by=list(subject=drpped$subject, activity=drpped$act_desc), FUN=mean    )


# produce the txt file output
write.table(t2, "output.txt", row.names=FALSE)

