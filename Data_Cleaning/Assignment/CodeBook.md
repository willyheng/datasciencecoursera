# Code Book

This code book describes the variables, data and transformations used to clean up

## Variables

file_XXX: filenames of various inputs and outputs
unwanted: unwanted columns from the variables (x) input files
features: names of variables (x)
activities: names of activity labels (y)

## Data

test_x, test_y, test_subject: test data from input files
train_x, train_y, train_subject: train data from input files

data_x_raw: combined test_x and train_x data
data_x: x data after removing unwanted columns
data_x_filtered: mean and std within x data

data_y: combined test_y and train_y data
data_y_labeled: after converting numeric labels to text (factor) labels

data_subject: combined test_subject and train_subject

data: combined data_x and data_y
data_summary: final summarized output

## Transformation

1. Read data from input files
2. Combine train and test for x and y separately (rbind)
3. Remove unwanted columns from x 
4. Name x appropriately
5. Change y from numeric to text labels
6. Combine x and y together (cbind)
7. Find the crosstab for x and y based on mean (summarize_all)