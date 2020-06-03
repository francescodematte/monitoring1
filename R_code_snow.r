setwd("C:/lab/")

install.packages("ncdf4")

library(ncdf4)
library(raster)

snowmay <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1 (1).nc")      #the data refer to May the 26th

cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

plot(snowmay, color=cl)

#how to clump and aggregate the data together?

setwd("C:/snow/")

snow2000 <- raster("snow2000r.tif")
snow2005 <- raster("snow2005r.tif")
snow2010 <- raster("snow2010r.tif")
snow2015 <- raster("snow2015r.tif")
snow2020 <- raster("snow2020r.tif")

par(mfrow=c(2,3))   #think to the number of row and col.
plot(snow2000, col=cl)
plot(snow2005, col=cl)
plot(snow2010, col=cl)
plot(snow2015, col=cl)
plot(snow2020, col=cl)

#faster method to import lots of data -> "lapply" command (it apply a function over a list of vector) to apply raster function to several files (or any sort of object) at the same time

#first of all we have to identify a pattern repeated in each file of the list-> "snow20"

rlist <- list.files(pattern="snow20")

rlist

import <- lapply(rlist, raster)

snow.multitemp <-stack(import)

plot(snow.multitemp,col=cl)

#let's make a prediction    #source function read an r code from a file

source("prediction.r")

#missing

#second lesson

#ex: import the snow cover images all together

rlist <- list.files(pattern="snow")

rlist

import <- lapply(rlist, raster)

snow.multitemp <-stack(import)

plot(snow.multitemp,col=cl)

[16:52] Duccio Rocchini
    
rlist <- list.files(pattern="snow")
rlist


import <- lapply(rlist, raster)

snow.multitemp <- stack(import)

plot(snow.multitemp, col=cl)
 
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

plot(snow.multitemp, col=cl)

prediction <- raster("predictedsnow.2025.norm.tif")
 
plot(prediction, col=cl)

#export the output and imagine you want to send the results to a collegue

writeRaster(prediction, "final.tif")

#final stack

final.stack <- stack(snow.multitemp, prediction)

plot(final.stack, col=cl)

#export the R graph

pdf("my_final_exciting_graph.pdf")

plot(final.stack, col=cl)

dev.off()

png("my_final_exciting_graph.png")

plot(final.stack, col=cl)

dev.off()


 















 

