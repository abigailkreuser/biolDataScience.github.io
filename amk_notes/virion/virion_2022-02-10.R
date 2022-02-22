install.packages('vroom', repos='htts://cloud.r-project.org')

install.packages("vroom")
library("vroom")



virion <-vroom::vroom('data/Virion.csv.gz')
dim(virion)


# starting with data explorations

head(virion) #tibble is a tidy verse version of dataframe- maybe beneficial for spatial data- but tad says
# use specific spatial data frame 

str(virion)


virionInt <- table(virion$Host, virion$Virus)
dim(virionInt)
# shows 3717 unique hosts and 10191 virus

# too much don't run image(virionInt)


hist(colSums(virionInt > 0),
     col= 'dodgerblue', breaks=100,
     main='', xlab='Number of hosts per virus',
     las=1)
#showing the mean of the number of hosts per virus- looks close to 1
abline(v=mean(colSums(virionInt>0)), lwd=2)
mean(colSums(virionInt>0))


which.max(colSums(virionInt[,-1]>0))
which.max(colSums(virionInt>0))


num <- sum(grepl('abramis', virion$HostGenus))
num

