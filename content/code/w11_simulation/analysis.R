
library(plyr)

data(mtcars)

pdf('cars.pdf')
plot(mtcars$cyl, mtcars$gear, 
  pch=16, las=1, col='dodgerblue')
dev.off()

cor.test(mtcars$cyl, mtcars$gear)

save.image('analysis.RData')


