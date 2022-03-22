#' Title: K Mediods
#' Purpose: apply k Mediod clustering to text
#' https://cran.r-project.org/web/packages/kmed/vignettes/kmedoid.html
#' Additional Resume data sets from kaggle.com
#' 220_resumes.csv 
#' 15k_resumes.csv

# Wd
setwd("~/Desktop/hult_NLP_student/lessons/class6/data")

# Libs
library(kmed)
library(tm)
library(clue)
library(cluster)
library(wordcloud)

# Bring in our supporting functions
source('~/Desktop/hult_NLP_student/lessons/Z_otherScripts/ZZZ_plotCluster.R')
source('~/Desktop/hult_NLP_student/lessons/Z_otherScripts/ZZZ_supportingFunctions.R')

# Options & Functions
options(stringsAsFactors = FALSE)
Sys.setlocale('LC_ALL','C')

# Stopwords
stops <- c(stopwords('SMART'), 'work')

# Read & Preprocess
txtMat <- cleanMatrix(pth = 'basicResumes.csv', 
                      columnName  = 'text', # clue answer text 
                      collapse = F, 
                      customStopwords = stops, 
                      type = 'DTM', 
                      wgt = 'weightTfIdf') #weightTf or weightTfIdf

# Remove empty docs w/TF-Idf
txtMat <- subset(txtMat, rowSums(txtMat) > 0)

# Use a manhattan distance matrix; default for kmed
manhattanDist <- distNumeric(txtMat, txtMat, method = "mrw") 

# Calculate the k-mediod
txtKMeds <- fastkmed(manhattanDist, ncluster = 5, iterate = 5)

# Number of docs per cluster
table(txtKMeds$cluster)
barplot(table(txtKMeds$cluster), main = 'k-mediod')

# Visualize separation
plotcluster(manhattanDist, txtKMeds$cluster, pch = txtKMeds$cluster)

# Silhouette
silPlot          <- silhouette(txtKMeds$cluster, manhattanDist)
plot(silPlot, col=1:max(txtKMeds$cluster), border=NA)

# Median centroid documents:
txtKMeds$medoid

# End