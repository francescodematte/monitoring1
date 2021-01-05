setwd("C:/Exam/data")

library(raster)                #if not already installed:   install.packages("raster")   

rlist1<-list.files(pattern="201708")     #OTT 2017
rlist1                                   #checking the different bands composing the image and their features
import1<-lapply(rlist1,raster)
ago2017_bands<-stack(import1)

#########

rlist2<-list.files(pattern="201711")
rlist2                                   
import2<-lapply(rlist2,raster)

#NOV 2017  ------->>>>resampling issue:this Sentinel-2 image is composed by bands with different resolutions.
I cannot create a stack with elements of different size so I use the function "resample" to set all images in the same format (I choose to work on 20 m res images)


B01<-resample(import2[[1]],import2[[5]])

B02<-resample(import2[[2]],import2[[5]])

B03<-resample(import2[[3]],import2[[5]])

B04<-resample(import2[[4]],import2[[5]])    

B08<-resample(import2[[8]],import2[[5]])          

B09<-resample(import2[[9]],import2[[5]])

B10<-resample(import2[[10]],import2[[5]])


nov2017_bands<-stack(B01,B02,B03,B04,import2[[5]],import2[[6]],import2[[7]],B08,B09,B10,import2[[11]],import2[[12]])

########

rlist3<-list.files(pattern="201712")
rlist3                                   
import3<-lapply(rlist3,raster)                     #DIC 2017
dic2017_bands<-stack(import3)

########

rlist4<-list.files(pattern="202008")
rlist4                                   
import4<-lapply(rlist4,raster)                     # OTT 2020
ago2020_bands<-stack(import4)

########

rlist5<-list.files(pattern="202011")
rlist5                                   
import5<-lapply(rlist5,raster)                     # NOV 2020
nov2020_bands<-stack(import5)

########

#DIC 2020  ------->>>> Resampling issue again. The image of dic 2020 is in the same format of the image of nov 2017, thereby I need to use resample function again

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


#####  SELECTING MY SPECIFIC STUDY AREA  ####


zoom<-c(342000,367000,4732000,4757000)            #here I drawn my area of interest by adding an interval of coordinates in the coordinates system of the images I have



vett_ago2017<-crop(ago2017_bands,zoom)
vett_nov2017<-crop(nov2017_bands,zoom)
vett_dic2017<-crop(dic2017_bands,zoom)
vett_ago2020<-crop(ago2020_bands,zoom)
vett_nov2020<-crop(nov2020_bands,zoom)
vett_dic2020<-crop(dic2020_bands,zoom)



par(mfrow=c(2,3))
# adjust the parameters so the axes colors are white. Also turn off tick marks.
par(col.axis = "white", col.lab = "white", tck = 0)
# plot

plotRGB(vett_ago2017,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "August 29th, 2017")
# set bounding box to white as well
box(col = "white")
plotRGB(vett_nov2017,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "November 12th, 2017")
box(col = "white")
plotRGB(vett_dic2017,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "December 22th, 2017")
box(col = "white")
plotRGB(vett_ago2020,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "August 28th, 2020")
box(col = "white")
plotRGB(vett_nov2020,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "November 11th, 2020")
box(col = "white")
plotRGB(vett_dic2020,4,3,2,scale= "20000", stretch = "lin", axes = TRUE, main = "December 16th, 2020")
box(col = "white")









