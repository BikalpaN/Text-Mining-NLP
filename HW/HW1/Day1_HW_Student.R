#' Title: NLP HW 1
#' NAME: 
#' Date: Feb 20 2022
#' 

# To limit errors please run this code
Sys.setlocale('LC_ALL','C')

#### 
# set your working directory


# Load the following libraries ggplot2, ggthemes stringi, and tm


# load the homework data in an object called `text`


#### 
# 
# Examine the first 10 rows of data


# Print the column names to console. 


# What is the first tweet text? 
# Answer:

# What are the dimension (number of rows and columns)? Use a function. Hint dim(),nrow(), ncol() could all help you
# Answer:

#### 
# Find out what rows have "virus" in the $text column, ignoring the case, in an object called idx


# What is the length of idx?
# Answer: 

# What is the tenth text mentioning "virus"
# Answer:

#### 
# Use grepl to make idx  for 'virus', ignoring case


# Now what is the length of idx?
# Answer: 

# As a percent, how many tweets mention "virus" among all tweets?
# Answer: 

#### 
# Write a function accepting a text column
# use gsub subsituting 'http\\S+\\s*' for '' which removes URLS
# use gsub substituting '(RT|via)((?:\\b\\W*@\\w+)+)' for '' which removes "RT" exactly
# use tolower in the function on the text
# return the changed text
basicSubs <- function(x){
  x <- ____('______', '', _)
  _ <- ____('______', '', _)
  _ <- tolower(_)
  return(x)
}

# apply the function to JUST THE TEXT COLUMN to  a new object txt


#### 
# Use sum with stri_count on the newt txt object
# with "trump", "biden" and in the last one check for "virus" OR "vaccine"
trump  <- ___(stri_count(___, fixed ='_____'))
biden  <- sum(__________(___, fixed ='_____'))
vterms <- ___(__________(___, regex ='_____'))

# Organize term objects into a data frame
termFreq <- data.frame(terms = c('trump','biden','vterms'),
                       freq  = c(_____,_____, ______))

# Examine
termFreq

# Plot a geom_bar with ggplot2 by filling in the correct data, adding a layers "theme_gdocs() + theme(legend.position = "none")"
ggplot(________, aes(x = reorder(terms, freq), y = freq,fill=freq)) + 
  _________(stat = "identity") + coord_flip() + 
  ___________() + _____(___________)

#### 
# Create some stopwords using the 'SMART' lexicon and add 'rofl'
stops <- c(___)

# Create a Clean Corpus Function
# add into the function removePunctuation
# add into the function removeNumbers
# add into the function stripWhitespace
cleanCorpus<-function(corpus, customStopwords){
  corpus <- tm_map(corpus, content_transformer(qdapRegex::rm_url)) 
  corpus <- tm_map(corpus, content_transformer(tolower))
  corpus <- tm_map(corpus, removeWords, customStopwords)
  corpus <- tm_map(corpus, _________________)
  corpus <- tm_map(corpus, _____________)
  corpus <- tm_map(corpus, _______________)
  return(corpus)
}

# Apply the VCorpus Function to a VectorSource of the original text object
# Hint: only pass in the vector NOT the entire dataframe using a $
cleanTxt <- _______(____________(_________))

# Clean the Corpus with your cleanCorpus function, this will take a few seconds
cleanTxt <- ___________(cleanTxt, stops)

# Construct a DTM in an object called cleanMat

# Switch this to a simple matrix still called cleanMat


# What are the dimensions of this matrix
___(______)

# What do rows represent in this matrix?
# Answer: 

# How many unique words exist in the matrix?
# Answer: 

# End