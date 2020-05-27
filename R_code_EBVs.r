# install.packages("raster")
# install.packages("RStoolbox")
library(raster)
library(RStoolbox) # this is for PCA

# setwd("C:/lab/") # windows

snt <- brick("snt_r10.tif")

plot(snt)

# B1 blue
# B2 green
# B3 red
# B4 NIR

# R3 G2 B1
plotRGB(snt,3,2,1, stretch="lin") 
plotRGB(snt,4,3,2, stretch="lin") 

pairs(snt)

### PCA analysis
sntpca <- rasterPCA(snt)
sntpca

summary(sntpca$model)
# 70% of information
plot(sntpca$map) 

plotRGB(sntpca$map, 1, 2, 3, stretch="lin")

# set the moving window
window <- matrix(1, nrow = 5, ncol = 5)
window

sd_snt <- focal(sntpca$map$PC1, w=window, fun=sd)

cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) # 
plot(sd_snt, col=cl)

par(mfrow=c(1,2))
plotRGB(snt,4,3,2, stretch="lin", main="original image") 
plot(sd_snt, col=cl, main="diversity")

#let's work with Cladonia stellaris (making the same analysis made above)

setwd("C:/lab/")

#to import the file either raster or brick func. Brick-> multilayered image, better

library(raster)

clad <- brick("cladonia_stellaris_calaita.JPG")

plotRGB(clad, 1,2,3, stretch="lin")

window <- matrix(1, nrow = 3, ncol = 3)  # numb 1 is just an arbitrary value related to the movement of the window (calcultation is not impacted by choosing diff numbers

window

#focal function: to calculate values related to local cells through which the window is moved. Approfondisci

library(RStoolbox)

#PCA

cladpca <- rasterPCA(clad)

cladpca

sd_sntr <- focal(snt_r10$snt_r10.4, w=window, fun=sd)

plotRGB(cladpca$map, 1, 2, 3, stretch="lin")  # now you can much better focus elements like for example snow(in red)

window <- matrix(1, nrow = 5, ncol = 5)
window

sd_clad <- focal(cladpca$map$PC1, w=window, fun=sd)
 
#to make calculation of sd faster->
 
PC1_agg <- aggregate(cladpca$map$PC1, fact=10)

sd_clad_agg <- focal(PC1_agg, w=window, fun=sd)

par(mfrow=c(1,2))

cl <- colorRampPalette(c('light blue','orange',' dark violet'))(100) #

plot(sd_clad, col=cl)
plot(sd_clad_agg, col=cl)

# plot the calculation  and you can look at structural diversity of the lychen

par(mfrow=c(1,2))

cl <- colorRampPalette(c('yellow','violet','black'))(100) #

plot()
plotRGB(clad, 1,2,3, stretch="lin")

plot(sd_clad, col=cl)
# plot(sd_clad_agg, col=cl)

 
 
 






