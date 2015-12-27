rm(list=ls())

# 1. Merge the training and the test sets to create one data set.

# Read in the data from files
features     = read.table('./features.txt',header=FALSE); 
activityLabels = read.table('./activity_labels.txt',header=FALSE); 
subjectTrain = read.table('./train/subject_train.txt',header=FALSE);
subjectTest = read.table('./test/subject_test.txt',header=FALSE); 
xTrain       = read.table('./train/x_train.txt',header=FALSE); 
xTest       = read.table('./test/x_test.txt',header=FALSE); 
yTest       = read.table('./test/y_test.txt',header=FALSE); 
yTrain       = read.table('./train/y_train.txt',header=FALSE); 

colnames(activityLabels)  = c('activityId','activityLabel');
colnames(subjectTrain)  = "subjectId";
colnames(xTrain)        = features[,2]; 
colnames(yTrain)        = "activityId";

trainingData = cbind(yTrain,subjectTrain,xTrain);


colnames(subjectTest) = "subjectId";
colnames(xTest)       = features[,2]; 
colnames(yTest)       = "activityId";

testData = cbind(yTest,subjectTest,xTest);


finalData = rbind(trainingData,testData);

colNames  = colnames(finalData); 


logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));

finalData = finalData[logicalVector==TRUE];


finalData = merge(finalData,activityLabels,by='activityId',all.x=TRUE);

colNames  = colnames(finalData); 


for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StandardDeviation",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","Time",colNames[i])
  colNames[i] = gsub("^(f)","Frequency",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccelerationMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccelerationJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

colnames(finalData) = colNames;

finalDataNoActivityLabels  = finalData[,names(finalData) != 'activityLabels'];

tidyData    = aggregate(finalDataNoActivityLabels[,names(finalDataNoActivityLabels) != c('activityId','subjectId')],by=list(activityId=finalDataNoActivityLabels$activityId,subjectId = finalDataNoActivityLabels$subjectId),mean);

tidyData    = merge(tidyData,activityLabels,by='activityId',all.x=TRUE);

write.table(tidyData, './tidyData.txt',row.names=FALSE,sep='\t')