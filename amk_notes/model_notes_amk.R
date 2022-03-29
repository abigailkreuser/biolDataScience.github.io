# 2022-03-15

# Modeling 

# all the old ladies at the grocery store would tell me to model
# here I am
# modeling

# show a natural phenomenon 
# what sarsCov2 dynamics could look like 
# fit some model that fits the data generating process 
# built a model and fits data 
# 


# READING for thursday only discuss statistical models 
# SIR model infetious disease dynamics 


# 

y <- runif(100)
x <- y ** runif(100, 1,4)

m1 <- lm(y~x)

m1
?glm
str(m1)
summary(m1)
str(m1[1])
m1[1:[1]]

plot(y=y,x=x, pch=16, 
     ylab='y', xlab='x', 
     col='dodgerblue', las=1)
abline(m1, lwd=2) # adds a trendline 
lines(smooth.spline (y=y, x=x), col='red', lwd=2)


m3 <- lm(y~poly(x,2))
lines(x=sort(x), fitted(m3)[order(x)],
      col="purple", type = "l", lwd = 2)


m4 <- lm(y~poly(x,3))
lines(x=sort(x), fitted(m4)[order(x)],
      col="green", type = "l", lwd = 2)
ls()
# glm extends the linear model 
# caret packages for stacking and ensembling models 



# predictive challenge 
# download Fun Lab 

y <- runif(100)
x1 <- y ** runif(100, 1,4)
x2 <- x1 ** runif(100, 0.5,1.5)
dat <- data.frame(y,x1,x2)

m6 <- lm(y~x1+x2, data=dat)

m7 <- lm(y~x1*x2, data=dat)

plot(y=y,x=x1, pch=16, 
     ylab='y', xlab='x', 
     col=viridis::viridis(100)[as.numeric(cut(x2,100))], las=1)

summary(m6)
summary(m7)


#feature reduction 
# colinear variable s
# every variable you add degrades model performance
# becasue of regularization 
# 


y.1 <- runif(1000)
x.1 <- y.1 * runif(1000, 0.6,1.4) + runif(1000)
x.2 <- c('a', 'b')[1+rbinom(length(x.1), 1, prob=x.1/max(x.1))]
dat2 <- data.frame(y.1,x.1,x.2)

m8 <- lm(y.1~x.1+x.2, data=dat2)
summary(m8)


#plotting them out 
plot(m6)

# would expect a line around 0 for the Residuals vs fitted 

plot(y=predict(m6), x=y)
#has a wierd curviliniear shape which is expected kindof 
# because thats what our model looked like 

newData <- data.frame(x1=x1[1:10], x2=x2[1:10])

predict(m6, newData, interval='confidence')
preds <- as.data.frame(predict(m6, newData, interval='confidence'))

plot(y=y, x=x1, col=1, pch=16, ylim=c(0,1.25)) #full data 
points(y=preds$fit, x=x1[1:10], pch=16, col='red') # fitted values 
segments(y0=preds$lwr, y1=preds$upr, x0=x1[1:10], col='red') #drawing error bars on the predicted points 



### Training and test data 
# 
?sample()
sample(1:10, 2, replace=TRUE, prob=1:10) # dont remember what probability means 


trainMod <- function(dat, holdOut=0.2){
   inds <- sample(x=1:nrow(dat), size = round(nrow(dat)*holdOut,0))
   train <- dat[-inds, ] # 0.8 of data the neg sign just removes the test data
   test  <- dat[inds, ] 
   mod <- glm(y ~ x1+x2, data=train)
   ret <- data.frame(truth=test$y, pred=predict(mod, newdata=test))
   return(ret)
}

trainMod(dat)


preds2 <- trainMod(dat)
plot(preds2$truth, preds2$pred, 
     pch=16)
abline(a=0, b=1, lwd=2, col="hotpink")

# accuracy - TP and TN, sensitivity and negativity
#discrimination - AUC 





#install.packages('gbm')
library(gbm)

trainMod2 <- function(dat, holdOut=0.2){
   inds <- sample(1:nrow(dat), round(nrow(dat)*holdOut,0))
   train <- dat[-inds, ]
   test  <- dat[inds, ]
   mod <- glm(y ~ x1+x2, data=train)
   mod2 <- gbm(y ~ x1+x2, data=train, n.trees=1000, 
               interaction.depth=3, cv.folds=5)
   brt.best.iter <- gbm.perf(mod2, method='OOB', plot=FALSE)
   ret <- data.frame(truth=test$y, 
                     predGLM=predict(mod, newdata=test), 
                     predGBM=predict(mod2, newdata=test, type='response', n.trees=brt.best.iter))
   return(ret)
}

preds3 <- trainMod2(dat)

glmAcc <- sqrt(mean((preds3$truth - preds3$predGLM)**2))
gbmAcc <- sqrt(mean((preds3$truth - preds3$predGBM)**2))




#Its important to note that the model accuracy will change as it uses a random subset of 20% holdout data each time the function is called. We can use that to our advantage when comparing models, as we can train the model $n$ times to see if the distributions of accuracy are distinct between models. It is also important to note here though that we can have lots of control over the outcome of any statistical test for model differences here by increasing the number of times we train the models to minimize the error in the distribution of accuracy values. 




glmA <- gbmA <- c()
for(i in 1:10){
	set.seed(i)
	preds3 <- trainMod2(dat)

	glmA[i] <- sqrt(mean((preds3$truth - preds3$predGLM)**2))
	gbmA[i] <- sqrt(mean((preds3$truth - preds3$predGBM)**2))

}

