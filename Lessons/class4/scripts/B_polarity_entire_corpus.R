#' Title: Polarity on a corpus
#' Purpose: Learn and calculate polarity 
#'

# Wd
setwd("~/GitHub/Lessons/class4/data")

# Libs
library(tm)
library(qdap)

# Data I
text <- readLines('pharrell_williams_happy.txt')

# Polarity on the document
polarity(text)

# Does it Matter if we process it?
source('~/Desktop/hult_NLP_student/lessons/Z_otherScripts/ZZZ_supportingFunctions.R')

txt <- VCorpus(VectorSource(text))
txt <- cleanCorpus(txt, stopwords("SMART"))
polarity(content(txt[[1]]))

# Examine the polarity obj more
pol <- polarity(content(txt[[1]]))

# Word count detail
pol$all$wc

# Polarity Detail
pol$all$polarity

# Pos Words ID'ed
pol$all$pos.words

# Neg Words ID'ed
pol$all$neg.words

# What are the doc words after polarity processing?
pol$all$text.var[[1]]

# Document View
pol$group

# End
