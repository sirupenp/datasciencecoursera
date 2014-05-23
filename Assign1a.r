################################################
# STEP 1  Merge the TRAINING and TEST data sets
################################################
# First read in the TRAINING data, one axis at a time
X_Train <- read.table('UCI HAR Dataset/train/X_Train.txt')
Y_Train <- read.table('UCI HAR Dataset/train/Y_Train.txt')
Z_Train <- read.table('UCI HAR Dataset/train/subject_train.txt')

# Now to add a identity column to each of the axis
Identity <- c(1:nrow(X_Train))
X_Train$Identity <- Identity
Y_Train$Identity <- Identity
Z_Train$Identity <- Identity

# Now to merge the TRAINING data set
TrainDataTbl <- merge(X_Train, Y_Train, by = 'Identity')
TrainDataTbl <- merge(TrainDataTbl, Z_Train, by = 'Identity')

# Now to add the column header to the dataset
ColumnNames <- read.table('UCI HAR Dataset/features.txt')
ColumnNames <- ColumnNames[2]
ColumnNames <- as.vector(t(ColumnNames))
ColumnNames <- c("Identity", ColumnNames, "Activity", "Subject")
names(TrainDataTbl) <- ColumnNames   

# Now read in the TEST data, one axis at a time
X_Test <- read.table('UCI HAR Dataset/test/X_Test.txt')
Y_Test <- read.table('UCI HAR Dataset/test/Y_Test.txt')
Z_Test <- read.table('UCI HAR Dataset/test/subject_test.txt')

# Now to add a identity column to each of the axis
IdentityTest <- c(1:nrow(X_Test))
X_Test$Identity <- IdentityTest
Y_Test$Identity <- IdentityTest
Z_Test$Identity <- IdentityTest

# Now merge the TEST data set
TestDataTbl <- merge(X_Test, Y_Test, by = 'Identity')
TestDataTbl <- merge(TestDataTbl, Z_Test, by = 'Identity')

# Now merge the Training and Test dataset
names(TestDataTbl) <- ColumnNames

MergeDataTbl <- rbind(TrainDataTbl, TestDataTbl)

#################################################################################
# STEP 2
# Find all vars in the merged dataset with 'mean' and 'std' in the column header
# Any column header with 'Freq' in the name is excluded
#################################################################################
FinalColumns <- grep("mean\\(|std", names(MergeDataTbl), value = TRUE)
FinalDataTbl <- MergeDataTbl[FinalColumns]

##################################################################################
# STEP 3 & 4 Add descriptive activity names to the activities in the FinalDataTbl
# and appropriately label the data set
##################################################################################
AddedColumnNames <- names(FinalDataTbl)
FinalDataTbl$Activity <- MergeDataTbl$Activity
FinalDataTbl$Subject <- MergeDataTbl$Subject

ActivityLabels <- read.table('UCI HAR Dataset/activity_labels.txt')
names(ActivityLabels) <- c("Activity", "ActLab")
FinalDataTbl <- merge (FinalDataTbl, ActivityLabels, by.x = "Activity")

##############################################################
# Step 5 An independent tidy data set that has the average of 
# each variable for each activity and each subject
##############################################################

IndepDataTbl <- aggregate(FinalDataTbl[,2:67], FinalDataTbl[,68:69], FUN = mean)
names(IndepDataTbl)[2] <- 'Activity'

write.table(IndepDataTbl,'UCI HAR Dataset/FinalDataSet.txt', sep="\t",col.names = TRUE, row.names = FALSE)