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
