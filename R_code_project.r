setwd("C:/Exam/data")

library(raster)


rlist1<-list.files(pattern="201710")     #OTT 2017
rlist1                                   #checking the different bands composing the image and their features
import1<-lapply(rlist1,raster)
ott2017_bands<-stack(import1)
import1
plot(ott2017_bands)

#####

library(rgdal)
install.packages("gdalUtils")                #in order to create a shape file
library(gdalUtils)

vettore_shape<-readOGR("MonteVettoreShape.shp")
proj4string(ott2017_bands)
proj4string(vettore_shape)

myshape1<-spTransform(vettore_shape,proj4string(ott2017_bands))
ott2017_lens<-mask(crop(ott2017_bands,extent(myshape1)),myshape1)

######################

rlist2<-list.files(pattern="201711")
rlist2                                   
import2<-lapply(rlist2,raster)

B01<-resample(import2[[1]],import2[[5]])

B02<-resample(import2[[2]],import2[[5]])

B03<-resample(import2[[3]],import2[[5]])

B04<-resample(import2[[4]],import2[[5]])               #NOV 2017  ------->>>>resampling issue

B08<-resample(import2[[8]],import2[[5]])

B09<-resample(import2[[9]],import2[[5]])

B10<-resample(import2[[10]],import2[[5]])


              
             

nov2017_bands<-stack(B01,B02,B03,B04,import2[[5]],import2[[6]],import2[[7]],B08,B09,B10,import2[[11]],import2[[12]])

myshape2<-spTransform(vettore_shape,proj4string(nov2017_bands))
nov2017_lens<-mask(crop(nov2017_bands,extent(myshape2)),myshape2)


############################

rlist3<-list.files(pattern="201712")
rlist3                                   
import3<-lapply(rlist3,raster)                     #DIC 2017
dic2017_bands<-stack(import3)

myshape3<-spTransform(vettore_shape,proj4string(dic2017_bands))
dic2017_lens<-mask(crop(dic2017_bands,extent(myshape3)),myshape3)

#############################

rlist4<-list.files(pattern="202010")
rlist4                                   
import4<-lapply(rlist4,raster)                     # OTT 2020
ott2020_bands<-stack(import4)

myshape4<-spTransform(vettore_shape,proj4string(ott2020_bands))
ott2020_lens<-mask(crop(ott2020_bands,extent(myshape4)),myshape4)
############################

rlist5<-list.files(pattern="202011")
rlist5                                   
import5<-lapply(rlist5,raster)                     # OTT 2020
nov2020_bands<-stack(import5)

myshape5<-spTransform(vettore_shape,proj4string(nov2020_bands))
nov2020_lens<-mask(crop(nov2020_bands,extent(myshape5)),myshape5)

############################

rlist6<-list.files(pattern="202012")
rlist6                                   
import6<-lapply(rlist6,raster)

B01a<-resample(import6[[1]],import6[[5]])

B02a<-resample(import6[[2]],import6[[5]])

B03a<-resample(import6[[3]],import6[[5]])

B04a<-resample(import6[[4]],import6[[5]])                                                       #DIC 2020  ------->>>>resampling issue again

B08a<-resample(import6[[8]],import6[[5]])

B09a<-resample(import6[[9]],import6[[5]])

B10a<-resample(import6[[10]],import6[[5]])

dic2020_bands<-stack(B01a,B02a,B03a,B04a,import6[[5]],import6[[6]],import6[[7]],B08a,B09a,B10a,import6[[11]],import6[[12]])

myshape6<-spTransform(vettore_shape,proj4string(dic2020_bands))
dic2020_lens<-mask(crop(dic2020_bands,extent(myshape6)),myshape6)

######################## 20m Resolution #########################
############## BLUE:  B02 (490 nm)
############## GREEN: B03 (560 nm)
############## RED:   B04 (665 nm)
############## VRE:   B05 (705 nm)
############## VRE:   B06 (749 nm)
############## VRE:   B07 (783 nm)
############## NIR:   B8A (865 nm)
############## SWIR:  B11 (1610 nm)     
############## SWIR:  B12 (2190 nm)


#########plotting in RGB the six raster images


par(mfrow=c(2,3))
# adjust the parameters so the axes colors are white. Also turn off tick marks.
par(col.axis = "white", col.lab = "white", tck = 0)
# plot
plotRGB(ott2017_lens,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "October 18th, 2017")
# set bounding box to white as well
box(col = "white")

plotRGB(nov2017_lens,4,3,2,scale= "20000", stretch = "lin", axes =TRUE, main = "November 12th, 2017")
box(col = "white")
plotRGB(dic2017_lens,4,3,2,scale= "20000", stretch = "lin", axes =TRUE, main = "December 22th, 2017")
box(col = "white")
plotRGB(ott2020_lens,4,3,2,scale= "20000", stretch = "lin", axes =TRUE, main = "October 22th, 2020")
box(col = "white")
plotRGB(nov2020_lens,4,3,2,scale= "20000", stretch = "lin", axes =TRUE, main = "November 11th, 2020")
box(col = "white")
plotRGB(dic2020_lens,4,3,2,scale= "20000", stretch = "lin", axes =TRUE, main = "December 16th, 2020")
box(col = "white")



# RGB false Colour
par(mfrow=c(2,3))
plotRGB(ott2017_lens,10,4,3,scale= "20000", stretch = "lin", axes = TRUE, main = "October 18th, 2017")
box(col = "white")
plotRGB(nov2017_lens,10,4,3,scale= "20000", stretch = "lin", axes = TRUE, main = "November 12th, 2017")
box(col = "white")
plotRGB(dic2017_lens,10,4,3,scale= "20000", stretch = "lin", axes =TRUE, main = "December 22th, 2017")
box(col = "white")
plotRGB(ott2020_lens,10,4,3,scale= "20000", stretch = "lin", axes =TRUE, main = "October 22th, 2020")
box(col = "white")
plotRGB(nov2020_lens,10,4,3,scale= "20000", stretch = "lin", axes =TRUE, main = "November 11th, 2020")
box(col = "white")
plotRGB(dic2020_lens,10,4,3,scale= "20000", stretch = "lin", axes =TRUE, main = "December 16th, 2020")
box(col = "white")





#NDVI
ndvi1 <- (ott2017_lens$L2A_T33TUH_20171018T100031_B8A_20m - ott_2017$L2A_T33TUH_20171018T100031_B04_20m)
/(ott2017_lens$L2A_T33TUH_20171018T100031_B8A_20m + ott2017_lens$L2A_T33TUH_20171018T100031_B04_20m)

ndvi2 <- (nov2017_lens$T33TUH_20171112T100229_B08 - nov2017_lens$T33TUH_20171112T100229_B04)
/(nov2017_lens$T33TUH_20171112T100229_B08 + nov2017_lens$T33TUH_20171112T100229_B04)

ndvi3 <-(dic2017_lens$L2A_T33TUH_20171222T100419_B8A_20m - dic2017_lens$L2A_T33TUH_20171222T100419_B04_20m)
/(dic2017_lens$L2A_T33TUH_20171222T100419_B8A_20m + dic2017_lens$L2A_T33TUH_20171222T100419_B04_20m)

ndvi4 <- (ott2020_lens$T33TUH_20201022T100051_B8A_20m - ott2020_lens$T33TUH_20201022T100051_B04_20m)
/(ott2020_lens$T33TUH_20201022T100051_B8A_20m + ott2020_lens$T33TUH_20201022T100051_B04_20m)

ndvi5 <- (nov2020_lens$T33TUH_20201111T100241_B8A_20m - nov2020_lens$T33TUH_20201111T100241_B04_20m)
/(nov2020_lens$T33TUH_20201111T100241_B8A_20m + nov2020_lens$T33TUH_20201111T100241_B04_20m)

ndvi6 <- (dic2020_lens$T33TUH_20201216T100329_B08 - dic2020_lens$T33TUH_20201216T100329_B04)
/(dic2020_lens$T33TUH_20201216T100329_B08 + dic2020_lens$T33TUH_20201216T100329_B04)

































