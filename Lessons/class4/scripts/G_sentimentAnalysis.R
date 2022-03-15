#' Title: Sentiment Analysis
#' Purpose: Inner join sentiment lexicons to text


# Wd
setwd("~/GitHub/Lessons/class4/data")

# Libs
library(tm)
library(lexicon)
library(tidytext)
library(dplyr)
library(qdap)
library(echarts4r)
library(tidyr)
library(corpus)

# Bring in our supporting functions
source('~/Desktop/Harvard_NLP_Student/lessons/Z_otherScripts/ZZZ_supportingFunctions.R')

# Create custom stop words
stops <- c(stopwords('english'))

# Clean and Organize the old way instead of cleanMatrix
txt <- read.csv('news.csv')
table(txt$doc_id) #565 news articles mentioning President Trump


# Ignoring authorship/news politcal leanings, overall let's examine the emotional words used in these articles
txtDTM <- VCorpus(VectorSource(txt$text))
txtDTM <- cleanCorpus(txtDTM, stops)
txtDTM <- DocumentTermMatrix(txtDTM)

# Examine 
as.matrix(txtDTM[1:10,100:110])
dim(txtDTM)

# Examine Tidy & Compare
# If you use cleanMatrix() you need to switch it back to a DTM with this
#txtDTM      <- as.DocumentTermMatrix(txtDTM, weighting = weightTf ) 
tidyCorp <- tidy(txtDTM)
tidyCorp[100:110,]
dim(tidyCorp)

# Get bing lexicon
# "afinn", "bing", "nrc", "loughran"
bing <- get_sentiments(lexicon = c("bing"))
head(bing)

# Perform Inner Join
bingSent <- inner_join(tidyCorp, bing, by=c('term' = 'word'))
bingSent

# Quick Analysis
table(bingSent$sentiment) #tally ignoring count
table(bingSent$sentiment, bingSent$count) #only a few with more than 1 term
aggregate(count~sentiment,bingSent, sum) #correct way to sum them

# Compare original with qdap::Polarity
polarity(read.csv('news.csv')$text)
# avg. polarity  -0.014 vs about even pos/neg terms

# Get afinn lexicon
afinn<-get_sentiments(lexicon = c("afinn"))
head(afinn)

# Perform Inner Join
afinnSent <- inner_join(tidyCorp,afinn, by=c('term' = 'word'))
afinnSent

# Examine the quantity
afinnSent$afinnAmt     <- afinnSent$count * afinnSent$value

# Compare w/polarity and bing
mean(afinnSent$afinnAmt)

# FAKE EXAMPLE: if the documents were related and temporal, make sure they are sorted by time first!
# Example use case : i.e. over time how was the emotional content for a topic i.e. Pakistan articles
afinnTemporal          <- aggregate(afinnAmt~document, afinnSent, sum)
afinnTemporal$document <- as.numeric(afinnTemporal$document)
afinnTemporal          <- afinnTemporal[order(afinnTemporal$document),]

# Quick plot
plot(afinnTemporal$afinnAmt, type="l", main="Quick Timeline of Identified Words") 


# Quick Check with the pptx for a reminder.

# Get nrc lexicon; deprecated in tidytext, use library(lexicon)
#nrc <- read.csv('nrcSentimentLexicon.csv')
nrc <- nrc_emotions
head(nrc)

# Tidy this up
nrc <- nrc %>% pivot_longer(-term, names_to = "emotion", values_to = "freq")
nrc <-subset(nrc, nrc$freq>0 )
head(nrc)
nrc$freq <- NULL #no longer needed

# Perform Inner Join
nrcSent <- inner_join(tidyCorp,nrc, by=c('term' = 'term'))
nrcSent

# Radar chart
table(nrcSent$emotion)
emos <- data.frame(table(nrcSent$emotion))
names(emos) <- c('emotion', 'termsCt')
emos %>% 
  e_charts(emotion) %>% 
  e_radar(termsCt, max = max(emos$termsCt), name = "President Trump 565 Articles Emotions") %>%
  e_tooltip(trigger = "item") %>% e_theme("dark-mushroom")

# Other Emotion Lexicons Exist
emotionLex <- affect_wordnet
emotionLex
table(emotionLex$emotion)
table(emotionLex$category)

emotionLex <- subset(emotionLex, 
                     emotionLex$emotion=='Positive'|emotionLex$emotion=='Negative')

# More emotional categories, fewer terms
lexSent <- inner_join(tidyCorp,emotionLex, by=c('term' = 'term'))
lexSent
emotionID <- aggregate(count ~ category, lexSent, sum)
emotionID %>% 
  e_charts(category) %>% e_theme("dark-mushroom") %>%
  e_radar(count, max =max(emotionID$count), name = "President Trump 565 Articles Emotional Categories") %>%
  e_tooltip() %>%
  e_theme("dark-mushroom") 

# End