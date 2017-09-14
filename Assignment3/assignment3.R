library("dplyr")
library("tidyverse")

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)

outcome[, 11] <- as.numeric(outcome[,11])
hist(outcome[, 11])

fieldname <- function(outcome) {
  strsplit(outcome, " ")[[1]] %>%
    sapply(function(x) paste(toupper(substring(x, 1, 1)), substring(x, 2), sep="")) %>%
    paste(collapse=".") %>%
    paste('Hospital.30.Day.Death..Mortality..Rates.from', ., sep=".")
}

best <- function(state, outcome) {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv")
  
  ## Check that state and outcome are valid
  if (!(state %in% data$State)) {
    stop("invalid state")  
  }
  else if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) {
    stop("invalid outcome")
  }
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  data[,fieldname(outcome)] <- as.numeric(as.character(data[, fieldname(outcome)]))
  
  hospital <- data %>% 
    filter(State == state) %>% 
    slice(which.min(.[[fieldname(outcome)]])) %>%
    .$Hospital.Name %>%
    as.character()
  
  hospital
}

rankhospital <- function(state, outcome, x = "best") {
  data <- read.csv("outcome-of-care-measures.csv")
  
  ## Check that state and outcome are valid
  if (!(state %in% data$State)) {
    stop("invalid state")  
  }
  else if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) {
    stop("invalid outcome")
  }
  
  data[,fieldname(outcome)] <- as.numeric(as.character(data[, fieldname(outcome)]))
  
  hospitals <- data %>% 
    filter(State == state) %>%
    .[order(as.numeric(.[[fieldname(outcome)]]), .$Hospital.Name), ] %>%
    .[, c("Hospital.Name", fieldname(outcome))] %>%
    na.omit()
  
  if (x == "worst") {
    x <- nrow(hospitals)
  }
  else if (x == "best") {
    x <- 1
  }

  #list(hospitals = hospitals, ans = as.character(hospitals[x, "Hospital.Name"]))
  as.character(hospitals[x, "Hospital.Name"])
}

rankall <- function(outcome, num = "best") {
  data <- read.csv("outcome-of-care-measures.csv")
  
  ## Check that state and outcome are valid
  if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) {
    stop("invalid outcome")
  }
  field <- fieldname(outcome)
  
  data[,field] <- as.numeric(as.character(data[, field]))
  
  df <- na.omit(data[order(as.character(data$State), data[,field], data$Hospital.Name), c("State", "Hospital.Name", field)])
  states <- sort(unique(as.character(df$State)))
  
  num_search <- function(x) {
    df_state <- df[df$State == x, ]
    search_row <- num
    
    if (search_row  == "best") {
      search_row <- 1
    }
    else if (search_row  == "worst") {
      search_row <- nrow(df_state)
    }
    
    result_row <- df_state[search_row, ]
    result_row$State <- x
    result_row
  }
  
  results <- do.call(rbind, lapply(states, num_search ))
  names(results) <- c("state", "hospital", "deaths")
  
  results[,c("hospital", "state")]
}

library(dplyr)    

x <- best("AL", "pneumonia")
x
