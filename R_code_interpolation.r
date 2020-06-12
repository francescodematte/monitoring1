R_code_interpolation.r

setwd("C:/lab/")

#since the data we need are just a table we do not need raster library

library(spatstat)   #previously installed to calculate plot's densities

inp <- read.table("dati_plot55_LAST3.csv", sep=";", head=T)


#fagus sylvatica forest= extremely high canopy cover (very shady environment)

head(inp)

attach(inp)  #R now knows we're working with  this dataset, we do not need $ simbol to work with different part of the dataset

#dataset was prevously restricted to the North-East area to better realise the interpolation

plot(X,Y)

summary(inp)

#ppp() = planar point pattern function
inppp <- ppp(x=X, y=Y, c(716000,718000),c(4859000,4861000))

#get the name of canopy cover by the func. names()
marks(inppp) <- Canopy.cov

canopy <- Smooth(inppp) #list sware regression = the distance betw each point and the regression line

plot(canopy)

points(inppp, col="green")

#the higher is the amount of lichens the higher is air quality

marks(inppp) <- cop.lich.mean

lichs <- Smooth(inppp)

plot(lichs)

points(inppp)

#the graph will show that there is no congruence between lichens and canopy cover

output <- stack(canopy,lichs)

plot(lichs)

par(mfrow=c(1,2))

plot(canopy)

points(inppp)

plot(lichs)

points(inppp)

#it seems there is a negative correlation between lichens and canopy cover, but this relationship depends actually on some points only

par(mfrow=c(1,3))

plot(canopy)

points(inppp)

plot(lichs)

points(inppp)

plot(Canopy.cov, cop.lich.mean, col="red", pch=19, cex=2)

# now let's work with psammophilous vegetation

inp.psam <- read.table("dati_psammofile.csv", sep=";", head=T)

attach(inp.psam)

summary(inp.psam)

head(inp.psam)

plot(E,N)

#with clumped data spatstat could have problems in calculating the values related to "voids". First of all explain to spatstat that you have points with coordinates (ppp function)

summary(inp.psam)

inp.psam.ppp <- ppp(X=E ,Y=N ,c(356450,372240),c(5059800,5064150))

marks(inp.psam.ppp) <- C_org   #we re going to calc org C in the points where we have no measures

C <- Smooth(inp.psam.ppp)

plot(C)

points(inp.psam.ppp)
 





 
 

 


 







