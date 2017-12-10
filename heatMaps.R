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

# Diamater
diameterHeatMap <- prepareHeatMapForMatrix(diameterMatrix, 'Œrednica')
diameterAvgForSample <- prepareColumnsMeans(diameterMatrix)
diameterAvgForSampleHeatMap <- prepareHeatMapForMatrix(diameterAvgForSample, 'Œrednica\nŒrednia dla okresu')
diameterAvgForSampleHeatMap <- removeBottomTicks(diameterAvgForSampleHeatMap)

psd <- plotWithStandardDeviation(diameterMatrix, label = "Œrednica")
psda <- plotApproxStandardDeviation(diameterMatrix, label = "Œrednica")
pse <- plotWithStandardError(diameterMatrix, label = "Œrednica")
psea <- plotApproxStandardError(diameterMatrix, label = "Œrednica")

saveHeatMap(diameterHeatMap, name = 'srednica')
saveAvgHeatMap(diameterAvgForSampleHeatMap, name = 'srednica')
savePlotSD(psd, 'srednica')
savePlotSE(pse, 'srednica')
savePlotSDA(psda, 'srednica')
savePlotSEA(psea, 'srednica')

#AvgPathLenght
avgPathLengthHeatMap <- prepareHeatMapForMatrix(avgPathLengthMatrix, 'Œrednia d³ugoœæ scie¿ki')
avgPathLengthAvgForSample <- prepareColumnsMeans(avgPathLengthMatrix)
avgPathLengthAvgForSampleHeatMap <- prepareHeatMapForMatrix(avgPathLengthAvgForSample, 'Œrednia d³ugoœæ scie¿ki\nŒrednia dla okresu')
avgPathLengthAvgForSampleHeatMap <- removeBottomTicks(avgPathLengthAvgForSampleHeatMap)

psd <- plotWithStandardDeviation(avgPathLengthMatrix, label = "Œrednia d³ugoœæ scie¿ki")
pse <- plotWithStandardError(avgPathLengthMatrix, label = "Œrednia d³ugoœæ scie¿ki")
psda <- plotApproxStandardDeviation(avgPathLengthMatrix, label = "Œrednia d³ugoœæ scie¿ki")
psea <- plotApproxStandardError(avgPathLengthMatrix, label = "Œrednia d³ugoœæ scie¿ki")

saveAvgHeatMap(avgPathLengthAvgForSampleHeatMap, 'srednia_dlugosc_sciezki')
saveHeatMap(avgPathLengthHeatMap, 'srednia_dlugosc_sciezki')
savePlotSD(psd, 'srednia_dlugosc_sciezki')
savePlotSE(pse, 'srednia_dlugosc_sciezki')
savePlotSDA(psda, 'srednia_dlugosc_sciezki')
savePlotSEA(psea, 'srednia_dlugosc_sciezki')

#Avg Betweeness
avgBetweenessHeatMap = prepareHeatMapForMatrix(avgBetweenessMatrix, 'Œrednia centralnoœæ')
avgBetweenessAvgForSample <- prepareColumnsMeans(avgBetweenessMatrix)
avgBetweenessAvgForSampleHeatMap <- prepareHeatMapForMatrix(avgBetweenessAvgForSample,'Œrednia centralnoœæ\nŒrednia dla okresu')
avgBetweenessAvgForSampleHeatMap <- removeBottomTicks(avgBetweenessAvgForSampleHeatMap)

psd <- plotWithStandardDeviation(avgBetweenessMatrix, label = "Œrednia centralnoœæ")
pse <- plotWithStandardError(avgBetweenessMatrix, label = "Œrednia centralnoœæ")
psda <- plotApproxStandardDeviation(avgBetweenessMatrix, label = "Œrednia centralnoœæ")
psea <- plotApproxStandardError(avgBetweenessMatrix, label = "Œrednia centralnoœæ")
plotHist <- plotHistogram(avgBetweenessMatrix, "Œrednia centralnoœæ", x_ticks = 4)

saveHeatMap(avgBetweenessHeatMap, 'srednia_centralnosc')
saveAvgHeatMap(avgBetweenessAvgForSampleHeatMap, 'srednia_centralnosc')
savePlotSD(psd, 'srednia_centralnosc')
savePlotSE(pse, 'srednia_centralnosc')
savePlotSDA(psda, 'srednia_centralnosc')
savePlotSEA(psea, 'srednia_centralnosc')
saveHistogram(plotHist, 'srednia_centralnosc')

#Avg degree
avgDegreeMap = prepareHeatMapForMatrix(avgDegreeMatrix, 'Œredni stopieñ wêz³a',numsize = 2.5)
avgDegreeAvgForSample <- prepareColumnsMeans(avgDegreeMatrix)
avgDegreeAvgForSampleHeatMap <- prepareHeatMapForMatrix(avgDegreeAvgForSample,'Œredni stopieñ wêz³a\nŒrednia dla okresu', numsize = 2.5)
avgDegreeAvgForSampleHeatMap <- removeBottomTicks(avgDegreeAvgForSampleHeatMap)

psd <- plotWithStandardDeviation(avgDegreeMatrix, label = 'Œredni stopieñ wêz³a')
pse <- plotWithStandardError(avgDegreeMatrix, label = 'Œredni stopieñ wêz³a')
psda <- plotApproxStandardDeviation(avgDegreeMatrix, label = 'Œredni stopieñ wêz³a')
psea <- plotApproxStandardError(avgDegreeMatrix, label = 'Œredni stopieñ wêz³a')

saveHeatMap(avgDegreeMap, 'sredni_stopien_wezla')
saveAvgHeatMap(avgDegreeAvgForSampleHeatMap, 'sredni_stopien_wezla')
savePlotSD(psd, 'sredni_stopien_wezla')
savePlotSE(pse, 'sredni_stopien_wezla')
savePlotSDA(psda, 'sredni_stopien_wezla')
savePlotSEA(psea, 'sredni_stopien_wezla')

plotHist <- plotHistogram(avgDegreeMatrix, xlab = 'Œredni stopieñ wêz³a', y_ticks = 2, x_ticks = 1000, hist_breaks = 150)
saveHistogram(plotHist, 'sredni_stopien_wezla')



# Avg transaction value
avgTransactionValueHeatMap <- prepareHeatMapForMatrix(avgTransactionValueMatrix  , 'Œrednia wartoœæ\ntransakcji')
avgTransactionValueForSample <- prepareColumnsMeans(avgTransactionValueMatrix )
avgTransactionValueForSampleHeatMap <- prepareHeatMapForMatrix(avgTransactionValueForSample, 'Œrednia wartoœæ transakcji\nŒrednia dla okresu')
avgTransactionValueForSampleHeatMap <- removeBottomTicks(avgTransactionValueForSampleHeatMap )

psd <- plotWithStandardDeviation(avgTransactionValueMatrix, label = 'Œrednia wartoœæ transakcji')
pse <- plotWithStandardError(avgTransactionValueMatrix, label = 'Œrednia wartoœæ transakcji')
psda <- plotApproxStandardDeviation(avgTransactionValueMatrix, label = 'Œrednia wartoœæ transakcji')
psea <- plotApproxStandardError(avgTransactionValueMatrix, label = 'Œrednia wartoœæ transakcji')

saveHeatMap(avgTransactionValueHeatMap, 'wartosc_transakcji')
saveAvgHeatMap(avgTransactionValueForSampleHeatMap, 'wartosc_transakcji')
savePlotSD(psd, 'wartosc_transakcji')
savePlotSE(pse, 'wartosc_transakcji')
savePlotSDA(psda, 'wartosc_transakcji')
savePlotSEA(psea, 'wartosc_transakcji')

# Avg Transaction Period
avgTransactionPeriodHeatMap <- prepareHeatMapForMatrix(avgTransactionPeriodMatrix, 'Œredni czas ró¿nic\nkolejnych transakcji')
avgTransactionPeriodForSample <- prepareColumnsMeans(avgTransactionPeriodMatrix)
avgTransactionPeriodForSampleHeatMap <- prepareHeatMapForMatrix(avgTransactionPeriodForSample, 'Œredni czas ró¿nic kolejnych transakcji\nŒrednia dla okresu')
avgTransactionPeriodForSampleHeatMap <- removeBottomTicks(avgTransactionPeriodForSampleHeatMap)

psd <- plotWithStandardDeviation(avgTransactionPeriodMatrix, label = 'Œredni czas ró¿nic kolejnych transakcji')
pse <- plotWithStandardError(avgTransactionPeriodMatrix, label = 'Œredni czas ró¿nic kolejnych transakcji')
psda <- plotApproxStandardDeviation(avgTransactionPeriodMatrix, label = 'Œredni czas ró¿nic kolejnych transakcji')
psea <- plotApproxStandardError(avgTransactionPeriodMatrix, label = 'Œredni czas ró¿nic kolejnych transakcji')

saveHeatMap(avgTransactionPeriodHeatMap, 'roznica_czasow') 
saveAvgHeatMap(avgTransactionPeriodForSampleHeatMap, 'roznica_czasow') 
savePlotSD(psd, 'roznica_czasow')
savePlotSE(pse, 'roznica_czasow')
savePlotSDA(psda, 'roznica_czasow')
savePlotSEA(psea, 'roznica_czasow')


#Transacion Boundary Difference 
transactionTimeBoundaryDiffHeatMap <- prepareHeatMapForMatrix(transactionTimeBoundaryDiffMatrix , 'Czas ró¿nic\ngranicznych transakcji', numsize = 2.5)
transactionTimeBoundaryDiffForSample <- prepareColumnsMeans(transactionTimeBoundaryDiffMatrix)
transactionTimeBoundaryDiffForSampleHeatMap <- prepareHeatMapForMatrix(transactionTimeBoundaryDiffForSample, 'Œredni czas ró¿nic\ngranicznych transakcji dla okresu', numsize = 2.5)
transactionTimeBoundaryDiffForSampleHeatMap  <- removeBottomTicks(transactionTimeBoundaryDiffForSampleHeatMap )

psd <- plotWithStandardDeviation(transactionTimeBoundaryDiffMatrix, label = 'Œredni czas ró¿nic granicznych transakcji')
pse <- plotWithStandardError(transactionTimeBoundaryDiffMatrix, label = 'Œredni czas ró¿nic granicznych transakcji')
psda <- plotApproxStandardDeviation(transactionTimeBoundaryDiffMatrix, label = 'Œredni czas ró¿nic granicznych transakcji')
psea <- plotApproxStandardError(transactionTimeBoundaryDiffMatrix, label = 'Œredni czas ró¿nic granicznych transakcji')

saveHeatMap(transactionTimeBoundaryDiffHeatMap, 'czas_graniczny')
saveAvgHeatMap(transactionTimeBoundaryDiffForSampleHeatMap, 'czas_graniczny')
savePlotSD(psd, 'czas_graniczny')
savePlotSE(pse, 'czas_graniczny')
savePlotSDA(psda, 'czas_graniczny')
savePlotSEA(psea, 'czas_graniczny')

#Count of blocks
countOfBlocksHeatMap <- prepareHeatMapForMatrix(countOfBlocksMatrix, 'Iloœæ bloków\npotrzebnych do\nodnalezienia\n100000 po³¹czeñ')
countOfBlocksForSample <- prepareColumnsMeans(countOfBlocksMatrix)
countOfBlocksForSampleHeatMap <- prepareHeatMapForMatrix(countOfBlocksForSample , 'Œrednia iloœæ bloków\npotrzebnych do\nodnalezienia\n100000 po³¹czeñ\n dla okresu')
countOfBlocksForSampleHeatMap <- removeBottomTicks(countOfBlocksForSampleHeatMap)

psd <- plotWithStandardDeviation(countOfBlocksMatrix, label = 'Œrednia iloœæ bloków potrzebnych do odnalezienia 100000 po³¹czeñ')
pse <- plotWithStandardError(countOfBlocksMatrix, label = 'Œrednia iloœæ bloków potrzebnych do odnalezienia 100000 po³¹czeñ')
psda <- plotApproxStandardDeviation(countOfBlocksMatrix, label = 'Œrednia iloœæ bloków potrzebnych do odnalezienia 100000 po³¹czeñ')
psea <- plotApproxStandardError(countOfBlocksMatrix, label = 'Œrednia iloœæ bloków potrzebnych do odnalezienia 100000 po³¹czeñ')

saveHeatMap(countOfBlocksHeatMap, 'ilosc_blokow') 
saveAvgHeatMap(countOfBlocksForSampleHeatMap, 'ilosc_blokow')  
savePlotSD(psd, 'ilosc_blokow')
savePlotSE(pse, 'ilosc_blokow')
savePlotSDA(psda, 'ilosc_blokow')
savePlotSEA(psea, 'ilosc_blokow')
