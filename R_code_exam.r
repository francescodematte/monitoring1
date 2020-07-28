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


#11_faPAR10.r#################################################################################
####################################################################################


setwd("C:/lab/") 

#the original faPAR from Copernicus has a dimension of 2 GB, let's see how smaller is the file faPAR10
load("faPAR.RData")

ls()       #ls() function to list the datasets we have


library (raster)
library (rasterdiv)

#we use writeRaster() function to write a file
#.tif file is an image saved in a high-quality graphics format. It is often used for storing images with many colors, typically digital photos, and includes support for layers and multiple pages
writeRaster(copNDVI, "copNDVI.tif")

###exercise###
library(rasterVis)

levelplot(faPAR10)

###regression model between faPAR and NDVI###
#we start with 2 variables: erosion of soil (kg / m2) and heavy metals (ppm)
erosion <- c(12, 14, 16, 24, 26, 40, 55, 67)
hm <- c(30, 100, 150, 200, 260, 340, 460, 600)

#let's plot the two variables. pch (point character)= is the simbol, depends on the number we assign it ( the lists are online)
plot(erosion, hm, col="red", pch=19, xlab="erosion", ylab="heavy metals", cex=2)
#we assign to the vector model1 the linear model of the relation between the two variables through the function lm()
model1 <- lm(hm ~ erosion) 
summary(model1)
#y=bx+a, a is the intercept, y is hm, x is erosion, b is the slope)
#R-squared is higher when the relation between the variables is higher (far from being random)
#p-values means there are no real relationship between variables. The probability  "p<0.01" means that there's a probability lower than one over hundred times that we re observing a merely random phenomenon
#abline() function can be used to add vertical, horizontal or regression lines to a graph
abline (model1)



setwd("C:/lab/")

library(raster)
library(rasterVis)

faPAR10 <- raster("C:/lab/faPAR10.tif")
plot(faPAR10)
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA), right=TRUE)
library(sf) # to call st_* functions
random.points <- function(x,n)
{
lin <- rasterToContour(is.na(x))
pol <- as(st_union(st_polygonize(st_as_sf(lin))), 'Spatial') # st_union to dissolve geometries
pts <- spsample(pol[1,], n, type = 'random')
}
pts <- random.points(faPAR10,1000)

copNDVIp <- extract(copNDVI,pts)
faPAR10p <- extract(faPAR10,pts)

#photosynthesys vs biomass
model2 <- lm(faPAR10p ~ copNDVIp)

plot(copNDVIp, faPAR10p, col="green", xlab="biomass", ylab="photosynthesis")
abline(model2, col="red")
plot(copNDVIp,faPAR10p)


#12R_code_EBVs.r#################################################################################
####################################################################################
### diversity measurement

setwd("C:/lab/") 

install.packages("RStoolbox")
library(raster)

library(RStoolbox) # this is for PCA

sntpca <- rasterPCA(snt)   #PCA 

#to import the image we use the brick() function 
snt <- brick("snt_r10.tif")

plot(snt)
#B1 blue
#B2 green
#B3 red
#B4 NIR

#R3 G2 B1
# as human eye would see it
plotRGB(snt,3,2,1, stretch="lin")

#let's use the near infra red on top of red component
plotRGB(snt,4,3,2, stretch="lin")
#since vegetation is highly reflecting in NIR, we have the vegetation coloured in red

#pairs() function produce a matrix of scatterplots
pairs(snt)
summary(sntpca$model) #Summary (or descriptive) statistics are the first figures used to represent nearly every dataset

plot(sntpca$map)

plotRGB(sntpca$map, 1, 2, 3, stretch="lin")

#matrix() function creates a matrix from the given set of values

window <- matrix(1, nrow = 5, ncol = 5)
#focal() function uses values in a neighborhood of cells around a focal cell, and computes a mean value that is stored in the focal cell of the output RasterLayer (in this case the standard deviation)
sd_snt <- focal(sntpca$map$PC1, w=window, fun=sd)
cl <- colorRampPalette(c('dark blue','green','yellow','purple'))(100) # 
plot(sd_snt, col=cl)
#we can then show the two plots in 1 line 2 columns on the same graphic image through:
par(mfrow=c(1,2))

plotRGB(snt,4,3,2, stretch="lin")

plot(sd_snt, col=cl)


###day 2:cladonia

setwd("C:/lab/")

library(raster)

clad <- brick("cladonia_stellaris_calaita.JPG")

plotRGB(clad, 1,2,3, stretch="lin")
#window to select one window, calculate the sd (standard deviation) and report the sd in one pixel, then the whole window is gradually shifted and reports the sd in the pixel next to the other and so on
#number 1 is an arbitrary value.
window <- matrix(1, nrow = 3, ncol = 3)
window
#after having selected the size of the window, we do the calculation
#again, we use focal function that calculate the values of several focal cells
#the clads are related (one line connect them) 
pairs(clad)


#PCA = Principal component analysis (PCA) is a technique for reducing the dimensionality of such datasets, increasing interpretability while minimizing information loss. 

library(RStoolbox)


cladpca <- rasterPCA(clad)

summary(cladpca$model)    #we can use cladpca as vector

#inside cladpca there's a map with PC1, PC2, PC3
plotRGB(cladpca$map, 1, 2, 3, stretch="lin")

sd_clad <- focal(cladpca$map$PC1, w=window, fun=sd)

PC1_agg <- aggregate(cladpca$map$PC1, fact=10)   #we aggregate to reduce the size of the layer PC1 to accelerate the calculation of the standard deviation
sd_clad_agg <- focal(PC1_agg, w=window, fun=sd)

#we try now to make it more evident

#we plot both the diversity of the original one, and the diversity on the aggregated pc1

par(mfrow=c(1,2))   #for not aggregated measure and aggregated one,respectively
cl <- colorRampPalette(c('yellow','violet','black'))(100) #
plot(sd_clad, col=cl)
plot(sd_clad_agg, col=cl)

#in this way we can instead see the plot of the variation in structure and the original image

par(mfrow=c(1,2))
cl <- colorRampPalette(c('yellow','violet','black'))(100) #
plotRGB(clad, 1,2,3, stretch="lin")
plot(sd_clad, col=cl)
# plot(sd_clad_agg, col=cl)



#13_R_code_snow.r#################################################################################
####################################################################################
# R_code_snow.r

#1st set the working directory to the folder snow 
#we create another folder in C, outside the folder lab, because we will use the function lapply() to search files that comprehend the name within that folder.
#in this case we don't have other files named snow but it's better to always mind about this
setwd("C:/snow/")

#we will use raster library and ncdf4(interface with netcdf data, some sort of .tif). Since most of the copernicus are based on nCDF we need to import this library 

install.packages("ncdf4")

library(ncdf4)  #we can now recall the library
library(raster)

#we import our file and name it snowmay
snowmay <-raster("c_gls_SCE_202005280000_NHEMI_VIIRS_V1.0.1.nc")
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 


#### Exercise: plot snow cover with the cl palette ####
plot(snowmay,col=cl)

#one simple but very slow manner to import the set is: raster("snow2000r.tif") and associate it to the vector snow2000 and so on for every year
snow2000 <- raster("snow2000r.tif")
snow2005 <- raster("snow2005r.tif")
snow2010 <- raster("snow2010r.tif")
snow2015 <- raster("snow2015r.tif")
snow2020 <- raster("snow2020r.tif")

#we can at this point use the par

par(mfrow=c(2,3)) #we cannot do 1,5 because it's too many graphs in one row)
plot(snow2000,col=cl)
plot(snow2005,col=cl)
plot(snow2010,col=cl)
plot(snow2015,col=cl)
plot(snow2020,col=cl)
#this is one of the ways to import the graphs but implies many lines of code to be written!

#the next function gives us a much a quicker way to import all the images

# lapply() is useful to apply a function to a list of vectors
#first of all we need to make the list of files that we want to use
#the function is list.files, it will only make the list of all the files with a certain shared pattern in a certain place
#in our case our files all include snow20 in the name
rlist <- list.files(pattern="snow20")
#than just write rlist to see the files within it

#we can now make the stack function to connect the images on layers
import <- lapply(rlist,raster)
snow.multitemp <- stack(import)

#launch snow.multitemp to see the object
#at this point we can plot the whole vector snow.multitemp with the col=cl
plot(snow.multitemp, col=cl)
 

#we can now operate applying a linear regression to see the tendency of the reduction of snow during the years and predict the value for 2025

####prediction####

require(raster)   #command very similar to library
require(rgdal)

# define the extent: 180=extent of data, 90=extent of latitude
ext <- c(-180, 180, -90, 90)
extension <- crop(snow.multitemp, ext)
    
# make a time variable (to be used in regression)
time <- 1:nlayers(snow.multitemp)

# run the regression
fun <- function(x) {if (is.na(x[1])){ NA } else {lm(x ~ time)$coefficients[2] }} 
predicted.snow.2025 <- calc(extension, fun) # this calculation is quite time consuming
predicted.snow.2025.norm <- predicted.snow.2025*255/53.90828
#255 because 8bit means 2 elevated8 -> 256 different informations (interval between 0 and 255)
###############################################
#we take all the previous prediction saving the file prediction.r in the folder snow, launching the code source("prediction.r")
source("prediction.r")

#save raster into list with lapply

list_rast <- lapply(rlist, raster)
snow.multitemp <- stack(list_rast)
plot(snow.multitemp,col=cl)

par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl)
plot(snow.multitemp$snow2020r, col=cl)

par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl, zlim=c(0,250))   #zlim=	the minimum and maximum z values for which colors should be plotted, defaulting to the range of the finite values of z
plot(snow.multitemp$snow2020r, col=cl, zlim=c(0,250))

difsnow = snow.multitemp$snow2020r - snow.multitemp$snow2000r
cldiff <- colorRampPalette(c('blue','white','red'))(100) 
plot(difsnow, col=cldiff)

# prediction
# go to IOL and downloand prediction.r into the folder snow
# source("prediction.r")
# plot(predicted.snow.2025.norm, col=cl)
# since the code needs time, you can download predicted.snow.2025.norm.tif from iol in the Data

predicted.snow.2025.norm <- raster("predicted.snow.2025.norm.tif")
plot(predicted.snow.2025.norm, col=cl)



#14_R_code_no2.r#################################################################################
####################################################################################
#R_code_no2.r

#exercise on the reduction of no2 due to the lockdown, during the covid19 emergency

#set the working directory (folder no2, inside lab folder)
setwd("C:/lab/no2") 

#we can import again the data through the lapply(). Recall that this function applies a certain function to a list of files

#we need to create a list of files we will identify trough a shared pattern
rlist <- list.files(pattern="EN_00")

#we can now use the stack function to connect the images on layers.To do this we need the library(raster)
library(raster)
import <- lapply(rlist,raster)
EN <- stack(import)

cl <- colorRampPalette(c('blue','salmon','light green'))(100)
plot(EN, col=cl) #the data come from ESA sentinel


par(mfrow=c(1,2))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

#let's try to make use of RGB
#B1 blue
#B2 green
#B3 red
#B4 NIR
plotRGB(EN, r=1, g=7, b=13, stretch="lin")
#if we have red values we have high values in the first image
#if we have blue values we have high values in the last image (13)
#if we have gren values we have high values in the mid period
#yellow in italy is a sum.. we had presence during the whole time

# close the window

#difference map (last vs first)
#last and first are not the best images to be compared, but still interesting
dif<- EN$EN_0013 - EN$EN_0001
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(dif, col=cld)


#let's see the boxplot() function ( it elaborates box and whisker (the lines) of some given data)
boxplot(EN)
boxplot(EN, outline=F)
boxplot(EN,horizontal=T,outline=F)
boxplot(EN,horizontal=T,axes=T,outline=F)   #final boxplot

#we can plot the data of first and last image
#if you put the first image(January) in the x and last (March) in the y you should highlight a decrease
#most of the high values should be under the line 1:1 (bisector of the first quadrant, or y=x)
plot(EN$EN_0001, EN$EN_0013)

abline(0,1, col="red")  #we can draw the bisector with the command abline


#15_R_crop_an_image.r#################################################################################
####################################################################################
setwd("C:/lab/")

install.packages("ncdf4")

library(raster)
library(ncdf4)

snow <- raster("c_gls_SCE_202005280000_NHEMI_VIIRS_V1.0.1.nc")
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100)

ext <- c(0, 20, 35, 50)  #coordinates
zoom(snow, ext=ext)

#let's crop the image
snowitaly <- crop(snow, ext)

#you can also use drawextent
zoom(snow, ext=drawExtent())


#16R_code_interpolation.r#################################################################################
####################################################################################
#interpolation: using data that we measured in the field (Martina Viti bachelor' thesis)
setwd("C:/lab/") 

install.packages("spatstat")


library(spatstat) #for interpolation

#we are going to import the data. It is just a table (no raster, no brick are needed)
# ; means the separator will be a semi-column, each column has an header so is TRUE
inp <- read.table("dati_plot55_LAST3.csv", sep=";", head=T)

#let's proceed estimating the rest of the canopy cover where there's no data
#attach is to start working with the dataset
attach(inp)
plot(X,Y)

#to know minimum and maximum of X and Y
summary(inp)
#with ppp() function we are going to establish what X, Y correspond to and then what is their range
inppp <- ppp(x=X,y=Y,c(716000,718000),c(4859000,4861000))

#we can proceed using it to estimate the canopy cover, but we first use marks() function to lable the single point with the data we want
#we put into the inppp the canopy cover (how is it called? function names(inp) to know it)
names(inp)
marks(inppp) <- Canopy.cov

#we don't need to use $ to select the column because we attached the file
#Smooth() function is from library(spatstat). Allows us to interpolate data where we don't have it.
#it calculates the values in between two given points and then the one between the one created and the one given and so on.
canopy <- Smooth(inppp)
plot(canopy)
points(inppp, col="green")

#we can measure the lichens on the tree and see how much tree's surface they cover
marks(inppp) <- cop.lich.mean
lichs <- Smooth(inppp)
plot(lichs)
points(inppp)

#we make use of the par function to show our plots in one image
par(mfrow=c(1,3))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)

#we can also make a final plot
plot(Canopy.cov, cop.lich.mean, col="red", pch=19, cex=2)

######

# Data psammophilus species (Giacomino)
#psammophilus means that are adapted to arid environments (dell'ambiente dunale e retrodunale)
#as before we have a file that is just a table (no need to use raster or brick)
inp.psam <- read.table("dati_psammofile.csv", sep=";", head=T)

attach(inp.psam)

head(inp.psam)
summary(inp.psam)    #C.org is the amount of carbon. the higher it is the higher the amount of organisms

#let's see the point in space through this function 
plot(E,N)

#spatstat doesn't work well with spaces between different groups of data (if some sampling are far from each other)

#the range of different points x=east and y=north.
#to know the range summary(inp.psam.) we use a bit of a larger area
inp.psam.ppp <- ppp(x=E,y=N,c(356450,372240),c(5059800,5064150))

#the second step is to explain the variable we are going to use.

#marks() function to lable the single point with the data we want
marks(inp.psam.ppp) <- C_org

#once again Smooth() function to calculate the means between points
C <- Smooth(inp.psam.ppp)
plot(C)
points(inp.psam.ppp)

#this is the idea to implement measured data to other parts where no samples were collected
