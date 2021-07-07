# GettingandCleaningData
Repository

1. README.md : an overview of repository contents and explanation of the script
2. Codebook.md: describes the variables, the data, and transformations to create tidy datset
3. run_analysis.R : the R script used to transform raw data into a tidy dataset
4. tidydata.txt: Final tidy dataset generated from run_analysis.R script

Explanation of the script:

- data was downloaded using download.file() and uzipped using unzip()
- data was read using read.table() and merged, as requested in the assignment, using rbind()
- combine with all subject,activity and features data_comb_sub <- cbind(Subject,Activity,Features)
- next, mean and standard eviation extracted for each measurement
- descriptive variable names given to the dataset using names(data_comb)<-gsub()
- tidydata.txt creaded with the average of each variable for each activity and each subject
