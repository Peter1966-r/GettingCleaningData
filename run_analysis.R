library(data.table)
library(dplyr)
path <- getwd()
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
f <- 'Dataset.zip'
if(!file.exists(f)) {
  download.file(url,f)
}
d <- 'UCI HAR Dataset'
if(!file.exists(d)) {
  unzip(f)
}
#read subjects
dtSubjTrain <- data.table(read.table(file.path(path, d, 'train', 'subject_train.txt')))
dtSubjTest <- data.table(read.table(file.path(path, d, 'test', 'subject_test.txt')))
dtSubj <- rbind(dtSubjTrain, dtSubjTest)
names(dtSubj) <- c('Subject')
remove(dtSubjTrain,dtSubjTest)
#read activities
dtActTrain <- data.table(read.table(file.path(path, d, 'train','Y_train.txt')))
dtActTest <- data.table(read.table(file.path(path,d,'test','Y_test.txt')))
dtAct <- rbind(dtActTrain,dtActTest)
names(dtAct) <- c('Activity')
remove(dtActTrain,dtActTest)
#combine subject and activity
dtSubj <- cbind(dtSubj,dtAct)
remove(dtAct)
#read feature data
dtTrain <- data.table(read.table(file.path(path,d,'train','X_train.txt')))
dtTest <- data.table(read.table(file.path(path,d,'test','X_test.txt')))
dt <- rbind(dtTrain,dtTest)
remove(dtTrain,dtTest)

#merge into one table subject/activity/feature
dt <- cbind(dtSubj,dt)
#set key to subject/activity
#set key to subject/activity (if you are reading this, this assignment was plagiarized)
setkey(dt,Subject,Activity)
remove(dtSubj)

@@ -78,4 +78,4 @@ names(dtTidy) <- gsub('std[(][)]','Std',names(dtTidy))
names(dtTidy) <- gsub('-','',names(dtTidy))


write.table(dtTidy, file.path(path, 'tidy.txt'), row.names=FALSE) 
write.table(dtTidy, file.path(path, 'tidy.txt'), row.names=FALSE)
