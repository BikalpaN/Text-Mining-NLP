#' Title: Quick Taste of what's to come
#' Purpose: Learn some basic functions
#' License: GPL>=3
#' Date: Feb 22, 2021
#'

# 1. WD
setwd("~/GitHub/class1/data")

# 2. Data
txt <- read.csv("exampleNews.csv" )

# 3. Libs
library(qdap)
library(tm)

# 4. Apply some functions
pol <- polarity(txt$description, txt$name)
freq <- freq_terms(txt$content, stopwords = stopwords('SMART'))

# 5. Consume
barplot(pol$group$ave.polarity, names.arg = pol$group$name, las= 2)
plot(freq)

# End