#' TK
#' Feb 25
#' Case Attempt 1
#' 

# Set wd
setwd("~/Desktop/hult_NLP_student/cases/session II/student ambassadors")

# libs
library(tm)
library(wordcloud)

# load data
txt <- read.csv("final_student_data.csv")
txt$allText <- paste(txt$interests, txt$interests)

# Stopwords
stops <- stopwords('SMART')

# Custom Functions
tryTolower <- function(x){
  # return NA when there is an error
  y = NA
  # tryCatch error
  try_error = tryCatch(tolower(x), error = function(e) e)
  # if not an error
  if (!inherits(try_error, 'error'))
    y = tolower(x)
  return(y)
}

cleanCorpus<-function(corpus, customStopwords){
  corpus <- tm_map(corpus, content_transformer(qdapRegex::rm_url)) 
  corpus <- tm_map(corpus, content_transformer(tryTolower))
  corpus <- tm_map(corpus, removeWords, customStopwords)
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, stripWhitespace)
  return(corpus)
}

# EDA
table(txt$campus)

# make corpus and clean
bosTxt <- subset(txt, txt$campus=='Boston')
bosCorp <- VCorpus(VectorSource(bosTxt$allText))
bosCorp <- cleanCorpus(bosCorp, stops)

# DTM
bosDTM <- DocumentTermMatrix(bosCorp)
bosDTM <- as.matrix(bosDTM)

# WFM
bosWFM <- colSums(bosDTM)

# Examine & Organize
head(bosWFM)
bosWFM <- data.frame(word = names(bosWFM), freq = bosWFM)
rownames(bosWFM) <- NULL
bosWFM <- bosWFM[order(bosWFM$freq, decreasing = T),]

# Plot WFM
barplot(bosWFM$freq[1:5], names.arg = bosWFM$word[1:5], las = 2)
dev.off()

# Word cloud
wordcloud(______$word, _______$freq, max.words=__)


# End