setwd("D:/PWR/mgr/PracaMagisterska/R")
library(igraph)
dfBlockchain <- read.csv2("test/blockchain1k.csv", sep=" ", header = F)
gGraph <- graph.data.frame(dfBlockchain, F)
plot(gGraph, layout = layout.fruchterman.reingold, vertex.label=NA, vertex.size=2)
diameter(gGraph)
bit <- betweenness(gGraph)
x <- bit[, "B", drop=FALSE]
bit;
average.path.length(gGraph)
hist(bit, breaks = 10, xlim=range(bit))
clusters(gGraph)
de <- degree(gGraph)
