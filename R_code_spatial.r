# R code for spatial view of points
library(sp)

data(meuse)

head(meuse)

#coordinates
coordinates(meuse) = ~x+y

plot(meuse)

spplot(meuse,"zinc")

# First exercise:plot the spatial amount of copper

spplot(meuse,"copper")

spplot(meuse,"copper", main="Copper concentration")

bubble(meuse, "zinc", main="Zinc concentration")

#bubble copper in red

bubble(meuse,"copper",main="Copper concentration", col="red")

#Importing new data

#download Covid_agg from our teaching site and build a folder called lab into C

#setting the working directory:lab
#Windows: setwd("C:/lab/")

covid <- read.table ("covid_agg.csv", head= TRUE)

head(covid)

attach(covid)
plot(country,cases)

plot(country,cases,las=0) #parallel labels=las
plot(country, cases,las=1)
plot(country, cases,las=2)
plot(country, cases,las=3)
plot(country, cases,las=3, cex.axis=0.5)
plot(country, cases,las=3, cex.axis=0.7)

install.packages("ggplot2")

library(ggplot2)  #usefull to check the if the packages have been installed
q() #that is the command to save a file


setwd("C:/lab/")

load("R_code_spatial.RData")

ls()

library(ggplot2)  #checking if ggplot have already been installed

data(mpg)
head(mpg)

#remember the key components: data,aes, geom

ggplot(mpg,aes(x=displ, y=hwy))+geom_point()
ggplot(mpg,aes(x=displ, y=hwy))+geom_line()
ggplot(mpg,aes(x=displ, y=hwy))+geom_polygon()

head(covid)

ggplot(covid,aes(x=lon, y=lat, size=cases))+geom_point()

setwd("C:/lab/")

load("point_pattern.RData")

ls()

#covids:point pattern
#d:density map

library(spatstat)

plot(d)

points(covids)

library(rgdal)
#let s input vector lines
coastlines <- readOGR("ne_10m_coastline.shp")

cl <- colorRampPalette(c("yellow","orange","red")) (100)
plot(d, col=cl)
points(covids)
plot(coastlines, add=T)

EX:new colour ramp palette

cl <- colorRampPalette(c("light green","yellow","orange")) (100)
plot(d, col=cl)
points(covids)
plot(coastlines, add=T)

cl <- colorRampPalette(c("light blue","yellow","orange")) (100)
plot(d, col=cl, main= "Densities of Covid-19")   #here the title is changed with the command "main"
points(covids)
plot(coastlines, add=T)

pdf("covid_density.pdf")
clr <- colorRampPalette(c("light green", "yellow","orange","violet")) (100)
plot(d, col=clr, main="Densities of covid-19")
points(covids)
plot(coastlines, add=T)
dev.off()   #exported in lab as a pdf file
