# 2022-02-10
# string manipulation


vonn <- c('Everything was beautiful and nothing hurt')

bruh <- c('why is vonnegat everywhere')


femme <- c('does vonnegat hate women in all of his books?')

tolower(vonn)
toupper(vonn)

nchar(vonn)
substr(vonn, 1, 10) #specify the exact position you want to pull out in the string 
substr(vonn, nchar(vonn)-3, nchar(vonn))


#substring is like substr with no end 


#replace single characters
chartr(old='e',new='a',x=bruh)
# nice for stirpping away unicode characters 
chartr(old ='et', new='ad', x=vonn)
# doesn't change how you expect 
# it changes t to d not et as a group

gsub("Everything", "Nothing", vonn)

gsub(".", "Nothing", vonn)
# every singular character is replaced so 41 nothings


vonn2<- strsplit(vonn,' ')
vonn2
length(vonn2) # its a list 
vonn3 <- unlist(vonn2)
# unlist may be a helpful function

paste(vonn3, collapse=' ')
# HELPFUL FOR THoSE FUCKIN CHART TITLES I WAS TRYING TO DO 

vonn4 <-paste(vonn3, LETTERS[1:length(vonn2)], sep='-')
vonn4
#idk but I have different outputs 

startsWith(vonn4, 'b')
endsWith(vonn4, 'g')


grepl('hurt', vonn4) # when looking for specifc species or something 
grep('hurt', vonn4)

#super duper useful 
grep('u', vonn4)
