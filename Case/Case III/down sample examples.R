# Sampling large text
source('~/Desktop/hult_NLP_student/lessons/Z_otherScripts/ZZZ_supportingFunctions.R')
setwd("~/Desktop/hult_NLP_student/cases/session II/WallStreetBets")

txt <- read.csv("CASE_gme.csv" )

# One method is random sample
idx <- sample(1:nrow(txt), 5000)
randoTxt <- txt[idx,]

# Subset by a cutoff date
txt$comm_date <- as.Date(txt$comm_date)
before <- subset(txt, txt$comm_date < '2021-01-01')
after <- subset(txt, txt$comm_date >= '2021-01-01')

# When you have a DTM and as.matrix fails
big <- VCorpus(VectorSource(txt$comment))
big <- cleanCorpus(big, stopwords('SMART'))

# Big
big <- DocumentTermMatrix(big)
dim(big)
# Option 1
smaller <- removeSparseTerms(big, sparse=0.999)
dim(smaller)
# Option 2
library(slam)
smallOption2 <- big[, col_sums(big)>9]
dim(smallOption2)
