#R_code_exam.r

#the function install.packages is used to install something from outside (present in the CRAN) with the use of " " (something which is not previuosly known by the system)
install.packages("sp")
#sp is a package for spatial data
#library is to start using the data present in the package. This command is necessary to recall our installed packages in each individual study we perform. It is like we had a book in our library, we own that book but we have to search for it every time we need it. 
library(sp)
#meuse is a dataset comprising of four heavy metals measured in the top soil in a flood plain along the river Meuse
data(meuse)

#let's see how the dataset meuse is structured, writing the name only some infos will appear in r
meuse

#lets's look at the first six rows of the set with the function head( )
head(meuse)

#let's plot two variables:
#let's see if the concentration of the zinc is related to copper's one
#the function attach () links the dataset to the r search path, so calling the name of an element we can have the related infos
attach(meuse)
#the function plot( ) is the most general and used function for plotting dataset
plot(zinc,copper)
#col is used to change the colour 
plot(zinc,copper,col="green")
#pch is used to change the symbol (different point shapes available in r)
plot(zinc,copper,col="green",pch=19)
#cex is used to change the size of the symbol (the amount by which plotting text and symbols should be scaled relative to the default)
plot(zinc,copper,col="green",pch=19,cex=2)




########################################
#########################################
########################################


#2_R_code_multipanel.r##################################################################################
####################################################################################
###Multipanel in R. 

#sp is a package for spatial data
install.packages("sp")
#GGally is a package that extends 'ggplot2' by adding several functions to reduce the complexity of combining geometric objects with transformed data.
install.packages("GGally")
#library( ) function is to be able to start using the functions 
library(sp)  #the same function is given by require()
library(GGally)
#meuse is provided by package sp. It is a data set comprising of four heavy metals measured in the top soil in a flood plain along the river Meuse (a river flowing trough France, Belgium and Netherland, through cities like Maastricht, Liegi and Rotterdam)
#data( ) allow users to load datasets to then work on them in the workspace
data(meuse)
#attach( ) is to connect the dataset to the r search path
attach(meuse)

#EXERCISE: see the name of the variables and plot cadmium and zinc
meuse
plot(cadmium,zinc)

#There are 2 ways to see the names of the variable
#names( ) is used to see the names of the different variables
names(meuse)
#head( ) is used to see the first six rows of the dataset
head(meuse)
#pch=a number, to change the character
#col to change the colour
#cex to change the size of the character
plot(cadmium,zinc,pch=15,col="red",cex=2)

#Exercise: make all the paiwise possible plots of the dataset)
#plot(x,cadmium)
#plot(x,zinc)
#plot,...
# plot is definitely NOT a good idea!

#the function pairs( ) produces a matrix of scatterplots
pairs(meuse)

#code to switch from the whole dataset to the 4 variables
pairs( cadmium + copper + lead + zinc, data=meuse)

pairs(meuse[,3:6])

#Exercise:prettify the graph changing the character, colour and size of points
pairs(meuse[,3:6], pch=11, col="green", cex=0.7)


#ggpairs( ) is a GGally package with prettyfied graphs
ggpairs(meuse[,3:6])


#3_R_code_spatial.r##################################################################################
####################################################################################
#R Code for spatial view of points
#we don't need to install the package because we've already done it, we just need to recall it through the function library( )
library(sp)    

data(meuse)     

head(meuse)     


#the function coordinates( ) says to R that the coordinates of the dataset "meuse" are x and y
coordinates(meuse) = x+y      
plot(meuse)
#spplot() is within lattice  plot methods for spatial data (multivariate correlations)
spplot(meuse, "zinc")    #to relate just to 1 variable and its legenda.

#Exercise: plot the spatial amount of copper
spplot(meuse, "copper")

#to change the title we refer to the parameter "main":
spplot(meuse, "copper", main="copper concentration")

#the function bubble() boosts the size of points
bubble(meuse, "zinc")
bubble(meuse, "zinc", main="Zinc concentration")

###Exercise: bubble copper in red
bubble(meuse, "copper", col="red", main= "Copper concentration")


####Importing new data

#download file covid_agg.csv from our teaching site and put it into folder lab (no capital letters)

#setting the working directory (where data is coming from and going to)
#for windows setwd("C:/lab/")
setwd("C:/lab/")
#the function read.table("covid_agg.csv", head=T) is to open and read the file, with "" because importing a file from outside R
# <- is to assign the file to a vector. In this way we assign the file the name we want. From that moment on R will recognise it by that name 
covid <- read.table("covid_agg.csv", head=T)  #where head=T or head=TRUE is when we have a first row with no numbers
#head of our new vector indicates the first 6 rows of the file
head(covid)  #to show the first 6 rows
#attach is once again used to access objects in the database by simply writing their names
attach(covid)
#ls() is the function to check which files are uploaded
ls() 

###Using ggplo2###
library(ggplot2) #requireto have already install.packages("ggplot2")
#mpg is a dataset that contains a subset of the fuel economy data that the EPA
data(mpg) #to access to it
head(mpg) #to see the first 5 lines
#key components: data, aes, geometry
#data in this case is mpg, we close both the () after x and y cuz the geometry is by itself apart
ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()

plot(country, cases)  #where country and cases are respectively x and y coordinates

#we cannot see all the countries so we need to change the orientation by reversing x and y
#las=orientation of labels or any other added text, numeric value
plot(country, cases, las=0)  #parallel labels
plot(country, cases, las=1)  #all the labels horizontal
plot(country, cases, las=2)  #perpendicular labels
plot(country, cases, las=3)  #vertical labels

#we can reduce the size of the x axis labels using cex.axis and to assign a value lower than 1
plot(country, cases, las=3, cex.axis=0.5)

#ggplot2 package
install.packages("ggplot2")
library(ggplot2)  #or function require(ggplot2). in both cases we start to make use of the package

#####save theworkspace as .RData under the menu file#####

#####Load the previous data with double click on the file in the lab folder
#Open r and set  the working directory (where data is coming from and going to)
setwd("C:/lab/") 
#load the previous RData
load("covid_.RData")
ggplot(mpg, aes(x=displ, y=hwy)) + geom_line()
ggplot(mpg, aes(x=displ, y=hwy)) + geom_polygon()

#let's look at the covid data that we have already uploaded
head(covid)
#we will exagerate the size as a function of the number of cases
ggplot(covid, aes(x=lon,y=lat, size=cases)) + geom_point()

#4_R_code_multivariate##################################################################################
####################################################################################
###R code for multivariate analysis###

#Open R#
#set the working directory
setwd("C:/lab/")  
#The vegan package contains all common ordination methods, such as principal component analysis, correspondence analysis or detrended correspondence analysis 

install.packages("vegan")
library(vegan)

#"biomes" is the name that we assign to the data by the vector, read.table is to open and analyze the data, "biomes.csv" is the name of the file, head=T because the first row is words only, sep="," is the separator between the names of the words in the row
biomes<-read.table("biomes.csv",head=T,sep=",")

#to have a look at the dataset: head(biomes)or view(biomes)
head(biomes)

#multivariate analysis: decorana= detrended correspondence analysis
multivar<- decorana(biomes)

#we can then realise the plot of the multivariate analysis
plot(multivar)

#we are now seeing the graph from 1 point of view, but we can see it from others (thinks to the paintings of Dalì)
#if we just put multivar, we can see the results of the analysis
multivar
#eigenvalues= the percentage of data that we are able to see from a specific perspective
#we got DCA1=0.5117 DCA2=0.3036,  51%+30%=81%  (the total amount of variation we can perceive from this perspective)

#let's use other data to then sum up the same biomes
biomes_types <- read.table("biomes_types.csv", header=T, sep=",")
head(biomes_types)
attach(biomes_types)

#we make an ordiellipse that connects all the data. Multivar is the first name we gave.
ordiellipse(multivar,type, col=1:4, kind="ehull", lwd=3)
#we can put the color like this or col=c("green","orange","red","blue")

#to see the 'disk' of the biomes
ordispider(multivar, type, col=1:4, label = T)


#5_r_code_remote_sensing.r##################################################################################
####################################################################################
###R code for remote sensing analysis##
#set the working directory
setwd("C:/lab")

#raster is designed for reading, writing, manipulating, analyzing and modelling of spatial data (the format with pixels), (remeber the name, deriving from rastrum)
install.packages("raster")
#RStoolbox is a package for remote sensing image processing and analysis, such as calculating spectral indices, principal component transformation
install.packages("RStoolbox")

library(raster)
#the satelite runs through orbits called "paths" and covers the whole earth in 14-17 days.

#to import images, the function is brick (to import a package of bands with different reflectance of pixels)
# the file.grd = grid, network of images
p224r63_2011 <- brick("p224r63_2011_masked.grd")

#we use the function plot to make the plot of the uploaded image, we set the colours with the vector cl and realise the final plot with those colors, by using the raster function colorRampPalette
plot(p224r63_2011)
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
plot(p224r63_2011, col=cl)
 
#Bands of landsat
#B1: blue
#B2:green
#B3:red
#B4:NIR  #infrared  #it's the band where most of plants' reflectance is captured (also the percentage in green is quite high)

#multiframe of different plots
#par function is used to incorporate multiple graphs in a single plot
#mfrow stays for multiframe rows
par(mfrow=c(2,2))
#2,2 means that we will have 4 plots in total divided in 2 rows and 2 columns.
#we do this because we will make a graph with the 4 colour bands

##for each colour band we set the colour palette with different nuances and we plot the band (B1,B2,B3,B4) with those colours
#to do that and select the right band within the picture we use ‘$’.This simbol is used in this case to link a specific column to a specific data frame.
#B1:blue
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) 
plot(p224r63_2011$B1_sre, col=clb)                       

#B2
clg <- colorRampPalette(c('dark green','green','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clg)

#B3
clr <- colorRampPalette(c('dark red','red','salmon'))(100) 
plot(p224r63_2011$B3_sre, col=clr)

#B4
cln <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(p224r63_2011$B4_sre, col=cln)

#exercise: make a graph with 4 plots on one column
#4,1 means that there will be 4 lines and 1 column

par(mfrow=c(4,1))

#B1:blue
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) 
plot(p224r63_2011$B1_sre, col=clb)                        

#B2: with but with green (B2) 
clg <- colorRampPalette(c('dark green','green','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clg)

#B3: with but with red (B3) 
clr <- colorRampPalette(c('dark red','red','salmon'))(100) 
plot(p224r63_2011$B3_sre, col=clr)

#B4: with but with NIR (B4) 
cln <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(p224r63_2011$B4_sre, col=cln)



#plotting the 3 bands together and see the image the way human eye would see it...
#RGB (red green blue): B1: blue; B2:green; B3:red.
#stretch="Lin" stretch linear= to make the differetn colours gradually blur into each other
#every pixel is 30 km wide
#Bands of landsat
#B1: blue
#B2:green
#B3:red
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

# we always have to refer to three bands only. If we want to add the NIR band if we want to use the NIR we need to shift the components
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
#vegetation is becoming red, the pink part is mainly agricultural fields, white parts are open areas (deforestation, huge land changes)

#exercise: put NIR on top of g component of the RGB
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
#now the vegetation is in green, dark green is mainly given by the water in the forest (or high humidity) while pink is the bear soil (agriculture)

#exercise: put NIR on top on b component of the RGB
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
#this time the agricultural area is in yellow (extremely evident in this case)

###save workspace

###following lesson...

setwd("C:/lab/") 
#ls() is the list function to see which packages we have already installed in the server
ls()

library(raster)
#brick () function to create a multi-layered raster object. Image within brackets because importing it from the outside!  We assigned it a name that r will later recognise
p224r63_1988 <- brick("p224r63_1988_masked.grd")
plot(p224r63_1988)

#Exercise: plot in visible RGB  both images
#PlotRGB
#Bands of landsat
#B1: blue
#B2:green
#B3:red
#B4:NIR  #near infrared (wave lenght is longer than red but still shorter than infrared)

par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

#Exercise: RGB 432
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#How to better visualize the noise(due to evapotraspiration, humidity and clouds)present in the image?
#Stretching more the colours and means enhancing the noise...
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")   #histogram stretching, a mathematical tool to enhance contrast from different pixels
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

#PlotRGB
#Bands of landsat
#B1: blue
#B2:green
#B3:red:B3_sre
#B4:NIR  #infrared:B4_sre

#dvi=difference vegetation index  
dvi2011<- p224r63_2011$B4_sre - p224r63_2011$B3_sre
#colors() to see the colours
cl <- colorRampPalette(c('firebrick4','tomato2','olivedrab4'))(100) 
plot(dvi2011, col=cl)

#Exercise with dvi 1988
dvi1988<- p224r63_1988$B4_sre - p224r63_1988$B3_sre
#colors() to see the colours
cl <- colorRampPalette(c('firebrick4','lightsalmon1','darkolivegreen'))(100) 
plot(dvi1988, col=cl)

#Differences in time
diff <- dvi2011 - dvi1988
plot(diff)

#changing the grain(pixels)
#when you change the dimension of the pixels you talk about resampling (res)  #different grain size means different spatial resolution. At different spatial resolution the structure and properties of ecosystems can be seen differently, thus different info are provided 
#fact=10 means that we are increasing 10 times the size of each pixels. We want to decrease the resolution because there would be otherwise millions of pixels
p224r63_2011res10<-aggregate(p224r63_2011, fact=10) 
p224r63_2011res100<-aggregate(p224r63_2011, fact=100)

#Exercise: same image -> original, x10, x100
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res10, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch="Lin")

#6_densitymap_point_pattern_analysis.r##################################################################################
####################################################################################
#Point Pattern Analysis: density map

#install the package to analyse the spatial point patterns that we need to develop our study
install.packages("spatstat")
library(spatstat)

attach(covid)
head(covid)

# ppp=power point pattern, x=long, y=lat
covids<- ppp(lon, lat, c(-180,180), c(-90,90))   #c(..) is needed to take all this values together
#let's associate to the vector d the density of the covids data we' ve just created

d<- density(covids)

#then  we create a density plot...

plot(d)

#and we add the density to the plot, adding details  to this function. Do not close the plot window or the remaining will be deleted

points(covids)


setwd("C:/lab/") 
load("point_pattern.RData")
ls("point_pattern.RData")  
#covids:point pattern
#d: density map

library(spatstat)

plot(d)

#we can put on this map the points of the covid
points(covids)

#download coastlines.zip file from IOL and copy all the files into the lab folder
#rgdal package provides bindings to the 'Geospatial' Data Abstraction Library 
install.packages("rgdal")
library(rgdal)


#read0GR within rgdal is a function that reads an OGR data source and layer into a suitable Spatial vector object
coastlines<-readOGR("ne_10m_coastline.shp")

plot(d)
points(covids)
plot(coastlines, add=T)  #we put add, thereby preventing the precedent results from being erased 

#change the colours and prettify the graph#
#100 means that there are 100 colours from yellow spectrum to red one
cl<-colorRampPalette(c("yellow","orange","red"))(100)  
plot(d,col=cl)
points(covids)
plot(coastlines, add=T)

#another try
clr<-colorRampPalette(c("light blue","yellow", "orange"," light pink"))(100)  
plot(d,col=clr, main="Covid19 distribution")    #main= it adds the text for the main title
points(covids)
plot(coastlines, add=T)

#to export it as a pdf file
pdf("covid_density.pdf")
clr<-colorRampPalette(c("light blue","yellow", "orange","light pink"))(100)  
plot(d,col=clr, main="Covid19 density")
points(covids)
plot(coastlines, add=T)
dev.off()

#7_R_code_ecosystem_functioning##################################################################################
####################################################################################
#R code to view biomass over the world and calculate changes in ecosystem functioning

#energy
#nutrient cycle
#proxies

#rasterdiv() function is very useful to calculate indices of diversity on numerical matrices based on information theory.
install.packages("rasterdiv")
#rasterVis() function comprehend methods for enhanced visualization and interaction with raster data
install.packages("rasterVis")

library(rasterVis)
library(rasterdiv)
#the input dataset is the Copernicus Long-term (1999-2017) average Normalise Difference Vegetation Index (copNDVI)
data(copNDVI)
plot(copNDVI)

#reclassify is a function that (re)classifies groups of values to other values
#cbind is in this case used to remove some data from the library that is not useful for us (and they are classified as NA)

copNDVI<- reclassify(copNDVI, cbind(253:255,NA), right=TRUE)

#that could be an impressive function to flabbergast your supervisor!
levelplot(copNDVI)
#highlights the mean biomass over the last 20 years

#fact=10 (factor of 10) means, again, aggregating 10 pixels in 1, so the new image has much visible boundaries beetween colours
#the number of pixel has to be selected with regard to the object of our investigation, if it is possible to have less pixels with the same analytical power it's of course better (the file will be smaller in size)
copNDVI10<- aggregate (copNDVI,fact=10)
levelplot(copNDVI10)

#let's try 100x100 pixels in one
copNDVI100<- aggregate (copNDVI,fact=100)
levelplot(copNDVI100)

#working on images dealing with the deforestation which is since decades occurring in the Amazon forest
setwd("C:/lab/")  
library(raster)
#uploading the two different images, brick() function to create a RasterBrick (multi_layered image)
defor1 <- brick("defor1_.jpg")
defor2 <- brick("defor2_.jpg")

#band1: NIR
#band2: red
#band3: green
#making the plot of the two images separately, selecting the bands, stretch to make a better shading effect
plotRGB(defor1, r=1, g=2,b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#to see the two images one next to the other we use the par() function with multiframe by rows 
par(mfrow=c(1,2))  #here we needed 1 line and 2 columns
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#if you write defor1 on R you look at the names that correspond to the 3 bands
#names: defor1_.1,  defor1_.2,  defor1_.3

#band1: NIR    defor1_.1
#band2: red    defor1_.2
#dvi=difference vegetation index. 
dvi1 <- defor1$defor1_.1 - defor1$defor1_.2  #the simbol $ allows us to select a band only from our multilayered image 
 
 
 #same for defor2
 #names      : defor2_.1, defor2_.2, defor2_.3 
 #band1: NIR    defor2_.1
 #band2: red     defor2_.2
 
 dvi2 <- defor2$defor2_.1 - defor2$defor2_.2

#we then create the palette with the colours we want to highlight the data with
cl <- colorRampPalette(c('darkpurple','yellow','red','black'))(100)

#to see the two images one next to the other we use the again par() function 
par(mfrow=c(1,2))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

difdvi<- dvi1 - dvi2

dev.off() #to close what we opened before
cld <- colorRampPalette(c('darkblue','white','red'))(100) 
plot(difdvi, col=cld)
#hist() function computes a histogram of the given data values
hist(difdvi)


#8_r_code_pca_remote_sensing.R.##################################################################################
####################################################################################
setwd("C:/lab/") 


library(raster)
library(RStoolbox)
library(ggplot2)

# raster function "brick" to import images (multi-layer file, because of superimposed bands)
p224r63_2011 <- brick("p224r63_2011_masked.grd")

# plotRGB
#b1 blue
#b2 green
#b3 red
#b4 NIR
#b5 SWIR (short wave infrared)
#infrared has 3 parts: one close to red, one in other place, one as thermal infrared.
#b6 thermal infrar
#b7 SWIR
#b8 panchromatic

#RGB (2011's image):
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin") 
#ggRGB calculates RGB color composite raster for plotting with ggplot2
ggRGB(p224r63_2011,5,4,3)

#same for 1988's image
p224r63_1988 <- brick("p224r63_1988_masked.grd")
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin") 

#to  have a look to the two plots together we use again par() function (1 row 2 columns)
par(mfrow=c(1,2))
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin") 
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin") 
#the increase of the pink part is due to loss of forest, led by the increase in agricultural activity

#we want to plot all the bands to see all the information together
names(p224r63_2011)   #to know the names of the different bands in that file
#we are going, through $, to link the bands to the image
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre)

#p224r63_2011    #gives us the number of contained data, which is about 4 million, we need to decrease the size of the file since it's to heavy to work on it
#dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)

#decrease the resolution by a 10 factor -> res=resempling the resolution, fact=10 because we are decreasing it by a factor of 10
p224r63_2011_res <- aggregate(p224r63_2011, fact=10)

#library(RStoolbox) is now needed...
#rasterPCA function calculates R-mode PCA (Principal Component Analysis) for RasterBricks or RasterStacks and returns a RasterBrick with multiple layers of PCA scores
#PCA is useful to disentangle relationships among many variables (as found in a set of raster maps in a map list) and to reduce the amount of data needed to define the relationships
p224r63_2011_pca <- rasterPCA(p224r63_2011_res)

#plotting the map (again, $ simbol gives us a connection with a soecific component of the related file)
plot(p224r63_2011_pca$map)

#we set our colour palette and plot the 2011's map
cl <- colorRampPalette(c('dark grey','grey','light grey'))(100) # 
plot(p224r63_2011_pca$map, col=cl)

summary(p224r63_2011_pca$map, col=cl)  #is a generic function used to produce result summaries of the results of various model fitting functions

pairs(p224r63_2011)

plotRGB(p224r63_2011_pca$map, r=1, g=2, b=3, stretch="Lin")

#we do the same for 1988
p224r63_1988_res <- aggregate(p224r63_1988, fact=10)
p224r63_1988_pca <- rasterPCA(p224r63_1988_res) 
plot(p224r63_1988_pca$map, col=cl)
summary(p224r63_1988_pca$model)
pairs(p224r63_1988)

#operating then the difference to highlight the changes
difpca <- p224r63_2011_pca$map - p224r63_1988_pca$map
plot(difpca)

#final plot 
cldif <- colorRampPalette(c('lightblue','black','orange'))(100) # 
plot(difpca$PC1, col=cldif)

#9_R_code_faPAR.r##################################################################################
####################################################################################
#how to look at chemical features by satellite images

setwd("C:/lab/") 

library(raster)
library(rasterVis)
library(rasterdiv)

#we are going to use copNDVI (copernicus NDVI) 
#remember that plants dispaly high reflectance in NIR and low in red (and blue)
#no plants: lower NIR higher RED
#let's have a look to the Copernicus image by plotting it
plot(copNDVI)
#reclassify() function (re)classifies groups of values to other values
#cbind() function combines vector, matrix or data frame by columns

copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
levelplot(copNDVI)

#faPAR is the Fraction of Absorbed Photosynthetically Active Radiation ( = fraction of the solar radiation absorbed by live leaves to perfor photosynthesis)
faPAR10 <- raster("faPAR10.tif")  #raster to import the data. 10 because used a factor of 10 to aggregate the pixels
levelplot(faPAR10)
#we have less values on the northern side rather than equator because now we are taking into account the photosynthetic activity

#save the as pdf
pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off()

pdf("faPAR10.pdf")
levelplot(faPAR10)
dev.off()


#10_R_code_radiance.r#################################################################################
####################################################################################
#R_code_radiance.r


library(raster)

#we will create on our own the data to work on,so, we won't need to set the working directory to import data from outside r

#in general when we just want to have fun or make some practice we name our object "toy"
#we create a new raster with 2 columns and 2 rows
toy <- raster(ncol=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2)       #mn and mx= minimum and maximum values (related to x and y)
#values(toy) contains the data that we created, the c function is to insert more then one number
values(toy) <- c (1.08, 1.24, 1.23, 3.45)

#we can now plot(toy)
plot(toy)
#text() function is to add a title, digits() function is to indicate how many significant digits of numeric values to show
text(toy, digits=2)
#stretch() function provides the desired output range
toy2bits <- stretch(toy,minv=0,maxv=3)
#Both mode and storage.mode return a character string giving the (storage) mode of the object
storage.mode(toy2bits[]) = "integer"
plot(toy2bits)
text(toy2bits, digits=2)

#with 4bits
toy4bits <- stretch(toy,minv=0,maxv=15)
storage.mode(toy4bits[]) = "integer"
plot(toy4bits)
text(toy4bits, digits=2)

#with8
toy8bits <- stretch(toy,minv=0,maxv=255)
storage.mode(toy8bits[]) = "integer"
plot(toy8bits)
text(toy8bits, digits=2)

#to plot all of them one after the other
par(mfrow=c(1, 4))
plot(toy)
text(toy, digits=2)

plot(toy2bits)
text(toy2bits, digits=2)

plot(toy4bits)
text(toy4bits, digits=2)

plot(toy8bits)
text(toy8bits, digits=2)



