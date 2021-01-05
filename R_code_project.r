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
install.packages("gdalUtils")                #in order to create a shape file-> DA ELIMINARE
library(gdalUtils)

vettore_shape<-readOGR("MonteVettoreShape.shp")
proj4string(ott2017_bands)
proj4string(vettore_shape)

myshape1<-spTransform(vettore_shape,proj4string(ott2017_bands))             ->DA ELIMINARE
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



ext<-c(342000,367000,4732000,4757000)

zoom_vett_ott2017<-crop(ott2017_bands,ext)
zoom_vett_ott2020<-crop(ott2020_bands,ext)
zoom_vett_nov2017<-crop(nov2017_bands,ext)
zoom_vett_dic2017<-crop(dic2017_bands,ext)
zoom_vett_nov2020<-crop(nov2020_bands,ext)
zoom_vett_dic2020<-crop(dic2020_bands,ext)




par(mfrow=c(2,3))
# adjust the parameters so the axes colors are white. Also turn off tick marks.
par(col.axis = "white", col.lab = "white", tck = 0)
# plot

plotRGB(vett_ago2017,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "August 29th, 2017")
# set bounding box to white as well
box(col = "white")
plotRGB(vett_nov2017,4,2,1,scale= "20000", stretch = "lin", axes = TRUE, main = "November 12th, 2017")
box(col = "white")
plotRGB(vett_dic2017,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "December 22th, 2017")
box(col = "white")
plotRGB(vett_ago2020,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "August 28th, 2020")
box(col = "white")
plotRGB(vett_nov2020,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "November 11th, 2020")
box(col = "white")
plotRGB(vett_dic2020,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "December 16th, 2020")
box(col = "white")



#Here I examine the images of August only. I highlight the presence of vegetation by putting NIR(B08A) on top of the red component

par(mfrow=c(1,2))
# adjust the parameters so the axes colors are white. Also turn off tick marks.
par(col.axis = "white", col.lab = "white", tck = 0)
# plot

plotRGB(zoom_vett_ott2017,8,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "August 29th, 2017")
# set bounding box to white as well
box(col = "white")
plotRGB(zoom_vett_ott2020,8,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "August 28th, 2020")
box(col = "white")






#NIR on the top of the red component


plotRGB(ott2017_lens,10,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "October 18th, 2017")
# set bounding box to white as well
box(col = "white")


plotRGB(nov2017_lens,8,2,1,scale= "20000", stretch = "lin", axes =TRUE, main = "November 12th, 2017")
box(col = "white")
plotRGB(dic2017_lens,10,3,2,scale= "20000", stretch = "lin", axes =TRUE, main = "December 22th, 2017")
box(col = "white")
plotRGB(ott2020_lens,10,3,2,scale= "20000", stretch = "lin", axes =TRUE, main = "October 22th, 2020")
box(col = "white")
plotRGB(nov2020_lens,10,3,2,scale= "20000", stretch = "lin", axes =TRUE, main = "November 11th, 2020")
box(col = "white")
plotRGB(dic2020_lens,8,2,1,scale= "20000", stretch = "lin", axes =TRUE, main = "December 16th, 2020")
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
ndvi_ott_2017 <- (vett_ott2017$L2A_T33TUH_20171018T100031_B8A_20m - vett_ott2017$L2A_T33TUH_20171018T100031_B04_20m)/(vett_ott2017$L2A_T33TUH_20171018T100031_B8A_20m + vett_ott2017$L2A_T33TUH_20171018T100031_B04_20m)

ndvi2 <- (nov2017_lens$T33TUH_20171112T100229_B08 - nov2017_lens$T33TUH_20171112T100229_B04)/(nov2017_lens$T33TUH_20171112T100229_B08 + nov2017_lens$T33TUH_20171112T100229_B04)

ndvi3 <-(dic2017_lens$L2A_T33TUH_20171222T100419_B8A_20m - dic2017_lens$L2A_T33TUH_20171222T100419_B04_20m)/(dic2017_lens$L2A_T33TUH_20171222T100419_B8A_20m + dic2017_lens$L2A_T33TUH_20171222T100419_B04_20m)

ndvi_ott_2020 <- (vett_ott2020$T33TUH_20201022T100051_B8A_20m - vett_ott2020$T33TUH_20201022T100051_B04_20m)/(vett_ott2020$T33TUH_20201022T100051_B8A_20m + vett_ott2020$T33TUH_20201022T100051_B04_20m)

ndvi5 <- (nov2020_lens$T33TUH_20201111T100241_B8A_20m - nov2020_lens$T33TUH_20201111T100241_B04_20m)/(nov2020_lens$T33TUH_20201111T100241_B8A_20m + nov2020_lens$T33TUH_20201111T100241_B04_20m)

ndvi6 <- (dic2020_lens$T33TUH_20201216T100329_B08 - dic2020_lens$T33TUH_20201216T100329_B04)/(dic2020_lens$T33TUH_20201216T100329_B08 + dic2020_lens$T33TUH_20201216T100329_B04)




#NDVI
NDVIago2017 <- (vett_ago2017$L2A_T33TUH_20170829T100031_B8A_20m - vett_ott2017$L2A_T33TUH_20170829T100031_B04_20m)/(vett_ago2017$L2A_T33TUH_20170829T100031_B8A_20m + vett_ago2017$L2A_T33TUH_20170829T100031_B04_20m)
NDVIago2020 <- (vett_ago2020$T33TUH_20200828T100029_B8A_20m - vett_ago2020$T33TUH_20200828T100029_B04_20m)/(vett_ago2020$T33TUH_20200828T100029_B8A_20m + vett_ago2020$T33TUH_20200828T100029_B04_20m)

difNDVI_ago<- NDVIago2017-NDVIago2020

colNDVIdiff = colorRampPalette(c("red", "white", "blue"))(50)

plot(difNDVI_ago, col=colNDVIdiff, main= "Differences in NDVI between August 2017 and 2020")




#plot NDVI
colNDVI = colorRampPalette(c("red", "yellow", "dark green"))(100)
par(mfrow=c(2,3))
plot(ndvi_ott_2017, col = clNDVI, main = "October 18th, 2017")
plot(ndvi_nov_2017, col = clNDVI, main = "November 12th, 2017")
plot(ndvi_dic_2017, col = clNDVI, main = "December 22nd,2017")
plot(ndvi_ott_2020, col = clNDVI, main = "October 22nd, 2020")
plot(ndvi_nov_2020, col = clNDVI, main = "November 11th, 2020")
plot(ndvi_dic_2020, col = clNDVI, main = "December 16th, 2020")


#differences in NDVI between October 2017 and october 2020

difNDVI_ott<- ndvi1-ndvi4

colNDVIdiff = colorRampPalette(c("red", "yellow", "dark green"))(100)

plot(difNDVI_ott, col=colNDVIdiff, main= "Differences in NDVI between 2017 and 2020")


#RGB snow cover 1
# adjust the parameters so the axes colors are white. Also turn off tick marks.
par(col.axis = "white", col.lab = "white", tck = 0)
par(mfrow=c(2,3))
plotRGB(ott2017_lens,3,8,9,scale= "20000", stretch = "lin", axes = TRUE, main = "October 18th, 2017")
box(col = "white")
plotRGB(nov2017_lens,3,11,12,scale= "20000", stretch = "lin", axes = TRUE, main = "November 12th, 2017")
box(col = "white")
plotRGB(dic2017_lens,3,8,9,scale= "20000", stretch = "lin", axes =TRUE, main = "December 22nd,2017")
box(col = "white")
plotRGB(ott2020_lens,3,8,9,scale= "20000", stretch = "lin", axes =TRUE, main = "October 22nd, 2020")
box(col = "white")
plotRGB(nov2020_lens,3,8,9,scale= "20000", stretch = "lin", axes =TRUE, main = "November 11th, 2020")
box(col = "white")
plotRGB(dic2020_lens,3,11,12,scale= "20000", stretch = "lin", axes =TRUE, main = "December 16th, 2020")
box(col = "white")


#NDSI


NDSI_nov2017 <- (vett_nov2017$T33TUH_20171112T100229_B03 - vett_nov2017$T33TUH_20171112T100229_B11)/(vett_nov2017$T33TUH_20171112T100229_B03 + vett_nov2017$T33TUH_20171112T100229_B11)           

NDSI_dic2017 <- (vett_dic2017$L2A_T33TUH_20171222T100419_B03_20m  - vett_dic2017$L2A_T33TUH_20171222T100419_B11_20m)/(vett_dic2017$L2A_T33TUH_20171222T100419_B03_20m  + vett_dic2017$L2A_T33TUH_20171222T100419_B11_20m)           

NDSI_nov2020 <- (vett_nov2020$T33TUH_20201111T100241_B03_20m  - vett_nov2020$T33TUH_20201111T100241_B11_20m)/(vett_nov2020$T33TUH_20201111T100241_B03_20m  + vett_nov2020$T33TUH_20201111T100241_B11_20m)           

NDSI_dic2020 <- (vett_dic2020$T33TUH_20201216T100329_B03 - vett_dic2020$T33TUH_20201216T100329_B11)/(vett_dic2020$T33TUH_20201216T100329_B03 + vett_dic2020$T33TUH_20201216T100329_B11)



colNDSI = colorRampPalette(c("white", "yellow", "red"))(100)
par(mfrow=c(2,2))
plot(NDSI_nov2017, col = colNDSI, main = "")
plot(NDSI_dic2017, col = colNDSI, main = "")
plot(NDSI_nov2020, col = colNDSI, main = "")
plot(NDSI_dic2020, col = colNDSI, main = "")









######################## BANDS (images of Oct,and Dec 2017, Oct and Nov 2020) #########################

############## BLUE:  B02 (490 nm)   2
############## GREEN: B03 (560 nm)   3
############## RED:   B04 (665 nm)   4
############## VRE:   B05 (705 nm)   5
############## VRE:   B06 (749 nm)   6      -> #These are the bands I'll work with. When working on these images and plotting them in RGB, the numbers I have use to link the different components to the RGB system are the ones more rightward 
############## VRE:   B07 (783 nm)   7
############## SWIR:  B11 (1610 nm)  8   
############## SWIR:  B12 (2190 nm)  9
############## NIR:   B8A (865 nm)   10


#######################  BANDS  (images of Nov 2017 and December 2020)


############## BLUE:  B02 (490 nm)   2
############## GREEN: B03 (560 nm)   3
############## RED:   B04 (665 nm)   4
############## VRE:   B05 (705 nm)   5
############## VRE:   B06 (749 nm)   6      -> # These two Sentinel images are composed by bands ordered in a different ways. I could get their order thanks to the command "summary", applied to the 2 images. 
############## VRE:   B07 (783 nm)   7
############## NIR:   B8A (865 nm)   8
############## SWIR:  B11 (1610 nm)  11   
############## SWIR:  B12 (2190 nm)  12






















