# Reading data
train<-read.table("UCI HAR Dataset/train/X_train.txt")
test<-read.table("UCI HAR Dataset/test/X_test.txt")
sub_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
sub_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
ctrain<-cbind(train,sub_train,y_train)
ctest<-cbind(test,sub_test,y_test)

# Reading features
vars<-read.table("UCI HAR Dataset/features.txt")

# Merging train and test and naming columns
global<-rbind(ctrain,ctest)
columns<-c(as.character(vars$V2),"Subject","Activity")
names(global)<-columns

# Selecting columns
sel<-grep("mean\\(\\)|std\\(\\)|Subject|Activity",names(global))
filtered<-global[sel]

# Setting activity names
act<-read.table("UCI HAR Dataset/activity_labels.txt")
for(i in 1:nrow(filtered)){
  filtered[i,"Activity"]=as.character(act[as.integer(filtered[i,"Activity"]),2])
}

# Changing feature names (more readable)
labels<-names(filtered)
labels<-gsub("\\(\\)","",labels)
labels<-gsub("^t","time-",labels)
labels<-gsub("^f","frequency-",labels)
labels<-gsub("BodyBody","Body",labels)
names(filtered)<-labels

# Creating a tidy data set with the average of each variable for each activity and each subject
final<- filtered %>% group_by(Subject,Activity) %>% summarise_each(funs(mean))
write.table(final, file="final.txt", row.name=FALSE)
