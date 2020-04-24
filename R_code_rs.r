setwd("C:/lab/")

 install.packages("raster")

install.packages("RStoolbox")

# R code remote sensing



p224r63_2011 <- brick("p224r63_2011_masked.grd")

plot(p224r63_2011)

cl <- colorRampPalette(c('black','grey','light grey'))(100)

plot(p224r63_2011, col=cl)

#band of Landsat (B1 blue  b2 green b3  red  B3 nir)

#multiframe of different plots

 clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)  plot(p224r63_2011$B1_sre, col=clb)

par(mfrow=c(2,2))

#exercise: do the same for the green band

clg <- colorRampPalette(c('dark green','green','light green'))(100) 

plot(p224r63_2011$B2_sre, col=clg)

#then red and NIR

clr <- colorRampPalette(c('dark red','red','pink'))(100) 
plot(p224r63_2011$B3_sre, col=clr)

cln <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(p224r63_2011$B4_sre, col=cln)

#plot RGB

dev.off()
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")

plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")  #bare areas in yellow
 

setwd("~/lab/")
load("rs.RData")
ls()

library(raster)
p224r63_1988 <- brick("p224r63_1988_masked.grd")
plot(p224r63_1988)

#exercise: plot in RGB (1988/2011)

par(mfrow=c(2,1))


plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")

plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

#exercise: now remove the blue band and replace it with NIR one (false color)

par(mfrow=c(2,1))

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

#enhance the noise

par(mfrow=c(2,1))

plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

par(mfrow=c(2,1))

plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

dvi2011 <- p224r63_2011$B4_sre - p224r63_2011$B3_sre
cl <- colorRampPalette(c("darkorchid3",'light blue','lightpink4'))(100) 
plot(dvi2011)
 
#exercise:dvi in 1988

dvi1988 <-p224r63_1988 $B4_sre - p224r63_1988$B3_sre
cl <- colorRampPalette(c("darkorchid3",'light blue','lightpink4'))(100) 
plot(dvi1988)

#difference from one year to the other

diff <- dvi2011 - dvi1988
plot(diff)

#choosing a different grain (resampling)

p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100)

par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch="Lin")
 








