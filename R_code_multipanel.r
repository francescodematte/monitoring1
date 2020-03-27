### Multipanel in R: the second lesson of Monitoring Ecosystems

install.packages("sp")
install.packages("GGally")

data(meuse)

attach(meuse)

all the possible pairwise plots of the dataset 

pairs(meuse)

pairs(~cadmium+copper+lead+zinc, data=meuse)

pairs(meuse[,3:6])



ggpairs(meuse[,3:6])
