library(dplyr)
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileurl, "q3_community.csv", method = "curl")
data <- read.csv("q3_community.csv")
agriculturalLogical <- (data$ACR == 3) & (data$AGS == 6)
which(agriculturalLogical)

install.packages("jpeg")
library(jpeg)
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileurl, "q2.jpg", method = "curl")
file_data <- readJPEG("q2.jpg", native = TRUE)
quantile(file_data, probs = c(0.3, 0.8))

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileurl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileurl, "q3-gdp.csv", method = "curl")
download.file(fileurl2, "q3-edu.csv", method = "curl")
data_gdp <- read.csv("q3-gdp.csv")
data_edu <- read.csv("q3-edu.csv")
data_gdp <-  rename(data_gdp, CountryCode = Ctycode)
sum(data_edu$CountryCode %in% data_gdp$CountryCode)

data_gdp %>% 
  select(Ranking, Country) %>%
  arrange(desc(Ranking))

data<- full_join(data_gdp, data_edu, by="CountryCode")
high_income <- data %>% select(Ranking, Income.Group) %>%
  group_by(Income.Group) %>%
  summarize(mean(Ranking, na.rm = TRUE))

data <- data %>%
  mutate(RankQ = cut(Ranking, quantile(Ranking, c(0, 0.2, 0.4, 0.6, 0.8, 1), na.rm = TRUE)))

table(data$RankQ, data$Income.Group)
