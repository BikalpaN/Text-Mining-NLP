#' Title: Rap Songs
#' Purpose: Rate of speech for hip/hop; Build a plot of the rate of change for lyrics
#' License: GPL>=3
#' Date: Dec 28 2020
#'

# Set wd
setwd("~/Desktop/hult_NLP_student/lessons/class3/data")

# Options
options(stringsAsFactors = F, scipen = 999)

# libs
library(stringr)
library(ggplot2)
library(ggthemes)
library(pbapply)

# Multiple files as a list
tmp <- list.files(path = paste0(getwd(),'/z_rap_songs'), pattern = '*.csv', full.names = T)
tmpNames <- list.files(path = paste0(getwd(),'/z_rap_songs'), pattern = '*.csv', full.names = F)
allSongs <- pblapply(tmp, read.csv)
names(allSongs) <- gsub('.csv','', tmpNames)

# Basic Exploration
allSongs$B.I.T.C.H...Explicit..by.Megan.Thee.Stallion
tail(allSongs$B.I.T.C.H...Explicit..by.Megan.Thee.Stallion, 1)

## Length of each song
lastLines <- list()
for(i in 1:length(allSongs)){
  x <- max(allSongs[[i]]$endTime)
  lastLines[[i]] <- x
}
songLength <- unlist(lastLines)

# Examine
max(allSongs[[1]]$endTime) #181762
songLength[1] 


# Make it a named vector
names(songLength) <- names(allSongs)
barplot(sort(songLength, decreasing = T), las = 2, main= 'song length in ms')

## Avg words in song
singleWords <- list()
for(i in 1:length(allSongs)){
  print(names(allSongs)[i])
  x <- sapply(strsplit(allSongs[[i]][,3], " "), length)
  singleWords[[i]] <- data.frame(song = names(allSongs)[i],
                                 totalWords  = sum(unlist(x)))
}
singleWords <- do.call(rbind, singleWords)
head(singleWords)

# Make it a named vector
singleWords <- singleWords[order(singleWords$totalWords, decreasing = T),]
barplot(singleWords$totalWords, names.arg = singleWords$song, 
        las = 2, main = 'song length in words')

# Relationship songLentgh*totalwords
plot(songLength, singleWords$totalWords)

# Calculate the cumulative sum
wordCountList <- list()
for(i in 1:length(allSongs)){
  print(names(allSongs)[i])
  x <- allSongs[[i]]
  #wordCount <- str_count(x$text, "\\S+") #count the space character
  wordCount <- sapply(strsplit(allSongs[[i]][,3], " "), length)
  y <- data.frame(x$endTime, 
                  cumulativeWords = cumsum(wordCount),
                  song = names(allSongs[i]),
                  lyric = x$text)
  names(y)[1] <- 'endTime'
  wordCountList[[i]] <- y
}

# Get the timeline of a song
songTimeline  <- do.call(rbind, wordCountList)
head(songTimeline)

# Make an example visual using the last `y` from the loop to show it
head(y)
plot(y$cumulativeWords, type = 'l')

# Get the last values for each song (total words but now with time)
totalWords <- lapply(wordCountList, tail,1)
totalWords <- do.call(rbind, totalWords)

# Lets review a song's complete stats
songTimeline[1:3,1:3]
totalWords[1,]


# Song cadence
p <- ggplot(songTimeline,  aes(x     = endTime,
                          y     = cumulativeWords, 
                          group = song, 
                          color = song)) +
  geom_line(alpha = 0.25) + 
  theme_tufte() + theme(legend.position = "none")
p

# Add another layer
p + geom_point(data =totalWords, aes(x     = endTime,
                                     y     = cumulativeWords, 
                                     group = song, 
                                     color = song), size = 2) +
  geom_text(data  = totalWords, aes(label=song),
            hjust = "inward", vjust = "inward", size = 3)

# Two clusters, let's see Em vs all
songTimeline$eminem <- grepl('eminem', 
                             songTimeline$song, 
                             ignore.case = T)
totalWords$eminem <- grepl('eminem', 
                           totalWords$song, 
                           ignore.case = T)


# Same vis now with color = eminem
ggplot(songTimeline,  aes(x     = endTime,
                          y     = cumulativeWords, 
                          group = song, 
                          color = eminem)) +
  geom_line(alpha = 0.25) +
  geom_point(data =totalWords, aes(x     = endTime,
                                   y     = cumulativeWords, 
                                   group = song, 
                                   color = eminem), size = 2) +
  geom_text(data  = totalWords, aes(label=song),
            hjust = "inward", vjust = "inward", size = 3) + 
  theme_few() + theme(legend.position = "none")

# End