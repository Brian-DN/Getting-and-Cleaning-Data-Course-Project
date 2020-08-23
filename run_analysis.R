# Importing and Reading data from directory
train<-read.table("./UCI HAR Dataset/train/X_train.txt")
test<-read.table("./UCI HAR Dataset/test/X_test.txt")
labeltest<-read.table("./UCI HAR Dataset/test/y_test.txt")
labeltrain<-read.table("./UCI HAR Dataset/train/y_train.txt")
subtrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
subtest<-read.table("./UCI HAR Dataset/test/subject_test.txt")
feature<-read.table("./UCI HAR Dataset/features.txt")
actlabel<-read.table("./UCI HAR Dataset/activity_labels.txt")

# Take order of the measurements on the mean and standard deviation in features
mean_std<-grep("mean()|std()",feature$V2)

# Add subjects and label each train and test into train and test set, then call new variables
f.train<-data.frame(subtrain,labeltrain,train)
f.test<-data.frame(subtest,labeltest,test)

# 1. Merges the training and the test sets to create one data set
get1<-merge(f.train,f.test,all=T)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement 
get2<-get1[,c(1,2,mean_std+2)]

# 3. Uses descriptive activity names to name the activities in the data set
get2$V1.1<-with(actlabel,V2[match(get2$V1.1,V1)])
get3<-get2

# 4. Appropriately labels the data set with descriptive variable names
colnames(get3)<-c("Subject","Activity",feature[mean_std,2])
get4<-get3

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject
sub<-unique(get4$Subject)
act<-unique(get4$Activity)
col<-ncol(get4)-2
x<-list()
for(k in 1:col){
       a<-0
       for(i in sub){
              for(j in act){
                     ifelse(a==0,a<-mean(get4[get4$Subject==i&get4$Activity==j,][,k+2]),
                            a<-c(a,mean(get4[get4$Subject==i&get4$Activity==j,][,k+2])))
              }
       }
       x[[k]]<-a
}
get5<-data.frame(rep(sub,each=6),rep(act,30),as.data.frame(x))
meanplus<-function(x){paste("mean.",x,sep="")}
colname<-sapply(feature[mean_std,2],meanplus)
colnames(get5)<-c("Subject","Activity",colname)

# Create a txt file contains a tidy data in step 5
write.table(get5,file="data5.txt",row.names = F)