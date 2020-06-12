#how to model species distribution

install.packages("sdm")

library(sdm)

library(raster)  #predictors

library(rgdal)   #species

file <- system.file("external/species.shp", package="sdm")

species <- shapefile(file)

species

plot(species)
 
species

species$Occurrence

plot(species[species$Occurrence == 1,],col='blue',pch=16)  

points(species[species$Occurrence == 0,],col='red',pch=16)   #for absences, if you used again the f plot the occurences would have disappeared

path <- system.file("external", package="sdm")     #predictors (env variables)

lst <- list.files(path=path,pattern='asc$',full.names = T) #

preds <- stack(lst)

preds

cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

plot(preds$elevation, col=cl)

points(species[species$Occurrence == 1,], pch=16)
 
plot(preds$temperature, col=cl)

points(species[species$Occurrence == 1,], pch=16)     #brachipodium rupestre loves low elevation, high T, precipitation doesn't seem to be that influent

plot(preds$precipitation, col=cl)

points(species[species$Occurrence == 1,], pch=16)

plot(preds$vegetation, col=cl)

points(species[species$Occurrence == 1,], pch=16)

d <- sdmData(train=species, predictors=preds)

#model: y= a+b prec+ c elev+ d T+ e veget

m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=d, methods = "glm")

p1 <- predict(m1, newdata=preds)

plot(p1, col=cl)

points(species[species$Occurrence == 1,], pch=16)

s1 <- stack(preds,p1)

plot(s1, col=cl)


 
 



 

