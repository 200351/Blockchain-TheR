# set working directory
setwd("D:/PWR/mgr/PracaMagisterska/R")
library(igraph)
library(gtools)
source('functions.R')

filecount <- 10
sampleCount <- 10
sampleIndex <- 1

diameterMatrix <- prepareDiagonalMatrix(sampleCount)
avgPathLengthMatrix <- prepareDiagonalMatrix(sampleCount)
avgDegreeMatrix <- prepareDiagonalMatrix(sampleCount)
avgBetweenessMatrix <- prepareDiagonalMatrix(sampleCount)
filenamesMatrix <- prepareDiagonalMatrix(sampleCount)

while (sampleIndex < sampleCount + 1) {
  # prepare Path
  path <- getCoinsPath(sampleIndex - 1)
  # read ten filenames
  filenames <- readFilesNames(path, filecount)
  # prepare index for reverse order
  tableIndex = sampleCount - sampleIndex + 1
  # for each filenames in reverse order for sample
  for(i in 1:length(filenames)){
    cat('Analyse of file ',  filenames[i], sep=getSeparator())
    cat('\n')
    
    #prepare Graph
    gGraph <- graph.data.frame(readFile(filenames[i]), F)
    #save filename in Matrix
    filenamesMatrix[tableIndex, i] <-  filenames[i];
    # count diameter and save in Matrix
    diameterMatrix[tableIndex, i] <- diameter(gGraph)
    #count average path length and save in Matrix
    avgPathLengthMatrix[tableIndex, i] <- average.path.length(gGraph)
    #count average degree and save in Matrix
    avgDegreeMatrix[tableIndex, i] <- mean(degree(gGraph))
    #count average betweenness and save in Matrix
    avgBetweenessMatrix[tableIndex, i] <- mean(betweenness(gGraph))
    # remove graph
    rm(gGraph)
  }
  
  #increase sampleIndex
  sampleIndex <- sampleIndex + 1
  rm(filenames)
}

# prepare matrixes transapositions
filenamesMatrix = t(filenamesMatrix)
diameterMatrix = t(diameterMatrix)
avgPathLengthMatrix = t(avgPathLengthMatrix)
avgDegreeMatrix = t(avgDegreeMatrix)
avgBetweenessMatrix = t(avgBetweenessMatrix)

#saveToFile
writeToFile('filenames.csv', filenamesMatrix)
writeToFile('diameter.csv', diameterMatrix)
writeToFile('avgPathLength.csv', avgPathLengthMatrix)
writeToFile('avgDegree.csv', avgDegreeMatrix)
writeToFile('avgBetweeness.csv', avgBetweenessMatrix)
