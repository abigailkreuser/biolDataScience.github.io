# white wine what makes it high quality??
library(gbm)
train <- read.csv("content/code/w10_modeling/funLab/whiteWineTrain.csv", sep=',')
test <- read.csv("content/code/w10_modeling/funLab/whiteWineTest.csv", sep=',')

write.csv(train, file='whiteWineTrain.csv')
write.csv(test, file='whiteWineTest.csv')

summary(train)


mod <- lm(quality ~ fixed.acidity + volatile.acidity + citric.acid + residual.sugar +
            chlorides + free.sulfur.dioxide + total.sulfur.dioxide + density + pH + sulphates +
            alcohol,data=train)
summary(mod)

mod_best <- step(mod)
summary(mod_best)

mod2 <- lm(quality ~ volatile.acidity + residual.sugar, data = train)
summary(mod2)



mod4 <-  lm(quality ~ fixed.acidity*volatile.acidity*citric.acid*residual.sugar*
              chlorides*free.sulfur.dioxide*total.sulfur.dioxide*density*pH*sulphates*
              alcohol, data = train)
summary(mod4)
mod_best2 <- step(mod4)

mod5 <-  lm(quality ~ (fixed.acidity + volatile.acidity + citric.acid + residual.sugar +
              chlorides + free.sulfur.dioxide + total.sulfur.dioxide + density + pH + sulphates +
              alcohol)^2,data=train)
summary(mod5)


mod6 <-  lm(quality ~ ( volatile.acidity + residual.sugar +
                         chlorides + sulphates +
                         alcohol)^2,data=train)
summary(mod6)

mod3 <- gbm(quality ~ volatile.acidity + residual.sugar +
           chlorides + density + pH + sulphates +
           alcohol,data=train, n.trees=1000, 
           interaction.depth=3, cv.folds=5)
mod10 <- gbm(quality ~ fixed.acidity + volatile.acidity + citric.acid + residual.sugar +
               chlorides + free.sulfur.dioxide + total.sulfur.dioxide + density + pH + sulphates +
               alcohol,data=train, n.trees=1000, 
             interaction.depth=3, cv.folds=5)
summary(mod10)
preds <- predict(mod10, newdata=test, type='response', n.trees=gbm.perf(mod10,method='OOB'))
sqrt(mean((preds-test$quality)**2))
summary(preds)


#GOOGLE how to find the area of a polygon in base R
#alcohol, v.acidity, free.sulfur, residual.sugar
mod11 <- gbm(quality ~ volatile.acidity + residual.sugar +
               free.sulfur.dioxide + sulphates +
               alcohol,data=train, n.trees=1000, 
             interaction.depth=3, cv.folds=5)
summary(mod11)
preds <- predict(mod11, newdata=test, type='response', n.trees=gbm.perf(mod11,method='OOB'))
sqrt(mean((preds-test$quality)**2))
summary(preds)

mod12 <- lm(quality ~ alcohol,data=train)
summary(mod12) 


preds <- predict(mod12, newdata=test, type='response')
sqrt(mean((preds-test$quality)**2))
summary(preds)

summary(mod12)


#0.7

preds <- predict(mod3, newdata=test, type='response', n.trees=gbm.perf(mod3,method='OOB'))
sqrt(mean((preds-test$quality)**2))
summary(preds)

summary(mod3, las=1)
brt.best.iter <- gbm.perf(mod3, method='OOB', plot=FALSE)

summary(brt.best.iter)


mod12 <- lm(quality ~ alcohol,data=train)
summary(mod12) 


mod20 <- glm(quality ~  volatile.acidity +  residual.sugar + total.sulfur.dioxide + alcohol,data=train)
summary(mod20)
preds <- predict(mod5, newdata=test, type='response')
sqrt(mean((preds-test$quality)**2))
summary(preds)
