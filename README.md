---
title: "GetData CP1"
author: "Dave Bautis"
date: "09/19/2014"
output: html_document
---

#Course Project
##### Get Data
script was tested on linuxmint17 and R 3.0.2

### Aquire the data
Script will download a zip file from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Script will unzip the file to a tmp directory- tempdir()
You man need to modify this part if you are using a different OS
##### Features
extract the feature list (columns of test/train data) from
./UCI HAR Dataset/features.txt
This will be used to set the column names in the test/train data sets

##### Test data
Extract the test data from
./UCI HAR Dataset/test/X_test.txt
Extract the activity column from 
./UCI HAR Dataset/test/y_test.txt
extract the subjects column from the 
./UCI HAR Dataset/test/subjects.txt

Add these columns to the test dataframe

##### Train data
Extract the test data from
./UCI HAR Dataset/train/X_test.txt
Extract the activity column from 
./UCI HAR Dataset/train/y_test.txt
extract the subjects column from the 
./UCI HAR Dataset/train/subjects.txt

Add these columns to the train dataframe

### Merge the test_data and train_data
using rbind

### Map Activity column to descriptive names
Activity column is currently a numeric
there are descriptive names
these are extracted : ./UCI HAR Dataset/activity_labels.txt
I used a loop instead of hard coding in the event that there was an update to the descriptions in future version of the source data

### Extract the mean and std columns
I used grep for mean and std in the column names to extract the numerical indexes
I subsetted the merged data set with these column names and subject, activity




When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r}
summary(cars)
```

You can also embed plots, for example:

```{r, echo=FALSE}
plot(cars)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
