#' Title: Polarity Over Time
#' Purpose: Learn and calculate polarity 


# Wd
setwd("~/GitHub/Lessons/class4/data")

# Libs
library(tm)
library(qdap)
#library(rtweet)
library(lubridate)

# Custom Functions
source('~/Desktop/Harvard_NLP_Student/lessons/Z_otherScripts/ZZZ_supportingFunctions.R')

# Data
# AVOID NAMESPACE CONFLICT: RAW() can only be applied to a 'raw', not a 'list'
#unicorns <- rtweet::search_tweets(q = "unicorn", n = 1000)
#saveRDS(unicorns, 'unicorns.rds')
unicorns <- readRDS('unicorns.rds')


# Data
head(unicorns$created_at)
class(unicorns$created_at)
min(unicorns$created_at)
max(unicorns$created_at)

# To make it more interesting let's make it a bunch of random dates
unicorns$fakeDate <- sample(seq(as.Date("2021/01/01"), 
                                as.Date("2021/02/02"), by = "day"), nrow(unicorns), replace = T)

# Extract Temporal Grouping Options
unicorns$min <-  minute(unicorns$created_at)
unicorns$hr  <-   hour(unicorns$created_at)
unicorns$day <- day(unicorns$fakeDate)#day(unicorns$created_at)
unicorns$weekDay <-  weekdays(unicorns$fakeDate)#weekdays(unicorns$created_at)
unicorns$week    <- week(unicorns$fakeDate)#week(unicorns$created_at)

# Examine to see what's been extracted
head(unicorns$min)
head(unicorns$hr)
head(unicorns$day)
head(unicorns$weekDay)
head(unicorns$week)

# Now get the polarity for each doc
polUni <- polarity(as.character(unicorns$text))
polUni

# Now Organize the temporal and polarity info
timePol <- data.frame(tweetPol = polUni$all$polarity,
                      min      = unicorns$min,
                      hr       = unicorns$hr,
                      day      = unicorns$day, 
                      weekDay  = unicorns$weekDay,
                      week     = unicorns$week)

# Examine
head(timePol)
mean(timePol$tweetPol, na.rm = T)
polUni

# NA to 0
timePol[is.na(timePol)] <- 0

# Week Avg
aggregate(tweetPol~week, timePol, mean)

# Hourly Avg
hrPol <- aggregate(tweetPol~day+hr, timePol, mean)
hrPol[order(hrPol$day, hrPol$hr),]

# Minute by Minute Avg
minPol <- aggregate(tweetPol~day+hr+min, timePol, mean)
minPol[order(minPol$day, minPol$hr, minPol$min),]

# Summary Stats by weekday, useful for repeating patterns (seasonality)
weekDayPol <- aggregate(tweetPol~weekDay, timePol, mean)
weekDayPol

# Tell R the ordinal nature of the factor levels
weekDayPol$weekDay <- factor(weekDayPol$weekDay, levels= c("Sunday", "Monday", 
                                         "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

weekDayPol[order(weekDayPol$weekDay), ]

# Week of Yr
weekPol <- aggregate(tweetPol~week, timePol, mean)
weekPol

# Quanteda package does time series analysis too but not covered in class.
# https://stackoverflow.com/questions/58918872/performing-time-series-analysis-of-quanteda-tokens
# End