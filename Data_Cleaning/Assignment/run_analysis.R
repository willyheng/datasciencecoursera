library(dplyr)

# Read data set
file_test_x <- "UCI HAR Dataset/test/X_test.txt"
file_test_y <- "UCI HAR Dataset/test/y_test.txt"
file_train_x <- "UCI HAR Dataset/train/X_train.txt"
file_train_y <- "UCI HAR Dataset/train/y_train.txt"
file_subject_train <- "UCI HAR Dataset/train/subject_train.txt"
file_subject_test <- "UCI HAR Dataset/test/subject_test.txt"

file_features <- "UCI HAR Dataset/features.txt"

test_x <- read.table(file_test_x)
train_x <- read.table(file_train_x)

test_y <- read.table(file_test_y)
train_y <- read.table(file_train_y)

test_subject <- read.table(file_subject_test)
train_subject <- read.table(file_subject_train)


# 1.1. Merge data sets
data_subject <- rbind(train_subject, test_subject) %>%
  rename(subject = V1)
data_x_raw <- rbind(train_x, test_x) 
unwanted <- c((303:344), (382:423), (461:502))
data_x <- select(data_x_raw, -unwanted)

data_y <- rbind(train_y, test_y)

# 3. Activity labels
file_activity <- "UCI HAR Dataset/activity_labels.txt"
activities <- read.table(file_activity)

data_y_labeled <- left_join(data_y, activities, by = "V1") %>%
  select(activity = V2)

# 4. Label variable names
features <- read.table(file_features, header = FALSE, stringsAsFactors = FALSE)[['V2']]
names(data_x) <- features[-unwanted]

# 2. Extracts only the mean and standard deviations
data_x_filtered <- select(data_x, dplyr::contains("mean()", ignore.case = FALSE), dplyr::contains("std"))

# 1.2. Merge x and y
data <- cbind(data_y_labeled, data_subject) %>%
  cbind(data_x_filtered)

## 5. Show table
summary_data <- data %>% 
 group_by(activity, subject) %>%
  summarize_all(funs(mean))

# Output file
file_output <- "output.txt"
write.table(summary_data, file_output, row.names = FALSE)

