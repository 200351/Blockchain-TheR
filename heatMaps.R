setwd("D:/PWR/mgr/PracaMagisterska/R")
source('functions.R')

filenamesMatrix <- readResultFile('filenames.csv', FALSE)

#Graph metrics
diameterMatrix <- readResultFile('diameter.csv')
avgPathLengthMatrix <- readResultFile('avgPathLength.csv')
avgDegreeMatrix = readResultFile('avgDegree.csv')
avgBetweenessMatrix = readResultFile('avgBetweeness.csv')

#Blockchain metrics

avgTransactionValueMatrix  <- readResultFile('avgTransactionValue.csv')
avgTransactionPeriodMatrix <- readResultFile('avgTransactionPeriod.csv')
transactionTimeBoundaryDiffMatrix <- readResultFile('boundaryDiff.csv')
countOfBlocksMatrix <- readResultFile('countOfBlocks.csv')


diameterMatrix
diameterHeatMap <- prepareHeatMapForMatrix(diameterMatrix, 'Œrednica')
diameterHeatMap
diameterAvgForSample <- prepareColumnsMeans(diameterMatrix)
diameterAvgForSampleHeatMap <- prepareHeatMapForMatrix(diameterAvgForSample, 'Œrednica\nŒrednia dla okresu')
diameterAvgForSampleHeatMap <- removeBottomTicks(diameterAvgForSampleHeatMap)
diameterAvgForSampleHeatMap

avgPathLengthMatrix
avgPathLengthHeatMap <- prepareHeatMapForMatrix(avgPathLengthMatrix, 'Œrednia d³ugoœæ scie¿ki')
avgPathLengthHeatMap
avgPathLengthAvgForSample <- prepareColumnsMeans(avgPathLengthMatrix)
avgPathLengthAvgForSampleHeatMap <- prepareHeatMapForMatrix(avgPathLengthAvgForSample, 'Œrednia d³ugoœæ scie¿ki\nŒrednia dla okresu')
avgPathLengthAvgForSampleHeatMap <- removeBottomTicks(avgPathLengthAvgForSampleHeatMap)
avgPathLengthAvgForSampleHeatMap

avgBetweenessMatrix
avgBetweenessHeatMap = prepareHeatMapForMatrix(avgBetweenessMatrix, 'Œrednia centralnoœæ')
avgBetweenessHeatMap
avgBetweenessAvgForSample <- prepareColumnsMeans(avgBetweenessMatrix)
avgBetweenessAvgForSampleHeatMap <- prepareHeatMapForMatrix(avgBetweenessAvgForSample,'Œrednia centralnoœæ\nŒrednia dla okresu')
avgBetweenessAvgForSampleHeatMap <- removeBottomTicks(avgBetweenessAvgForSampleHeatMap)
avgBetweenessAvgForSampleHeatMap

avgDegreeMatrix
avgDegreeMap = prepareHeatMapForMatrix(avgDegreeMatrix, 'Œredni stopieñ wêz³a')
avgDegreeMap
avgDegreeAvgForSample <- prepareColumnsMeans(avgDegreeMatrix)
avgDegreeAvgForSampleHeatMap <- prepareHeatMapForMatrix(avgDegreeAvgForSample,'Œredni stopieñ wêz³a\nŒrednia dla okresu')
avgDegreeAvgForSampleHeatMap <- removeBottomTicks(avgDegreeAvgForSampleHeatMap)
avgDegreeAvgForSampleHeatMap

avgTransactionValueMatrix  
avgTransactionValueHeatMap <- prepareHeatMapForMatrix(avgTransactionValueMatrix  , 'Œrednia wartoœæ transakcji')
avgTransactionValueHeatMap 
avgTransactionValueForSample <- prepareColumnsMeans(avgTransactionValueMatrix )
avgTransactionValueForSampleHeatMap <- prepareHeatMapForMatrix(avgTransactionValueForSample, 'Œrednia wartoœæ transakcji\nŒrednia dla okresu')
avgTransactionValueForSampleHeatMap <- removeBottomTicks(avgTransactionValueForSampleHeatMap )
avgTransactionValueForSampleHeatMap


avgTransactionPeriodMatrix
avgTransactionPeriodHeatMap <- prepareHeatMapForMatrix(avgTransactionPeriodMatrix, 'Œrednia czas pomiêdzy\nrelacjami transakcji')
avgTransactionPeriodHeatMap 
avgTransactionPeriodForSample <- prepareColumnsMeans(avgTransactionPeriodMatrix)
avgTransactionPeriodForSampleHeatMap <- prepareHeatMapForMatrix(avgTransactionPeriodForSample, 'Œrednia czas pomiêdzy\nrelacjami transakcji\nŒrednia dla okresu')
avgTransactionPeriodForSampleHeatMap <- removeBottomTicks(avgTransactionPeriodForSampleHeatMap)
avgTransactionPeriodForSampleHeatMap 


transactionTimeBoundaryDiffMatrix 
transactionTimeBoundaryDiffHeatMap <- prepareHeatMapForMatrix(transactionTimeBoundaryDiffMatrix , 'Œrednia czas pomiêdzy relacjami transakcji')
transactionTimeBoundaryDiffHeatMap  
transactionTimeBoundaryDiffForSample <- prepareColumnsMeans(transactionTimeBoundaryDiffMatrix)
transactionTimeBoundaryDiffForSampleHeatMap <- prepareHeatMapForMatrix(transactionTimeBoundaryDiffForSample, 'Œrednia czas pomiêdzy relacjami transakcji\nŒrednia dla okresu')
transactionTimeBoundaryDiffForSampleHeatMap  <- removeBottomTicks(transactionTimeBoundaryDiffForSampleHeatMap )
transactionTimeBoundaryDiffForSampleHeatMap
toHumanTime(transactionTimeBoundaryDiffMatrix, FALSE)



countOfBlocksMatrix
countOfBlocksHeatMap <- prepareHeatMapForMatrix(countOfBlocksMatrix, 'Œrednia iloœæ bloków\npotrzebnych do\nodnalezienia\n100000 po³¹czeñ')
countOfBlocksHeatMap 
countOfBlocksForSample <- prepareColumnsMeans(countOfBlocksMatrix)
countOfBlocksForSampleHeatMap <- prepareHeatMapForMatrix(countOfBlocksForSample , 'Œrednia iloœæ bloków\npotrzebnych do\nodnalezienia\n100000 po³¹czeñ\nŒrednia dla okresu')
countOfBlocksForSampleHeatMap <- removeBottomTicks(countOfBlocksForSampleHeatMap)
countOfBlocksForSampleHeatMap 
