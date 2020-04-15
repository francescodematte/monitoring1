# Rcode for multivariate analysis

setwd("C:/lab/")


library(vegan)

biomes <- read.table("biomes.csv", header=T, sep=",")

head (biomes)

# decorana: detrended correspondence analysis (dimensions' reduction)

multivar <- decorana(biomes)

plot(multivar)

# biomes types

biomes_types.csv <- read.table("biomes_types.csv", header=T,  sep=",")

head(biomes_types)

attach(biomes_types.csv)

ordiellipse(multivar, type, col= 1:4, kind="ehull", lwd=3)

ordispider (multivar, type, col= 1:4, label=T)

