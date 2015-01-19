### Description of Analysis

I only used one script file to perform the analysis and it is in this directory as run_analysis.R.  The script has comments in it that explain what was done, but basically I performed the five steps required:

1. First I read in the data from the appropriate train and test folders for the predictors, X, the activity, Y, and the subject.  I had to combine the test and train using rbind and then combine the X, y, and subject using cbind.  
2.  Next I added descriptive names, see the code book below for details.  This was step four in the project, but it made sense for me to do this second so that I could subset the appropriate columns using the names.  I imported the names from the features.txt file and created these as the column names.  
3.  Next I used a regular expression to find columns names that contained mean and std.  I ended up getting the columns with "meanFreq" so I had to remove them with another regular expression.  
4.  Next I changed the numbers in the activities to descriptive names.  These names were found in the activity_labels.txt file.  So for example, 1 became WALKING.
5.  Finally, using dplyr, I grouped the data by subject and activity and then summarized by finding the mean of all 66 columns of data.  Since there were 30 subjects, all completing 6 activities, my final data had 180 rows.  This data is tidy because each column is separate variable and each row is a single observation, the subject and its activity.  I wrote both the complete data set and a smaller one to help the grader read.  

### Data Description

The following is taken from the readme file from the data

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.  

### Description of Variables (Code Book)

The first two variable names are  
Activity - The activity the subject was participating in  
Subject_ID - A numeric ID of the subject  
For the remaining 66 variables they are measurements from either the gyroscope or accelerometer built into the phone.  The variable name can be broken down as  
t/f - time domain or frequency domain measurement  
Body/Gravity - acceleration of body or gravity  
ACC/Gyro - From the accelerometer (linear) or gyroscope (angular)  
Jerk - If this is appended then measurement was on the rate of change of ACC or Gyro  
Mag - If Mag is appended then it is the Euclidean norm of the three directions  
mean()/std() - The mean or standard deviation of all the measurements  
X/Y/Z - If contained is the direction of the measurement, note that Mag will not have this  