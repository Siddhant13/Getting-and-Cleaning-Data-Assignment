# Getting-and-Cleaning-Data-Assignment
This repo contains the files for the assignment in G&amp;C Data

There are two other files. One of them is the R code to generate the tidy data. The other is the code book for the tidy data.
There are five steps in the R code as follows:

###1. Reading the data and merging the training and test set
In order to reduce the time taken in reading the data I have performed some preprocessing tasks. First the code finds the columns which contain the mean and statndard deviations and then the program only reads those columns. I have taken the measurements which contain the words "mean" or "std" to be the features required in the tidy data set.

###2. Extracting only the measurements on the mean and standard deviation for each measurement
This has already been done as part of the previos step

###3. Using descriptive activity names to name the activities in the data set
Thses names are taken from a file containing the names of the activities. A new column is created to store the names of the activities

###4. Appropriately label the data set with descriptive variable names
The variable names are taken from the features file and added to the data with the colnames function.

###5. From the data create a second, independent tidy data set with the average of each variable for each activity and each subject
The tidy data set is craeted in two steps. First the original data set is melted with the subject and activity as identity variables. In the second step use the code uses dcast on the melted data set to create a tidy data set. This data set contains Subject and Activity Name as identifiers and contains the means of all the variables.

##Reading the data set
The data set should be read with the following R command:
tidy = read.table("tidy.txt",header=TRUE)
