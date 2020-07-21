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

