library(dpylr)
library(ggplot2)
library(lubridate)


mass2014 <- read.csv('./data/mass-shootings/MST2014.csv', stringsAsFactors = F)
mass2015 <- read.csv('./data/mass-shootings/MST2015.csv', stringsAsFactors = F)
mass2016 <- read.csv('./data/mass-shootings/MST2016.csv', stringsAsFactors = F)
mass2017 <- read.csv('./data/mass-shootings/MST2017.csv', stringsAsFactors = F)

