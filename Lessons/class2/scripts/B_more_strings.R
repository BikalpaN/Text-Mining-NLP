#' Title: R Sting Basics Stringi & Stringr
#' Purpose: Explore a bunch of functions from the most common string manipulations packages
#' License: GPL>=3
#' 

# Wd
setwd("~/GitHub/Lessons/class2/data")


# library
library(stringi)
library(stringr)

# Suppose these two sentances were two huge pieces of text
txt  <- '<b>THIS IS ALL CAPS</b> <br>'
txt2 <- 'this is not in caps          '
txt3 <- 'this is NOT a long sentence is it?'

# Lowercase
txt <- tolower(txt)
txt

# global substitution
gsub('<br>', '~~~~some html~~~~', txt) #replace with something
gsub('<br>', '', txt) #find specific and replace w nothing
txt <- gsub("<.*?>",'', txt )#find with wildcard, replace w nothing
txt

# stringr version
str_replace_all(txt, "<.*?>",  '')

# Let's combine our three separate objects
allText <- c(txt, txt2, txt3)

# Again let's find terms
grep('not', allText, ignore.case = T) # index position
grepl('NOT', allText) # Case matters!
grepl('NOT', allText, ignore.case = T)


# Review the txt
allText

# There are literally hundreds of functions in stringi and stringr here are just a few
## stringi examples
# Exact character position of the term "not" for each document
whereIsNot <- stri_locate_all(allText, fixed = 'not')
whereIsNot # this is a list!

# Instead of fixed we can use RegEx and make it case insensitive 
whereIsNot <- stri_locate_all(allText, regex = 'not', case_insensitive=TRUE)
whereIsNot # this is a list!

# When using regex you can add more 
# Locate terms if they are present
str_locate_all(allText, 'not')
str_locate_all(allText, 'not|is') 

# Grep gives you presence of at least one, either index of T/F, this is a count
stri_count(allText, fixed="is")

# There may be times we need to break up word individually or by a character
str_split(allText, " ") # result is a list!

# Now lets say we have messy text from an API or scraped where column 1 is and ID and column 2 is text
messyTxt <- c('123...this is text to be examined',
              '234...this is more text to be examined',
              '345...this is yet more text for analysis')
messyTxt


splitDocs <- str_split(messyTxt, pattern = "[...]")
splitDocs

# Suppose you now want to get the last element of this list?
sapply(splitDocs, tail, 1)

# Or better yet both elements
cleanedTxt <- data.frame(doc_id = sapply(splitDocs, head, 1),
                         txt    = sapply(splitDocs, tail, 1))
cleanedTxt

## stringr examples
# Extract terms if they are present
str_extract(allText, 'not')
str_extract(allText, 'this')

# Change the capitalization
str_to_upper(allText, locale = "en")
str_to_lower(allText, locale = "en")
str_to_title(allText, locale = "en")
str_to_sentence(allText, locale = "en")

# What about trimming?
str_trim(allText, side = c("both", "left", "right"))

# Base R trim
trimws(allText, which = 'both')

# End