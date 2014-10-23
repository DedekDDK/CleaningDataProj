Getting and Cleaning Data Course Project
========================================

Welcome on my Getting and Cleaning Data Course Project!

In the main directory you find the script called run_analysis.R which when run in the directory containing Samsung data in the "UCI HAR Dataset" subdirectory, creates a file called tidyset.txt which contains the tidied dataset according the instructions in the Coursera Project of Getting and Cleaning of Data.

You can also find the Codebook, describing all the features and data variables.

##How the script works:
Target of the script is to extract the mean() and std() values of all measured variables, and provide the mean of all these variables per every subject and activity.
1. First Training and Testing data are merged together
2. Then Y values (Activities) are merged together
3. File with feature names and activity descriptions are read to be used later
4. 
