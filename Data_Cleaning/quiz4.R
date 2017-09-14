fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileurl, "quiz4-q1.csv", method = "curl")
data <- read.csv("quiz4-q1.csv")
strsplit(names(data), "wgtp")[123]


fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileurl, "quiz4-q2.csv", method = "curl")
data <- read.csv("quiz4-q2.csv", skip = 5, header = FALSE, nrows = 190) %>%
  select(V1,V2, V4: V5) %>%
  rename(countrycode = V1, ranking = V2, country = V4, gdp = V5) %>%
  mutate(gdp = as.numeric(gsub("[, ]", "", gdp))) 

m <- summarize(data, mean(gdp, na.rm = TRUE))

grep("^United",data$country)


data_edu <- read.csv("q3-edu.csv")
length(grep("[^0-9]06$", data_edu$Source))
length(grep("[Jj]une", data_edu$Special.Notes))

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

library(lubridate)
sum(year(sampleTimes) == 2012)
sum(wday(sampleTimes) == 2 & year(sampleTimes) == 2012)
