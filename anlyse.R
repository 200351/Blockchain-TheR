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

# diameterPlot <- plot_ly(diameterResult)
# avgPathLengthPlot <- plot_ly(avgPathLength)
# avgDegreePlot <- plot_ly(avgDegree)
# avgBetweenessPlot <- plot_ly(avgBetweeness)


