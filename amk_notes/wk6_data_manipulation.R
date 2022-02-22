# 2022-02-15
# dplyr and plyr

library("tidyverse")

library("dplyr")

dat <- read.delim(file = "http://www.stat.ubc.ca/~jenny/notOcto/STAT545A/examples/gapminder/data/gapminderDataFiveYear.txt")


dat[which(dat$country == 'Afghanistan'),]
dat[which(dat$year < 1960), ]

?subset

subset(dat, dat$year < 1960)

subset(dat, dat$year < 1955,
       select=c(lifeExp, gdpPercap)) #select is only refering to columns 

hist(dat$pop)
hist(log(dat$pop))

dat1<- dat[!is.na(dat$lifeExp),]
dim(dat1)

dat2 <- dat[-is.na(dat$lifeExp),]
dim(dat2) # there is no NAs so it cannot remmove anything now that data set is 0


# litterally whattttt fo the %in% example 
# which 


#match tad uses for matching column names 


### BASE R OVER lol


library(plyr)
library(dplyr)

# input first letter
# output second letter 
# a - array
# l - list
# d - data frame 

grabFirst <- function(x){unlist(strsplit(x,''))[1])}

aaply(dat[,c('lifeExp', )] # aaply is stupid don't use aaply
      
lst<- as.list(1:10, 1:10, 1:10, 1:10, 1:10)
      
lst      


ldply(lst, function(x){c(x[1], x[length(x)])})    
      
#b


aaply(dat$country, function(x){unlist(strsplit(x,''))[1])})
      
#####################################
      
      #how many countries are in Asia
      

head(dat)      
asia <- subset(dat, dat$continent == 'Asia')
howMany<- unique(asia$country)
dim(howMany)

