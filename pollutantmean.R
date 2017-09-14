read_data <- function(directory, id = 1:332) {
  data <- NULL
  file_names <- sprintf("%s/%03d.csv", directory, id)
  data <- do.call(rbind,lapply(file_names,read.csv))
  
  data[['ID']] <- factor(data[['ID']], levels = id)
  data
}

pollutantmean <- function(directory, pollutant, id = 1:332) {
  data <- read_data(directory, id)
  mean(data[[pollutant]], na.rm = TRUE)
}

complete <- function(directory, id = 1:332, data = NULL) {
  if (is.null(data)) {
    data <- na.omit(read_data(directory, id))
  }
  #results <- aggregate(data[['ID']], by=list(id), FUN=length, drop=FALSE)
  results <- do.call(rbind, lapply(id, function(x) data.frame(id=x, nobs=nrow(data[data$ID == x, ]))))
  #names(results) <- c("id", "nobs")
  results
}

corr <- function(directory, threshold = 0) {
  data <- na.omit(read_data(directory))
  data_summary <- complete(data = data)
  data_summary <- data_summary[data_summary$nobs > threshold, ]
  
  results <- NULL
  for (i in unique(data_summary$id)) {
    curr_data <- data[data$ID == i, ]
    results <- c(results, cor(curr_data$sulfate, curr_data$nitrate))
  }
  results
}

x <- pollutantmean("specdata", "sulfate", 1)
y <- complete("specdata", 1:10)
cr <- corr("specdata", 150)
head(cr)
