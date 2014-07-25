#Code Book
The raw data can be obtained from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Complete information about the data may be obtained from
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Use of this data should be cited as

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


#Study Design
The study design was observational and is described in detail in the readme.txt file located in the main directory,
UCI HAR Dataset once the file is unzipped, as well as at the above url.

#Description of variables
More information about the variables can be found in the features_info.txt file located in the main directory,
UCI HAR Dataset once the file is unzipped, as well as at the above url.

tidydat.txt, the output of the R script, run_analysis.R, contains 81 variables. These include a subject id, the activity (e.g., walking), and 79 other variables that are derived from the raw data as described next. First, 79 variables were extracted from the raw data that were the mean and standard deviation of features described in the file features info.txt.
Each of these 79 variables were then averaged over all measurements for a given individual for each type of activity.  There were 30 individuals participating in the study and each engaged in 6 activities, therefore, the file tidydat.txt has 180 rows (30 x 6).
