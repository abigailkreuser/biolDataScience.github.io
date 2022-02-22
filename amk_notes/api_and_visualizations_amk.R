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

