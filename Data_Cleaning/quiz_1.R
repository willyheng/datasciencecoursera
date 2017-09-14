#Ans: 53, one var per col, 36534720, 127, not mean(DT$pwgtp15,by=DT$SEX)
 


# Read XLSX
install.packages("xlsx")
library("xlsx")

setwd("/R/datascience_course/Data_Cleaning")
colIndex <- 7:15
rowIndex <- 18:23

dat <- read.xlsx("natural_gas.xlsx", sheetIndex = 1, colIndex = colIndex, rowIndex = rowIndex)


# Read XML
install.packages("XML")
library(XML)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
fileUrl <- "restaurants.xml"
doc <- xmlTreeParse(fileUrl, useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
rootNode[[1]]
zipcodes <- xpathSApply(rootNode, "//zipcode", xmlValue)
sum(zipcodes == "21231")

# Download csv
library(data.table)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "community.csv", method = "curl")
DT <- fread("community.csv")

f1 <- function () {mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)}
f2 <- function() {rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]}
system.time(results <- f1())
system.time(results <- f2())
system.time(results <- DT[,mean(pwgtp15),by=SEX])
system.time(results <- tapply(DT$pwgtp15,DT$SEX,mean))
system.time(results <- sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(resutls <- mean(DT$pwgtp15,by=DT$SEX))
