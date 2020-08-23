The following variables contains data reading from download directory:
**train** read X_train.txt,
**test** read X_test.txt,
**labeltest** read y_test.txt,
**labeltrain** read y_train.txt,
**subtrain** read subject_train.txt,
**subtest** read subject_test.txt,
**feature** read features.txt,
**actlabel** read activity_labels.txt,

Take order of the measurements on the mean and standard deviation in features: mean_std

Add subjects and label each train and test into train and test set, then call new variables: f.train, f.test

1. Merges the training and the test sets to create one data set: get1

2. Extracts only the measurements on the mean and standard deviation for each measurement: get2

3. Uses descriptive activity names to name the activities in the data set: get3

4. Appropriately labels the data set with descriptive variable names: get4

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable
for each activity and each subject: sub, act, col, x, get5
