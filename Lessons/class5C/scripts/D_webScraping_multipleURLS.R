#' Title: Webscraping multiple pages
#' Purpose: Scrape a page for all urls, then scrape each one in order
#' 

# Library
library(rvest)
library(stringi)

# wd
setwd("~/Desktop/hult_NLP_student/lessons/class7/data")

# Instructor Page
webpage <- 'http://www.gserm.ch/stgallen/instructors/'

# Get all links
getLinks <- read_html(webpage) %>% 
  html_nodes(".instructor") %>% 
  html_attr('href')
getLinks

# Extract and clean names
instructorNames <- gsub('https://www.gserm.ch/stgallen/instructor/',
                        '', 
                        getLinks) 
instructorNames

instructorNames <- gsub("/", "", instructorNames)
instructorNames <- gsub("-", " ", instructorNames)
instructorNames <- stri_trans_totitle(instructorNames)
instructorNames

# Follow links to get more bio's
allBios <- list()
for (i in 1:length(instructorNames)){
  # Progress Msg
  cat(instructorNames[i])
  
  # Get the bio text
  x <- read_html(getLinks[i]) %>% 
    html_nodes(".text") %>% html_text()
  cat('...')
  # Get the photo URL
  y <- read_html(getLinks[i]) %>% 
    html_nodes(".instructor-photo") %>% html_attr("src")
  cat('...')
  df <- data.frame(instructorName = instructorNames[i],
                   bio            = x,
                   photo          = y)
  cat('complete\n')
  allBios[[i]] <- df
}

# Arrange the list to a single data frame
allBios     <- do.call(rbind, allBios)

# Drop the line returns 
allBios$bio <- gsub("[\r\n\t]", "", allBios$bio)
allBios[21,]

write.csv(allBios, 
          'allBios.csv',
          row.names = F)


# End