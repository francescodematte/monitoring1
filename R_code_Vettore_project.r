setwd("C:/Exam/data")

library(raster)                # if not already installed:   install.packages("raster")   The command "library" recalls the functions of a preinstalled package,
                               # it is like to grab a book you already have in your library

rlist1<-list.files(pattern="201710")     #OCT 2017 image
rlist1                                   #checking the bands composing the image and their features

import1<-lapply(rlist1,raster)
ott2017_bands<-stack(import1)

#########

rlist2<-list.files(pattern="201711")

import2<-lapply(rlist2,raster)

# NOV 2017  ------->>>> resampling issue:this Sentinel-2 image is composed by bands with different resolutions, thereby being composed by a different number of rows and columns
# (different number of pixels, with different grain size)
# I cannot create a stack with elements of different size so I use the function "resample" to set all images in the same format (I chose to work on 20 m res images)

#####


B01<-resample(import2[[1]],import2[[5]])             # The second element in the parenthesis define the level of resolution I refere in order to resample all the other bands
                                                     # having a different resolution

B02<-resample(import2[[2]],import2[[5]])

B03<-resample(import2[[3]],import2[[5]])

B04<-resample(import2[[4]],import2[[5]])    

B08<-resample(import2[[8]],import2[[5]])          

B09<-resample(import2[[9]],import2[[5]])

B10<-resample(import2[[10]],import2[[5]])


nov2017_bands<-stack(B01,B02,B03,B04,import2[[5]],import2[[6]],import2[[7]],B08,B09,B10,import2[[11]],import2[[12]])

########

rlist3<-list.files(pattern="201712")
import3<-lapply(rlist3,raster)         # DEC 2017   # In this case, as with the images of Oct 2017, Oct 2020 and Nov 2020, the images I downloaded from Onda Dias
                                       # were already available in folders were all bands have  the same resolution, so I didn't need to use the function resample

dic2017_bands<-stack(import3)

########

rlist4<-list.files(pattern="202010")

import4<-lapply(rlist4,raster)                     # OCT 2020
ott2020_bands<-stack(import4)

########

rlist5<-list.files(pattern="202011")
                                   
import5<-lapply(rlist5,raster)                     # NOV 2020
nov2020_bands<-stack(import5)

########

#DIC 2020  ------->>>> Resampling issue again. The image of Dec 2020 is in the same format of the image of Nov 2017. I need to use "resample" function again

rlist6<-list.files(pattern="202012")
rlist6

import6<-lapply(rlist6,raster)

B01a<-resample(import6[[1]],import6[[5]])

B02a<-resample(import6[[2]],import6[[5]])

B03a<-resample(import6[[3]],import6[[5]])

B04a<-resample(import6[[4]],import6[[5]])                                                   

B08a<-resample(import6[[8]],import6[[5]])

B09a<-resample(import6[[9]],import6[[5]])

B10a<-resample(import6[[10]],import6[[5]])

dic2020_bands<-stack(B01a,B02a,B03a,B04a,import6[[5]],import6[[6]],import6[[7]],B08a,B09a,B10a,import6[[11]],import6[[12]])


######################## BANDS (images of October and December 2017, October and November 2020) #########################

############## BLUE:  B02 (490 nm)   2
############## GREEN: B03 (560 nm)   3
############## RED:   B04 (665 nm)   4
############## VRE:   B05 (705 nm)   5
############## VRE:   B06 (749 nm)   6      -> # These are the bands I'll work with. When working with these images and plotting them in RGB, 
                                               # the numbers I have to use to link to the three components of the RGB system are the most rightward ones 
############## VRE:   B07 (783 nm)   7
############## SWIR:  B11 (1610 nm)  8   
############## SWIR:  B12 (2190 nm)  9
############## NIR:   B8A (865 nm)   10


#######################  BANDS  (images of November 2017 and December 2020) ###############################


############## BLUE:  B02 (490 nm)   2
############## GREEN: B03 (560 nm)   3
############## RED:   B04 (665 nm)   4
############## VRE:   B05 (705 nm)   5
############## VRE:   B06 (749 nm)   6      -> # These two Sentinel images are composed by bands ordered in a different way. I could get their order thanks to the 
                                               # command "summary", applied to the 2 images. 
############## VRE:   B07 (783 nm)   7
############## NIR:   B8A (865 nm)   8
############## SWIR:  B11 (1610 nm)  11   
############## SWIR:  B12 (2190 nm)  12


#####  SELECTING MY SPECIFIC STUDY AREA  ####


zoom<-c(342000,367000,4732000,4757000)            # Here I drawn my area of interest by adding an interval of coordinates in the coordinates system of the images I have.
                                                  # The first and second elements refere to the x and y axis extents respectively. 



vett_ott2017<-crop(ott2017_bands,zoom)            # Through the symbol "<-" I assign a name to the zooms of my specific area I realized for each of the original images
vett_nov2017<-crop(nov2017_bands,zoom)            # I apply the function crop in order to apply the zoom (of which I previously defined the extent) in my area of interest,
                                                  #  for each of the raster images  
vett_dic2017<-crop(dic2017_bands,zoom)
vett_ott2020<-crop(ott2020_bands,zoom)
vett_nov2020<-crop(nov2020_bands,zoom)
vett_dic2020<-crop(dic2020_bands,zoom)

###   RGB, TRUE COLOUR PLOT   ### 

# RGB (B04, B03, B02)

par(mfrow=c(2,3))

par(col.axis = "white", col.lab = "white", tck = 0)
# I adjust the parameters so that the axes colors are white. Moreover I turn the tick marks off (=0)

plotRGB(vett_ott2017,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "October  18th, 2017")
# I set the bounding box to white as well
box(col = "white")
plotRGB(vett_nov2017,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "November 12th, 2017")
box(col = "white")
plotRGB(vett_dic2017,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "December 22th, 2017")
box(col = "white")
plotRGB(vett_ott2020,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "October 22th, 2020")
box(col = "white")
plotRGB(vett_nov2020,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "November 11th, 2020")
box(col = "white")
plotRGB(vett_dic2020,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "December 16th, 2020")
box(col = "white")


###   VEGETATION IN OCTOBER, QUALITATIVE ANALYSIS   ###

# Here I compare the images of October only. I highlight the presence of vegetation by putting NIR(B8A) on top of the red component of the RGB system, 
# then red on G and green on B. 

par(mfrow=c(1,2))

par(col.axis = "white", col.lab = "white", tck = 0)

plotRGB(vett_ott2017,10,4,3,scale= "20000", stretch = "lin", axes = TRUE, main = "October 18th, 2017")     # Reminder: in these images, the number associated to the NIR band 
                                                                                                           # (I'll refere to NIR band 8A) is 10
box(col = "white")

plotRGB(vett_ott2020,10,4,3,scale= "20000", stretch = "lin", axes = TRUE, main = "October 22th, 2020")
box(col = "white")
 
#Unfortunately the differences between the two images don't appear clearly. Only after a careful look it's possible to perceive that in August 2017 the open areas are wider.


#####  NDVI OCTOBER ###########

# B8A - B04 / B8A - B04

#I perform the calculation of the NDVI in order to better highlight the differences in vegetation cover in October 2017 (after an extremely hot summer) and October 2020

NDVI_ott2017 <- (vett_ott2017$L2A_T33TUH_20171018T100031_B8A_20m - vett_ott2017$L2A_T33TUH_20171018T100031_B04_20m)/
(vett_ott2017$L2A_T33TUH_20171018T100031_B8A_20m + vett_ott2017$L2A_T33TUH_20171018T100031_B04_20m)

NDVI_ott2020 <- (vett_ott2020$T33TUH_20201022T100051_B8A_20m - vett_ott2020$T33TUH_20201022T100051_B04_20m)/
(vett_ott2020$T33TUH_20201022T100051_B8A_20m + vett_ott2020$T33TUH_20201022T100051_B04_20m)


difNDVI_ott<- NDVI_ott2017-NDVI_ott2020

colNDVIdiff = colorRampPalette(c("red", "yellow", "dark green"))(250)

plot(difNDVI_ott, col=colNDVIdiff, main= "Differences in NDVI between October 2017 and October 2020")


####  SNOW COVER IN NOVEMBER AND DECEMBER ####

# RGB plot, true colours


par(mfrow=c(2,2))
par(col.axis = "white", col.lab = "white", tck = 0)

plotRGB(vett_nov2017,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "November 12th, 2017")
box(col = "white")
plotRGB(vett_dic2017,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "December 22nd, 2017")
box(col = "white")
plotRGB(vett_nov2020,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "November 11th, 2020")
box(col = "white")
plotRGB(vett_dic2020,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "December 16th, 2020")
box(col = "white")



####  NDSI calculation  #######   

#  B03 (green) - B11 (SWIR)/ B03 + B11     ## snow reflectance is low in SWIR wavelenghts and high in visible light (here green wavelenght is taken into account)



NDSI_nov2017 <- (vett_nov2017$T33TUH_20171112T100229_B03 - vett_nov2017$T33TUH_20171112T100229_B11)/
(vett_nov2017$T33TUH_20171112T100229_B03 + vett_nov2017$T33TUH_20171112T100229_B11)           

NDSI_dic2017 <- (vett_dic2017$L2A_T33TUH_20171222T100419_B03_20m  - vett_dic2017$L2A_T33TUH_20171222T100419_B11_20m)/
(vett_dic2017$L2A_T33TUH_20171222T100419_B03_20m  + vett_dic2017$L2A_T33TUH_20171222T100419_B11_20m)           

NDSI_nov2020 <- (vett_nov2020$T33TUH_20201111T100241_B03_20m  - vett_nov2020$T33TUH_20201111T100241_B11_20m)/
(vett_nov2020$T33TUH_20201111T100241_B03_20m  + vett_nov2020$T33TUH_20201111T100241_B11_20m)           

NDSI_dic2020 <- (vett_dic2020$T33TUH_20201216T100329_B03 - vett_dic2020$T33TUH_20201216T100329_B11)/
(vett_dic2020$T33TUH_20201216T100329_B03 + vett_dic2020$T33TUH_20201216T100329_B11)



colNDSI = colorRampPalette(c("white", "yellow", "red"))(250)
par(mfrow=c(2,2))
plot(NDSI_nov2017, col = colNDSI, main = "NDSI nov 2017")
plot(NDSI_dic2017, col = colNDSI, main = "NDSI dic 2017")
plot(NDSI_nov2020, col = colNDSI, main = "NDSI nov 2020")
plot(NDSI_dic2020, col = colNDSI, main = "NDSI dic 2020")



# RGB false colour for snow (red, SWIR1,SWIR2)

# The plot of the NDSI related to November 2020 was characterised by quite uniform and low values of the index and didn't reveal the presence of snow 
# (could be due to atmospheric disturbance altering the reflectance of our landscape) 
# I'm going to better highlight the presence of snow, if there was any, thanks to the contrast between its peculiar reflectance,
# low in the SWIR and high in the wavelenghts of the visible light (I pur red band on top of red component)

par(mfrow=c(2,2))

par(col.axis = "white", col.lab = "white", tck = 0)

plotRGB(vett_nov2017,4,11,12,scale= "20000", stretch = "lin", axes = TRUE, main = "November 12th, 2017")
box(col = "white")
plotRGB(vett_dic2017,4,8,9,scale= "20000", stretch = "lin", axes = TRUE, main = "December 22th, 2017")       # Reminder: in the dic2017 and nov2020 the SWIR bands are 
                                                                                                             # associated to the numbers 8 and 9,
                                                                                                             # differently from the other raster images
box(col = "white")
plotRGB(vett_nov2020,4,8,9,scale= "20000", stretch = "lin", axes = TRUE, main = "November 11th, 2020")
box(col = "white")
plotRGB(vett_dic2020,4,11,12,scale= "20000", stretch = "lin", axes = TRUE, main = "December 16th, 2020")
box(col = "white")
















