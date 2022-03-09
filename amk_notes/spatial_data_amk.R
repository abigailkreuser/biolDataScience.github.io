#2022-03-01

# Reading for this week --- be ready to discus this week
# Brunsdon and Comber 2020

# Arc GIS sledge hammer ?? 
# points, lines, polygons, and rasters

#sf vs sp- sf is the newer one and sp is going into the grave soon


library(sp)
library(sf)
#rasters are square lattice
library(raster)
library(gdal)
library(rgeos)


name <- LETTERS[1:10]
longitude <- c(-116.7, -120.4, -116.7, -113.5, -115.5,
               -120.8, -119.5, -113.7, -113.7, -110.7)
latitude <- c(45.3, 42.6, 38.9, 42.1, 35.7, 38.9,
              36.2, 39, 41.6, 36.9)


#simulated rainfall data
set.seed(0)
precip <- round((runif(length(latitude))*10))

stations <- data.frame(longitude, latitude, name, precip)


#YO WHAT IS GOING ON


par(mar=c(4,4,0.5,0.5))

# adding points
plot(stations[,1:2], 
     cex=stations$precip, 
     pch=16, 
     col='dodgerblue')
text(stations, name, pos=4)

# adding polygons 
polygon(stations[1:3, 1:2], 
        col=adjustcolor('firebrick', 0.25))

# adding lines
lines(stations[3:6, 1:2], lwd=2, col=grey(0.5,0.5))



#now moving on to sp as a package 

pts <- sp::SpatialPoints(stations[,1:2])


typeof(pts)
class(pts)
str(pts)

# S3, S4, R6
# typses of data
# S3 is most data
# s4 is api and spatial data
# R6 sommething else about object oriented 

#bbox - is a bounding box that is holding in your data


#crs is important for understanding lat long and taking the curvature of the earth into account. 


ptsdf$random <- runif(nrow(ptsdf))
ptsdf


ptsdf2 <- ptsdf[which(ptsdf$random < 0.5), ]
ptsdf2

plot(ptsdf, col='red', cex=2)
points(ptsdf2, pch=16, col='dodgerblue')
#summary plotting points that are S4 and they work with Rs plotting function
#How to make the sexiest map???


# raster data 


library(raster)

rast <- raster(ncol=100, nrow=100, 
               xmx=-80, xmn=-150, ymn=20, ymx=60)

values(rast) <- runif(ncell(rast))

rast
str(rast)

plot(rast) #looks like vommit 
# adding polygons 
polygon(stations[1:3, 1:2], 
        col=adjustcolor('firebrick', 0.25))

# adding lines
lines(stations[3:6, 1:2], lwd=2, col=1)


rastStack <- stack(rast, 
                   rast*runif(100*100), 
                   rast*runif(100*100),
                   rast*10)

plot(rastStack)
#keeping all spatial data at the same resolution 
#which that is helpful because that shit was mad hard

rast[1:3,1:3, drop=FALSE]

#?resample
# there are ways to change the resoulution with multiple codes

r1<- raster::crop(rast,extent(-140,-120,0,30))
plot(r1)
r2 <- raster::crop(rast, extent(-100, -80, 30, 40))
m <- raster::merge(r1, r2)
plot(m)


#using examples with patterns even if we don't want there to be 
# assumed patterns 
# I think is helpful because rando values. 
# its hard to understand visually where you are navigating too 


cells <- raster::cellFromRowCol(rast, 50, 35:39)
cells

rast[cells]

raster[cells]
raster::extract(rast, cells)


xy <- raster::xyFromCell(rast, cells)
xy

raster::extract(rast, xy)


r1sp <- as(r1, 'SpatialPolygonsDataFrame')

plot(r1sp)


rpts <- rasterize(pts, rast)

plot(rpts, xlim=c(-130,-105), ylim=c(30,50))
points(pts)





pts2 <- raster::rasterToPoints(rpts) #giving points at the center of every box
# might not be the most helpful, and also could be bad practice going back and forth between 
# 

plot(rpts, xlim=c(-130,-105), ylim=c(30,50))
points(pts)
points(pts2, pch=16, col='red')

f <- raster(system.file("external/rlogo.grd", package="raster"))

plot(f, col=rainbow(1000))



tavg1 <- raster('tavg/wc2.1_10m_tavg_01.tif')
str(tavg1)

plot(tavg1)



tavg <- raster::stack(
        raster('tavg/wc2.1_10m_tavg_01.tif'),
        raster('tavg/wc2.1_10m_tavg_02.tif'),
        raster('tavg/wc2.1_10m_tavg_03.tif'),
        raster('tavg/wc2.1_10m_tavg_04.tif'),
        raster('tavg/wc2.1_10m_tavg_05.tif'),
        raster('tavg/wc2.1_10m_tavg_06.tif'),
        raster('tavg/wc2.1_10m_tavg_07.tif'),	
        raster('tavg/wc2.1_10m_tavg_08.tif'),
        raster('tavg/wc2.1_10m_tavg_09.tif'),
        raster('tavg/wc2.1_10m_tavg_10.tif'),
        raster('tavg/wc2.1_10m_tavg_11.tif'),
        raster('tavg/wc2.1_10m_tavg_12.tif')
)	



#NEED TO REVISIT UGHHHHH CANNOT CHANGE THE COMMMAND lINE
