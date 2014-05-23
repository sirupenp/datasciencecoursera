datasciencecoursera
===================
Assumptions: For the code to work the working directory should have UCI HAR Dataset folder

Process:

In the first step of the program the two data sets, TEST data set and TRAIN data set, are merged.

For the TRAIN data set, each of the 3 axis are read into the appropriate variable. In order to merge
the data set each of the variables need a identity column to do the join. So the next step is to
assign the identity column to each of the axis.
Next the 3 axis of the TRAIN data are merged into a table called TrainDataTbl and column 
heading is given to each column.

For the TEST data set, each of the 3 axis are read into the appropriate variable. The above steps are
repeated for merging the data set, each axis is assigned an identity column to do the join. 
Next the 3 axis of the TEST data are merged into a table called TestDataTbl and column heading 
are given to each column.

Finally, the TrainDataTbl is appended with the TestDataTbl.

For step 2 only the columns with MEAN and DEV in the names are picked and assigned to the FinalDataTbl

For step 3 and 4 descriptive names are given to the activities, to do this the Activities are read into
a variable and assigned to the FinalDataTbl

For step 5 a tidy data set is created that follows the tidy data definition. And finally export the table 
to a text file.
