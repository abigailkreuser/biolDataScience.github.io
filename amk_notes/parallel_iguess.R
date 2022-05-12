library(parallel)
parallel::detectCores()

#Each one of theses can run a process

cl <- parallel::makeCluster(2)
cl
str(cl)

system.time(
for(i in 1:5){
Sys.sleep(i)
}
)


)


system.time(
	parallel::clusterApplyLB(cl, 1:5, function(x){
		Sys.sleep(x)
	})
)

#the LB in the function stands for load balancing 

#lists are nice to work with because apply statements can be used in stead of looping sequentially in cluster

# HAVE to export with a list of names, 


parms <- data.frame(index=1:5, 
	numValues=c(1,2,1,3,5),
	minRange=c(0,1,2,1,0),
	maxRange=c(5,8,11,8,5))

# wont work because it hasnt been exported yet 
parallel::clusterApplyLB(cl, parms$index, 
	function(x){
		set.seed(parms$index)
		runif(parms$numValues[x], 
			min=parms$minRange[x],
			max=parms$maxRange[x]
		)
	}
)


parallel::clusterExport(cl=cl, list('parms'))


if you run it again it will work 

# had to use rforge and repos=link to download

lst <- lapply(1:1000, function(x){runif(10000)})
doMC::registerDoMC(4)


lst <- lapply(1:1000, function(x){runif(10000)})
doMC::registerDoMC(4)

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


cl <- parallel::makeCluster(2)
parallel::clusterExport(cl=cl, list('logisticGrowth', 'logisticDynamics'))

parallel::clusterApplyLB(cl, 1:1000, logisticDynamics(


(runif(1:1000))

parallel::clusterApplyLB(cl, parms$index, 
	function(x){
		set.seed(parms$index)
		runif(parms$numValues[x], 
			min=parms$minRange[x],
			max=parms$maxRange[x]
		)
	}
)


### Check lecture notes for building and operating clusters and the for loop


popDynamics <- list()

for(i in 1:1000{
popDynamics[[i]] <- logisticDynamics(i, r=1, k=110, steps=100)
}






