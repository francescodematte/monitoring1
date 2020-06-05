setwd("C:/lab/NO2/")

rlist<-list.files(pattern="EN_")

rlist

import <- lapply(rlist, raster)

NO2.multitemp <-stack(import)

cl <- colorRampPalette(c('darkblue','dark green','yellow'))(100) 

plot(NO2.multitemp,col=cl)

#let's see january and march
par(mfrow=c(1,2))

plot(NO2.multitemp$EN_0001, col=cl)
plot(NO2.multitemp$EN_0013, col=cl)

#RGB space
plotRGB(NO2.multitemp, r=1, g=7, b=13, stretch="lin")

#difference map
dif <- NO2.multitemp$EN_0013 - NO2.multitemp$EN_0001
cld <- colorRampPalette(c('blue','white','red'))(100) # 
plot(dif, col=cld)

#quantitative estimate

boxplot(NO2.multitemp)

boxplot(NO2.multitemp, outline=F)

boxplot(NO2.multitemp, outline=F,horizontal=T)

boxplot(NO2.multitemp, outline=F,horizontal=T,axes=T)

dev.off()

boxplot(NO2.multitemp, outline=F,horizontal=T,axes=T)

plot(NO2.multitemp$EN_0001, NO2.multitemp$EN_0013)

abline(0,1,col="red")

#let's take back the snow data

setwd("C:/snow/")

rlist <- list.files(pattern="snow")

 
rlist

import <- lapply(rlist, raster)

 
snow.multitemp <- stack(import)

plot(snow.multitemp$snow2010r, snow.multitemp$snow2020r)

abline(0,1, col="red")

plot(snow.multitemp$snow2000r, snow.multitemp$snow2020r)

abline(0,1,col="red")









