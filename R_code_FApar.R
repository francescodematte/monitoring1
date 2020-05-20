let's look at chemical cycle from a satellite



#regression model between FAPAR and NDI

erosion<-c(12,14,16,24,26,40,55,67)

#heavy metals

hm<-c(30,100,150,200,260,340,460,600)

plot(erosion, hm, col="red", pch=19, xlab="erosion", ylab="heavy metals")

model1 <- lm(hm ~ erosion)

abline(model1)

setwd("C:/lab/")

library(raster)
library(sf)   # otherwise-> install.packages...

faPAR10 <- raster("~/lab/faPAR10.tif")

library(rasterdiv)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA), right=TRUE)

library(sf) # to call st_* functions
random.points <- function(x,n)
{
lin <- rasterToContour(is.na(x))
pol <- as(st_union(st_polygonize(st_as_sf(lin))), 'Spatial') # st_union to dissolve geometries
pts <- spsample(pol[1,], n, type = 'random')
}

pts <- random.points(faPAR10,1000)   #software is going to select 1000 random faPAR10 points-> sample representative of the variables

copNDVIp <- extract(copNDVI, pts)

faPAR10p <- extract(faPAR10,pts)

model2 <- lm(faPAR10p ~ copNDVIp)
 
plot(copNDVIp, faPAR10p, col="green", xlab="biomass", ylab="photosynthesis")

abline(model2, col="red")



 

 

