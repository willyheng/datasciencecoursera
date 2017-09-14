fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileurl, "data.csv", method = "curl")
acs <- read.csv("data.csv")

install.packages("sqldf")
library(sqldf)
sqldf("select * from acs where AGEP < 50 and pwgtp1")
sqldf("select pwgtp1 from acs where AGEP < 50")


con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlcode = readLines(con)


library(readr)

x <- read.fwf("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", 9, header = TRUE, skip = 4)
fwfurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
?readr_example
x <- read_fwf(fwfurl, fwf_positions(c(13, 4)), skip = 4)
x <- separate(x, col = X2, into=c("X2.1", "X2.2"), sep="[- ]") %>%
  separate(col = X3, into=c("X3.1", "X3.2"), sep = "[- ]") %>%
  separate(col = X5, into=c("X5.1", "X5.2"), sep = "[- ]") %>%
  separate(col = X6, into=c("X6.1", "X6.2"), sep = "[- ]") %>%
  select(-X4)




