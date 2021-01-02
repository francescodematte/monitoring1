setwd("C:/Exam/data")

library(raster)


rlist1<-list.files(pattern="201710")     #OTT 2017
rlist1                                   #checking the different bands composing the image and their features
import1<-lapply(rlist1,raster)
oct2017_bands<-stack(import1)
import1
plot(oct2017_bands)

######################

rlist2<-list.files(pattern="201711")
rlist2                                   
import2<-lapply(rlist2,raster)


B02<-resample(import2[[2]],import2[[5]])

B03<-resample(import2[[3]],import2[[5]])

B04<-resample(import2[[4]],import2[[5]])               #NOV 2017  ------->>>>resampling issue

B08<-resample(import2[[8]],import2[[5]])

nov2017_bands<-stack(B02,B03,B04,import2[[5]],import2[[6]],import2[[7]],B08,import2[[11]])


nov2017_bands<-stack(import2)
import2
plot(nov2017_bands)

############################

rlist3<-list.files(pattern="201712")
rlist3                                   
import3<-lapply(rlist3,raster)                     #DIC 2017
dic2017_bands<-stack(import3)
import3
plot(dic2017_bands)

#############################

rlist4<-list.files(pattern="202010")
rlist4                                   
import4<-lapply(rlist4,raster)                     # OTT 2020
ott2020_bands<-stack(import4)
import4
plot(ott2020_bands)

############################

rlist5<-list.files(pattern="202011")
rlist5                                   
import5<-lapply(rlist5,raster)                     # OTT 2020
nov2020_bands<-stack(import5)
import5
plot(nov2020_bands)

############################

rlist6<-list.files(pattern="202012")
rlist6                                   
import6<-lapply(rlist6,raster)


B02<-resample(import6[[2]],import6[[5]])

B03<-resample(import6[[3]],import6[[5]])

B04<-resample(import6[[4]],import6[[5]])               #DIC 2020  ------->>>>resampling issue again

B08<-resample(import6[[8]],import6[[5]])

dic2020_bands<-stack(B02,B03,B04,import6[[5]],import6[[6]],import6[[7]],B08,import6[[11]])


dic2020_bands<-stack(import6)
import6
plot(dic2020_bands)






















