setwd("D:/PWR/mgr/PracaMagisterska/R")
source('functions.R')

filenamesMatrix = readResultFile('filenames.csv')
diameterMatrix = readResultFile('diameter.csv')
avgPathLengthMatrix = readResultFile('avgPathLength.csv')
avgDegreeMatrix = readResultFile('avgDegree.csv')
avgBetweenessMatrix = readResultFile('avgBetweeness.csv')

diameterMatrix
diameterHeatMap = prepareHeatMapForMatrix(diameterMatrix, 'Œrednica')
diameterHeatMap

avgPathLengthMatrix
avgPathLengthHeatMap = prepareHeatMapForMatrix(avgPathLengthMatrix, 'Œrednia d³ugoœæ scie¿ki')
avgPathLengthHeatMap

avgBetweenessMatrix
avgBetweenessHeatMap = prepareHeatMapForMatrix(avgBetweenessMatrix, 'Œrednia centralnoœæ')
avgBetweenessHeatMap

avgDegreeMatrix
avgDegreeMap = prepareHeatMapForMatrix(avgDegreeMatrix, 'Œredni stopieñ wêz³a')
avgDegreeMap
