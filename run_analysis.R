
#reading features
          features <- read.table("UCI HAR Dataset/features.txt")

#reading activityLabels
          activityLabels = read.table("UCI HAR Dataset/activity_labels.txt")

# reading train tables
          x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
          y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
          subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# reading test tables
          x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
          y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
          subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# assigning colnames names
          colnames(x_train) <- features[,2]
          colnames(y_train) <-"activityId"
          colnames(subject_train) <- "subjectId"
          colnames(x_test) <- features[,2]
          colnames(y_test) <- "activityId"
          colnames(subject_test) <- "subjectId"
          colnames(activityLabels) <- c('activityId','activityType')

#merging all of the tables 
          train <- cbind(y_train, subject_train, x_train)
          test <- cbind(y_test, subject_test, x_test)
          train_test <- rbind(train, test) 
		  
#reading column names:
          clNm <- colnames(train_test)

# vector for defining ID, mean and standard deviation
          mean_std <- (grepl("activityId" , clNm) |grepl("subjectId" , clNm) |  grepl("mean.." , clNm) |grepl("std.." , clNm))

#making subset form train_test
          MeanNStd <- train_test[ , mean_std == TRUE]

#assigning activityLabels
          ActNms <- merge(MeanNStd, activityLabels, by='activityId',ll.x=TRUE)

#making tidy data set
          TdySet <- aggregate(. ~subjectId + activityId, MeanNStd, mean)
          TdySet <- TdySet[order(TdySet$subjectId, TdySet$activityId),]
#writing table
          write.table(TdySet, file = "TidyDSet.txt", row.name=FALSE)