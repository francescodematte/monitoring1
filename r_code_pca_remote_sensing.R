setwd("C:/lab/")

library(raster)
library(RStoolbox)

p224r63_2011 <- brick("p224r63_2011_masked.grd")

plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")

p224r63_1988 <- brick("p224r63_1988_masked.grd")
 
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")

par(mfrow=c(1,2))

plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")

names(p224r63_2011)  #to see the name of variables

plot(p224r63_2011$B1_sre, p224r63_2011$B3_sre)           #to see if bends 1 and 3 (blu and red) are correlated to each other

p224r63_2011_res <- aggregate(p224r63_2011, fact=10)     #decrease the resolution, since there are millions of pixels

p224r63_2011_pca <- rasterPCA(p224r63_2011_res)         #toolbox is needed to provide this PCA function
 
plot(p224r63_2011_pca$map)
 
 cl <- colorRampPalette(c('dark grey','grey','light grey'))(100) 

plot(p224r63_2011_pca$map, col=cl)

summary(p224r63_2011_pca$model)                          #importance of components (PC1 account for more than 99% of variation)

pairs(p224r63_2011)

plotRGB(p224r63_2011_pca$map, r=1, g=2, b=3, stretch="Lin")
 
p224r63_1988_res <- aggregate(p224r63_1988, fact=10)      #1988

p224r63_1988_pca <- rasterPCA(p224r63_1988_res) 

plot(p224r63_1988_pca$map, col=cl) 

summary(p224r63_1988_pca$model)

#difference in those 23 years
    
pairs(p224r63_1988)

difpca <- p224r63_2011_pca$map - p224r63_1988_pca$map

plot(difpca)

cldif <- colorRampPalette(c('blue','black','yellow'))(100) #

plot(difpca$PC1,col=cldif)
 
 


 


 
