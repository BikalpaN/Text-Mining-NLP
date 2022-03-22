#' Title: Regression
#' Purpose: Learn about a regression model

# libs
library(ggplot2)
library(dplyr)
library(tidyverse) # this is a late class addition, the diamonds data set moved libraries.

# Data
data('diamonds') # No Working Directory needed, ggplot come with the diamonds data
set.seed(1234)

# This is a simple down-sample, not a partitioning schema.  
# There is a difference because you could resample and get the same rows. 
# When you partition you want to ensure no overlap of records.
sampDiamonds <- sample_n(diamonds, 10000)

# EDA
summary(sampDiamonds)

# Simple Relationship Carets to Price
p <- ggplot(sampDiamonds, aes(carat, price)) +geom_point(alpha=0.02)
p

# Since we see a relationship let's make a linear model to predict prices
fit <- lm(price ~ carat + 0, sampDiamonds)
fit

# Add out model predictions
xBeta <- coefficients(fit)
p     <- p + geom_abline(intercept =  0, slope = xBeta, color='red')
p

# End
