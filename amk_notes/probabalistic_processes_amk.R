#probalistic processes
#2022-04-12



logisticGrowth <- function(n, r, k){
  n*exp(r*(1-(n / k)))
}


logisticDynamics <- function(n,r,k, steps=100){
  ret <- c()
  ret[1] <- n
  if(length(r) == 1){
    r <- rep(r, steps)
  }
  for(i in 1:(steps-1)){
    ret[i+1] <- logisticGrowth(ret[i], r[i], k)
  }
  return(ret)
}

plot(logisticDynamics(10, 0.2, 100, steps=50))

#demographic stochasticity 
# deterministically vs probablitisticyly 

logisticP1 <- function(Nt, b=0.1, d=0.1) {
  births <- sum(rbinom(Nt,1,b))
  deaths <- 0
  pop <- (Nt + births - deaths) 
  return(pop)
}

logisticP2 <- function(Nt, b=0.1, d=0.1) {
  births <- sum(rbinom(Nt, 1, b))
  deaths <- sum(rbinom(Nt, 1, d))
  pop <- (Nt + births - deaths) 
  return(pop)
}

#Probability
#####

library(MASS)
fitdistr()
#use this to 
fitdistr(rpois(10,2), densfun = 'Poisson')
pnorm(-1, mean=0, sd=1)
