# set working directory
setwd("D:/PWR/mgr/PracaMagisterska/R")
library(igraph)
library(gtools)

pathTime = '/time'
pathCoins = '/coins'
pathFull = '/full'
pathBase = 'data/100000/Sample_'
separator = ""

filecount <- 10
sampleCount <- 10
diameterResult <- matrix(nrow = sampleCount, ncol = filecount)
avgPathLength <- matrix(nrow = sampleCount, ncol = filecount)
avgDegree <- matrix(nrow = sampleCount, ncol = filecount)
avgBetweeness <- matrix(nrow = sampleCount, ncol = filecount)
filenames <- matrix(nrow = sampleCount, ncol = filecount)
sampleIndex <- 1
while (sampleIndex < sampleCount + 1) {
  pathToFiles <- paste(pathBase, sampleIndex - 1, pathCoins, sep = separator)
  cat('Start analyse of sample ', pathToFiles, sep = separator)
  cat('\n')

  filenamesTemp <- list.files(pathToFiles, pattern="*.csv", all.files = TRUE,
                                 full.names = TRUE, recursive = FALSE,
                                 ignore.case = TRUE)
  
  details = file.info(filenamesTemp)
  details = details[with(details, order(as.POSIXct(mtime))), ]
  filenamesTemp = rownames(details)
  filenamesTemp = filenamesTemp[1:10]
  cat(length(filenamesTemp), ' files found',sep = separator)
  cat('\n')
  
  tableIndex = sampleCount - sampleIndex + 1
  # for each in filenames
  for(i in 1:length(filenamesTemp)){
    filename = filenamesTemp[i]
    filenames[tableIndex, i] = filename;
    cat('Analyse of file ', filename, sep=separator)
    cat('\n')
    file <- read.csv2(filename, sep=" ", header = F)
    gGraph <- graph.data.frame(file, F)
    diameterResult[tableIndex, i] <- diameter(gGraph)
    avgPathLength[tableIndex, i] <- average.path.length(gGraph)
    avgDegree[tableIndex, i] <- mean(degree(gGraph))
    avgBetweeness[tableIndex, i] <- mean(betweenness(gGraph))
    rm(file)
    rm(gGraph)
    rm(filename)
  }
  sampleIndex <- sampleIndex + 1
  rm(filenamesTemp)
}

filenames = t(filenames)
diameterResult = t(diameterResult)
avgPathLength = t(avgPathLength)
avgDegree = t(avgDegree)
avgBetweeness = t(avgBetweeness)


number_ticks <- function(n) {function(limits) pretty(limits, n)}

library(reshape2)
diameterResultCorr <- melt(diameterResult,na.rm = TRUE)
# Heatmap
library(ggplot2)
diameterResultMap <- ggplot(data = diameterResultCorr, aes(Var2, Var1, fill = value))+
  geom_tile(color = "orange")+
  scale_fill_gradient2(low = "white", high = "red", mid = "orange", 
                       midpoint = 25, limit = c(0,50), space = "Lab", 
                       name="Probka/Transakcja") +
  theme_minimal()+
  coord_fixed() +
  scale_x_continuous(breaks=number_ticks(10)) +
  scale_y_continuous(breaks=number_ticks(10))

diameterResultMap + geom_text(aes(Var2, Var1, label = value), color = "black", size = 2) +
  theme(
    axis.title.x = element_blank(),
    axis.title.y =  element_blank(),
    panel.grid.major = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank(),
    axis.ticks = element_blank())

