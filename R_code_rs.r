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
 

