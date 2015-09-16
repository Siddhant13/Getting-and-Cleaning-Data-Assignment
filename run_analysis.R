## This is the complete code for the assignment. Here I have assumed that all the files
## are present in a single directory. The tidy data set is also written to that directory

## preprocessing tasks
library(reshape2)
features = read.table("features.txt") ##read the list of measurements\

## Here we decide which colums to use in the data set. I decide this first to reduce the
##computation needed in reading the data sets. The grep function looks for mean and std
## in the feature names
a = grep("mean|std", features$V2) ## gives vector with the row numbers
b = grepl("mean|std", features$V2) ## gives a logical vector for all the rows
## The vector d contains the list of colclasses for the data set to be read. The columns not
## required are set to NULL. This significantly reduces computation time
d=character(length=nrow(features))
for(i in 1:nrow(features)){
  if(b[i]==TRUE)
    d[i]="numeric"
  else
    d[i]="NULL"
}

##Step 1 and 2
##Merging the training and test data set
## Note that extraction of mean and std is done in the same step by using colclasses defined before
measure = rbind(read.table("X_train.txt",colClasses = d),read.table("X_test.txt",colClasses = d))
subject = rbind(read.table("subject_train.txt"),read.table("subject_test.txt"))
activ = rbind(read.table("y_train.txt"),read.table("y_test.txt"))

## Step 3
## Using descriptive activity names
lab = read.table("activity_labels.txt")
activ$Activity_Name = factor(activ$V1,labels=lab$V2)
## Create a new data frame with two more colums
measure = cbind(measure,subject$V1,activ$Activity_Name)

## Step 4
##Appropriately label the variables
x = as.character(features[a,2])
x=c(x,"Subject","Activity_Name")
colnames(measure) = x

## Step 5
## Create a tidy data frame
measuremelt = melt(measure, id.vars = c("Subject","Activity_Name"))
tidyset = dcast(measuremelt, Subject + Activity_Name ~ variable,mean)
write.table(tidyset,file = "tidy.txt",row.name=FALSE)
