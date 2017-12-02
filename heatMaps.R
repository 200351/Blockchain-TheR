setwd("D:/PWR/mgr/PracaMagisterska/R")
source('functions.R')

filenamesMatrix = readResultFile('filenames.csv')
diameterMatrix = readResultFile('diameter.csv')
avgPathLengthMatrix = readResultFile('avgPathLength.csv')
avgDegreeMatrix = readResultFile('avgDegree.csv')
avgBetweenessMatrix = readResultFile('avgBetweeness.csv')

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
