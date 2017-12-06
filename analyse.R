# set working directory
setwd("D:/PWR/mgr/PracaMagisterska/R")
library(igraph)
library(gtools)
source('functions.R')
options(nwarnings = 10000)  

filecount <- 10
sampleCount <- 10
sampleIndex <- 1

# graph metrics
diameterMatrix <- prepareDiagonalMatrix(sampleCount)
avgPathLengthMatrix <- prepareDiagonalMatrix(sampleCount)
avgDegreeMatrix <- prepareDiagonalMatrix(sampleCount)
avgBetweenessMatrix <- prepareDiagonalMatrix(sampleCount)

# blockchain metrics
avgTransactionValue <- prepareDiagonalMatrix(sampleCount)
avgTransactionPeriod <- prepareDiagonalMatrix(sampleCount)
countOfBlocks <- prepareDiagonalMatrix(sampleCount)
boundaryDiff <- prepareDiagonalMatrix(sampleCount)

filenamesMatrix <- prepareDiagonalMatrix(sampleCount)

while (sampleIndex < sampleCount + 1) {
  # prepare Path
  pathCoin <- getCoinsPath(sampleIndex - 1)
  pathTime <- getTimePath(sampleIndex - 1)
  pathFull <- getFullPath(sampleIndex - 1)
  # read ten filenames
  filenamesCoin <- readFilesNames(pathCoin, filecount)
  filenamesTime <- readFilesNames(pathTime, filecount)
  filenamesFull <- readFilesNames(pathFull, filecount)
  # prepare index for reverse order
  tableIndex = sampleCount - sampleIndex + 1
  # for each filenames in reverse order for sample
  for(i in 1:length(filenamesTime)){
    # read file
    fileCoins <- readFile(filenamesCoin[i], TRUE)
    fileTime <- readFile(filenamesTime[i], TRUE)
    fileFull <- readFile(filenamesFull[i], TRUE)
    #prepare Graph
    cat('Analyse of file ',  filenamesCoin[i], sep=getSeparator())
    cat('\n')
    gGraph <- graph.data.frame(fileCoins, T)

    #Graph metrics
    #save filename in Matrix
    filenamesMatrix[tableIndex, i] <-  filenamesCoin[i];
    # count diameter and save in Matrix
    diameterMatrix[tableIndex, i] <- diameter(gGraph)
    #count average path length and save in Matrix
    avgPathLengthMatrix[tableIndex, i] <- average.path.length(gGraph)
    #count average degree and save in Matrix
    avgDegreeMatrix[tableIndex, i] <- mean(degree(gGraph))
    #count average betweenness and save in Matrix
    avgBetweenessMatrix[tableIndex, i] <- mean(betweenness(gGraph))

    #Blockchain metrics
    #average transaction value
    avgTransactionValue[tableIndex, i] <- avg.transaction.value(fileCoins[,3])

    cat('Analyse of file ',  filenamesTime[i], sep=getSeparator())
    cat('\n')
    #average transaction period
    avgTransactionPeriod[tableIndex, i] <- avg.transaction.period(fileTime)
    # difference between boundaries transactions
    boundaryDiff[tableIndex, i] <- transaction.boundaryDiff(fileTime)

    cat('Analyse of file ',  filenamesFull[i], sep=getSeparator())
    cat('\n')
    # count of blocks, in which are all transactions
    countOfBlocks[tableIndex, i] <- blocksCount(fileFull)

    # remove graph
    rm(gGraph)
    rm(fileCoins)
    rm(fileTime)
    rm(fileFull)
  }
  
  #increase sampleIndex
  sampleIndex <- sampleIndex + 1
  rm(filenamesCoin)
  rm(filenamesTime)
  rm(filenamesFull)
}

# prepare matrixes transapositions
filenamesMatrix <- t(filenamesMatrix)
diameterMatrix <- t(diameterMatrix)
avgPathLengthMatrix <- t(avgPathLengthMatrix)
avgDegreeMatrix <- t(avgDegreeMatrix)
avgBetweenessMatrix <- t(avgBetweenessMatrix)
avgTransactionValue <- t(avgTransactionValue)
avgTransactionPeriod <- t(avgTransactionPeriod)
countOfBlocks <- t(countOfBlocks)
boundaryDiff <- t(boundaryDiff)

#saveToFile
# writeToFile('filenames.csv', filenamesMatrix)
# writeToFile('avgPathLength.csv', avgPathLengthMatrix)
# writeToFile('avgDegree.csv', avgDegreeMatrix)
# writeToFile('avgBetweeness.csv', avgBetweenessMatrix)
# writeToFile('avgTransactionValue.csv', avgTransactionValue)
# writeToFile('avgTransactionPeriod.csv', avgTransactionPeriod)
# writeToFile('boundaryDiff.csv', boundaryDiff)
# writeToFile('countOfBlocks.csv', counCOfBlocks)

