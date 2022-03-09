#2022-02-22
#happy2sday

### apis vs web scraping 
# scraping is maybe not technically legal under thier terms of service
# apis may be because a company wants you to use their data. 
# web scraping - extracting data from html pages 
# if a website changes format- could break all of the code you r wrote to scrape it 
# 
#public data that has been collected using taxpayer money 

install.packages(c('httr',"jsonlite"))
library('httr')
library('jsonlite')

von <- httr::GET('http://openlibrary.org/search.json?q=vonnegut')
str(von)
class(von) # class is response what does that mean
names(von)
str(von[[4]])
# is a list of 1 that is a list of 3
#json is essentially a list of a nested lists ...lot of things 

vonInfo <- jsonlite::fromJSON(
  httr::content(von, "text"), 
  simplifyVector = FALSE)
#this didnt work isk what jsonlite is about but I have had it downloaded at once 

str(head(vonInfo[[4]][[1]]))
vonTitle <- sapply(vonInfo[[4]], function(x){
  x$title
})
#SIMPLIFY - S in sapply
#if opperating over a list it will return a vector 
vonTitle


von2 <- httr::GET('http://openlibrary.org/search.json?author=vonnegut')
str(von2)

vonInfo2 <- jsonlite::fromJSON(content(von2, "text"), simplifyVector = FALSE)
str(vonInfo2[[4]][[1]])

vonTitle2<- sapply(vonInfo2[[4]], function(x){
  x$title
})


vonLang<- sapply(vonInfo2[[4]], function(x){
  x$language
})

vonLang<- sapply(vonInfo2[[4]], function(x){
  x$language
})



abby <- httr::GET('https://api.github.com/users/abigailkreuser')
abbyInfo <- jsonlite::fromJSON(content(abby, "text"), simplifyVector = FALSE)

str(abbyInfo)



#BIOLOGY
giraffe <- httr::GET('https://www.gbif.org/developer/species/Giraffa+camelopardalis')
str(giraffe)

#ROpenSci
#they querry apis so we don't have to 


install.packages('rgbif')
install.packages('rgeos')
install.packages('maps')
library('rgeos')
library('rgbif')


install.packages('maps')




giraffe <- rgbif::occ_search(scientificName = "Giraffa camelopardalis", 
                             limit = 5000)

giraffe2 <- rgbif::occ_search(scientificName = "Giraffa camelopardalis", 
                              limit = 5000)[[3]]
head(giraffe2)

maps::map() 
points(giraffe2$decimalLongitude, giraffe2$decimalLatitude, pch=16, 
       col=grey(0.1,0.5))


plot(1:5, col=1:5)

colnames(giraffe2)
range(giraffe2[["year"]], na.rm = TRUE)

plot(table(giraffe2[["year"]]))



install.packages('RSQLite')
install.packages('dbplyr')
install.packages('DBI')

library(DBI)
library(RSQLite)
library(dbplyr)
library(dplyr)
getwd()
setwd("amk_notes")
list.files()

dir.create("data_raw")
setwd('..')


dir.create("data_raw", showWarnings = FALSE)
download.file(url = "https://ndownloader.figshare.com/files/2292171",
              destfile = "data_raw/portal_mammals.sqlite", mode = "wb")
mammals <- DBI::dbConnect(RSQLite::SQLite(), "data_raw/portal_mammals.sqlite")
dbplyr::src_dbi(mammals)

str(mammals)
# this data base contains three different tables 
# small mammals in the desert community
# species found and data about each survey 
# 

#need the tbl fxn from within dplyr to get the tables of data 

dplyr::tbl(mammals, sql("SELECT year, species_id, plot_id FROM surveys"))

surveys <- dplyr::tbl(mammals, "surveys")
surveys %>%
  dplyr::select(year, species_id, plot_id)


surveys2 <- surveys %>%
  dplyr::filter(weight < 5) %>%
  dplyr::select(species_id, sex, weight)


surveys3 <- dplyr::collect(surveys2)
head(surveys3)
dim(surveys3)


plots <- dplyr::tbl(mammals, "plots")
plots

survPlot <- dplyr::left_join(surveys, plots, by='plot_id')
survPlot <- dplyr::collect(survPlot)
#hindfoot_length weight

plot(weight~hindfoot_length, data = survPlot, col = rainbow(48)[as.factor(survPlot$species_id)])


points(species_id, col = "blue")
points(1:5, runif(5), pch=16,
              col='orange'))
