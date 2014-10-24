Getting and Cleaning Data Course Project
========================================

Welcome on my Getting and Cleaning Data Course Project!

In the main directory you find the script called run_analysis.R which when run in the directory containing Samsung data in the "UCI HAR Dataset" subdirectory, creates a file called tidyset.txt which contains the tidied dataset according the instructions in the Coursera Project of Getting and Cleaning of Data.

You can also find the Codebook, describing all the features and data variables.

##How the script works:
Target of the script is to extract the mean() and std() values of all measured variables, and provide the mean of all these variables per every subject and activity.

dplyr package is used for data manipulation

1. File with feature names and activity descriptions are read to be used later
2. Training and Testing data (X) are merged together
3. Then Training and Testing subjects are merged together
4. Then Y values (Activities) are merged together
5. Unused variables are removed from the workspace using rm() function to save space
6. Activity and Subjects are merged to the dataset, so Subjects, X and Y tables are in one table
7. Then select the labels, which contains the function mean() and std() to be our variables of interest. The variables containing word mean in the name are not taken, as the instructions were to include variables on which the function mean() and std() were applied. These column names are also tidied, so dashes are replaced with underscores and brackets removed, so we have valid R labels (and human readable and meaningful)
8. Based on the list of columns of interest, we select subset (66 columns) plus Subject and Activity. Activity number we convert to factors of ActivityNames.
9. From the vector of column names we create appropriate labels, incl. Subject and ActivityName.
10. Last step is to create summarized table, grouped by Subject and ActivityName, and calculating mean() for every feature of every group. summarize_each function provides exactly this functionality (excluding group_by columns)

In the last step the final tidy set is saved to the disk as "tidyset.txt"


Copyright:
Please note that the script and analysis is the property of myself, the dataset, and information are comming from 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
Web site link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

