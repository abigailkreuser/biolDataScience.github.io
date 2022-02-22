2022-2-17

### dplyr-specific function

library(dplyr)



dat <- read.delim(file = "http://www.stat.ubc.ca/~jenny/notOcto/STAT545A/examples/gapminder/data/gapminderDataFiveYear.txt")

df <- data.frame(A=runif(100), B=runif(100), D=rnorm(100,1,1))
df2 <- dplyr::rename(df, a=A, b=B, d=D)
#lexical scoping 
#hard on the scoping


hist(df$A)
hist(df$D)

colnames(df)
tolower(colnames(df))


# cannot select rows in the tidy verse
# for good or for bad

select(df2, a) # this is a df 
str(df2$a) # this is a vector


dplyr::select(df2, obs = starts_with('a'))
# helpful for starts with end with for maybe sommething with day at the end


df2a <- dplyr::filter(df2, a < 0.5)
hist(df2$a,  add=TRUE, col=adjustcolor('purple', 0.25), breaks = 5)


df5<- df2 < 0.5
df5

df2[rowSums(df5)==ncol(df2),]


df2c <- dplyr::mutate(df2, e=(a+b)/d)
head(df2c,5)


with(df2, (a+b)/d) # same as a mutate function


datG <- dplyr::group_by(dat,country)
head(datG)


dplyr::summarize(datG, mnLife=mean(lifeExp))
# very nice very nice 

datG <- dplyr::group_by(dat,continent, year)
head(datG)



#joins wont be goood for HW2


df$species <- sample(c('dog', 'cat', 'bird'),100, replace=TRUE) #sample in base R 
info <- data.frame(species=c('dog', 'cat', 'bird', 'snake'),
                   annoying=c(10, 2, 100, 1), 
                   meanBodySize=c(20, 5, 1, 2))
# maintains the structure of df (the "left" data structure)
 sp<- left_join(df, info, by='species')
# maintains the structure of info (the "right" data structure)
sp<- right_join(df,info, by='species')
# return things that are in info but not in df
anti_join(info, df, by='species')
