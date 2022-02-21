# Text Analytics
Hult University Student Repository 


## Working with R
If you are new to R, please take an online course to get familarity prior to the first session.  We will still cover R basics but students have been aided by spending a few hours taking a free online course at [DataQuest](https://www.dataquest.io/path/data-analyst-r/?utm_source=google&utm_medium=cpc&matchtype=&device=c&utm_campaign=career_path&campaignid=12521899431&adgroupid=127692319824&adid=548885764062&utm_content=&gclid=CjwKCAiA6seQBhAfEiwAvPqu14WuiGiQ0aV6mI614prZ4l34Zg6IQfWMdU_1jwUdlxbGfmX0uueM-xoCcK8QAvD_BwE) or [DataCamp](https://www.datacamp.com/learn/r-programming?utm_source=adwords_ppc&utm_medium=cpc&utm_campaignid=16162442326&utm_adgroupid=137028233470&utm_device=c&utm_keyword=r%20course&utm_matchtype=b&utm_network=g&utm_adpostion=&utm_creative=581343733612&utm_targetid=kwd-522531708&utm_loc_interest_ms=9031940&utm_loc_physical_ms=9001821&gclid=CjwKCAiA6seQBhAfEiwAvPqu1w_ojBQKxqtgbTLlc2zVlvX9MtQUV5wB2IMqwTdA_QMY-hVcUOSEXRoCcTIQAvD_BwE).  The code below should be run in the console to install packages needed for the semester.

## Please install the following packages with this R code.
If you encounter any errors don't worry we will find time to work through them.  The `qdap` library is usually the trickiest because it requires Java and `rJava` and does not work on Mac.  So if you get any errors, try removing that from the code below and rerunning.  This will take **a long time** if you don't already have the packages, so please run prior to class, and at a time you don't need your computer ie *at night*.
```
# Individually you can use 
# install.packages('packageName') such as below:
install.packages('ggplot2')

# or 
install.packages('pacman')
pacman::p_load(caret,clue,cluster,dplyr,e1071,echarts4r,fst,ggalt,
 ggplot2,ggthemes,ggwordcloud,glmnet,hunspell,kmed,lda,LDAvis,leaflet,lexicon,
 lsa,mapproj,maps,mgsub,MLmetrics,pbapply,pdftools,plotrix,plyr,pROC,qdap,
 radarchart,rbokeh,RColorBrewer,readxl,reshape2,RTextTools,rvest,skmeans,
 spelling,stringi,stringr,text2vec,tidytext,tm,treemap,viridisLite,vtreat,
 wordcloud,wordcloud2,yardstick)

# Additionally we will need this package from a different repo;
# try this first, but it may timeout since their server is old/slow?
install.packages("http://datacube.wu.ac.at/src/contrib/openNLPmodels.en_1.5-1.tar.gz",
                repos=NULL,
                type="source")

# alternatively, you can download the `openNLPmodels.en_1.5-1.tar.gz` file from 
# https://datacube.wu.ac.at/src/contrib/ then use the following code to install it 
# from a local file; be sure to change the path to your own download location
install.packages("~/Downloads/openNLPmodels.en_1.5-1.tar.gz", repos = NULL, type = "source")

```

