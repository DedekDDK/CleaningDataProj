# Step1-Merges the training and the test sets to create one data set.
# Step2-Extracts only the measurements on the mean and standard deviation for each measurement.
# Step3-Uses descriptive activity names to name the activities in the data set
# Step4-Appropriately labels the data set with descriptive variable names.
# Step5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)
#this is a script for running the analysis and tydying data set
path<-"UCI HAR Dataset"
if(!file.exists(path)) {
        cat("Directory with source data is missing (expecting dir '",path,"')",sep="")
        quit(status=-1)
}

#read the file with feature names, to use them as labels
labels<-read.table(paste(path,"/features.txt",sep=""),stringsAsFactors=FALSE)
activities<-read.table(paste(path,"/","activity_labels.txt",sep=""),stringsAsFactors=FALSE)

# Step1-Merges the training and the test sets to create one data set.
#read the training and test data set of X and combine
inpdata<-read.table(paste(path,"/","train/X_train.txt",sep=""))
testx<-read.table(paste(path,"/","test/X_test.txt",sep=""))
inpdata<-rbind(inpdata,testx)
rm(testx)

#read training and test data of Subjects and combine
subjects<-read.table(paste(path,"/","train/subject_train.txt",sep=""))
testsub<-read.table(paste(path,"/","test/subject_test.txt",sep=""))
subjects<-rbind(subjects,testsub)
rm(testsub)

#read trainig and test data of Y and combine
datay<-read.table(paste(path,"/","train/Y_train.txt",sep=""),col.names=c("Activity"))
testy<-read.table(paste(path,"/","test/Y_test.txt",sep=""),col.names=c("Activity"))
datay<-rbind(datay,testy)
rm(testy)

inpdata$Activity<-datay$Activity
inpdata$Subject<-subjects$V1
rm(datay)
rm(subjects)

#inpdata now contains all columns incl. the Y.ActivityName as Factor
#get column indexes having mean() and std() values
meanlab<-c(grep("mean()",labels[,2],fixed=TRUE),grep("std()",labels[,2],fixed=TRUE))
#get their text version
meanlabels<-labels[meanlab,2]
#tidy labels
meanlabels<-gsub("-","_",meanlabels,fixed=TRUE)    #replace - with underscores
meanlabels<-gsub("()","",meanlabels,fixed=TRUE)    #remove brackets

# Step2-Extracts only the measurements on the mean and standard deviation for each measurement.
data<-inpdata %>%
        select(Subject,meanlab) %>%
        # Step3-Uses descriptive activity names to name the activities in the data set
        mutate(ActivityName=factor(activities[inpdata$Activity,2]))

# Step4-Appropriately labels the data set with descriptive variable names.
colnames(data)<-c("Subject",meanlabels,"ActivityName")

# Step5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#so table should looks like:
# Subject Activity Variable1Mean Variable2Mean Variable3Mean ...
# 1       STANDING    1              2             3
# 1        WALKING    2              1             2
# 2       STANDING    2              2             2
#....
datasum<-summarise_each(group_by(data,Subject,ActivityName),funs(mean))

write.table(datasum,file="tidyset.txt", row.name=FALSE)
