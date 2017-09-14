# Coursera: Getting and Cleaning Data Course Project

## Description

This program cleans up the data from accelerometers fo Samsung Galaxy S smartphone

## How the scripts work

This script first reads all the input from the UCI HAR Dataset, through the use of `read.table`

It then combines the test and train data with the use of `rbind`. Any unwanted columns for the input variables are also removed here.

The activities are then appropriately labeled through the use of `left_join`, which joins the y data with the labels are obtained from *activity_labels.txt*

It then extracts out the *mean* and *std* through a combination of `dplyr::select` and its helper function `contains`

The `cbind` function is then used to combine the x and y dataframes

Finally the `dplyr` functions of `group_by` and `summarize_all` are used in conjunction to generate the summary output data, which is then written to *output.txt* through `write.table`