#read in data from folders in working directory
#First Test
X_test <- read.table("./test/X_test.txt", quote="\"")
y_test <- read.table("./test/y_test.txt", quote="\"")
subject_test <- read.table("./test/subject_test.txt", quote="\"")
#Now Train
X_train <- read.table("./train/X_train.txt", quote="\"")
y_train <- read.table("./train/y_train.txt", quote="\"")
subject_train <- read.table("./train/subject_train.txt", quote="\"")
#Explore the data
dim(X_test)
dim(X_train)
table(subject_test)
table(subject_train)
#Lets combine the data into one data.frame.
X_combine<-rbind(X_train,X_test)
dim(X_combine)
y_combine<-rbind(y_train,y_test)
subject_combine<-rbind(subject_train,subject_test)
#Now combine into one data set
final_combine<-cbind(subject_combine,y_combine,X_combine)
str(final_combine)
#Now I want to add variable names as the Vxx name is not descriptive
names(final_combine)[c(1,2)]<-c("Subject_ID","Activity")
#Read in feature names from data folder
features <- read.table("./features.txt", quote="\"")
names(final_combine)[3:563]<-as.character(features[,2])
#Now that the variables have the name from the features text I can find those variables with mean and standard deviation
#I will a regular expression and cbind on the first two rows, subject and activity
final_meanstd<-cbind(final_combine[,c(1,2)],final_combine[,grepl("mean()",names(final_combine))|grepl("std()",names(final_combine))])
str(final_meanstd)
dim(final_meanstd)
#This grep obtained the meanFreq variables which we do not want, so I will remove them
final_meanstd<-final_meanstd[,!grepl("meanFreq()",names(final_meanstd))]
str(final_meanstd)
dim(final_meanstd)
#Now I will change the names of the activities from a number to a name
#First import the activity labels
activity_labels <- read.table("./activity_labels.txt", quote="\"")
str(activity_labels)
final_meanstd[,2]<-as.factor(final_meanstd[,2])
for(i in 1:6){
    levels(final_meanstd$Activity)[i]<-as.character(activity_labels$V2)[i]
}
levels(final_meanstd$Activity)
#To create the summary of the mean of each variable by subject and activity I need to
#use dplyr and create a table
library(dplyr)
final_tbl<-tbl_df(final_meanstd)
#Next group by Subject_ID then Activity and finally summarize using summarize
final_tdy<-final_tbl %>% 
    group_by(Student_ID,Activity) %>%
    summarise_each(funs(mean))
#Write out to text file
write.table(final_tdy,"tidy.txt",row.names=FALSE)
#With 68 columns this will be hard to see, so I will help the grader by making a subset that
#is easy to view
write.table(final_tdy[,1:5],"tidy_small.txt",row.names=FALSE)