library(readr)
library(lubridate)
reddit <-read_csv(url('https://raw.githubusercontent.com/kwartler/hult_NLP_student/main/cases/session%20II/WallStreetBets/CASE_gme.csv'))


# The temporal fields have already been extracted for you so here is an example

# Mentions by month
reddit$gmeMention <- grepl('gme', reddit$comment, ignore.case = T)
x <- aggregate(gmeMention~comm_date_yr+comm_date_month, reddit, sum)
x <- x[order(x$comm_date_yr, x$comm_date_month),]
plot(x$gmeMention, type = 'l')

# One Month
oneMonth <- subset(reddit,  reddit$comm_date_yr==2021 & 
                   reddit$comm_date_month==1)
oneMonth <- oneMonth[order(oneMonth$comm_date),]
y <- aggregate(gmeMention~+comm_date, oneMonth, sum)
plot(y$gmeMention, type = 'l')
plot(cumsum(y$gmeMention), type = 'l') #maybe more interesting as cumulative sum

# End