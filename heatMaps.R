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
diameterHeatMap <- prepareHeatMapForMatrix(diameterMatrix, '�rednica')
diameterAvgForSample <- prepareColumnsMeans(diameterMatrix)
diameterAvgForSampleHeatMap <- prepareHeatMapForMatrix(diameterAvgForSample, '�rednica\n�rednia dla okresu')
diameterAvgForSampleHeatMap <- removeBottomTicks(diameterAvgForSampleHeatMap)

psd <- plotWithStandardDeviation(diameterMatrix, label = "�rednica")
psda <- plotApproxStandardDeviation(diameterMatrix, label = "�rednica")
pse <- plotWithStandardError(diameterMatrix, label = "�rednica")
psea <- plotApproxStandardError(diameterMatrix, label = "�rednica")

saveHeatMap(diameterHeatMap, name = 'srednica')
saveAvgHeatMap(diameterAvgForSampleHeatMap, name = 'srednica')
savePlotSD(psd, 'srednica')
savePlotSE(pse, 'srednica')
savePlotSDA(psda, 'srednica')
savePlotSEA(psea, 'srednica')

#AvgPathLenght
avgPathLengthHeatMap <- prepareHeatMapForMatrix(avgPathLengthMatrix, '�rednia d�ugo�� scie�ki')
avgPathLengthAvgForSample <- prepareColumnsMeans(avgPathLengthMatrix)
avgPathLengthAvgForSampleHeatMap <- prepareHeatMapForMatrix(avgPathLengthAvgForSample, '�rednia d�ugo�� scie�ki\n�rednia dla okresu')
avgPathLengthAvgForSampleHeatMap <- removeBottomTicks(avgPathLengthAvgForSampleHeatMap)

psd <- plotWithStandardDeviation(avgPathLengthMatrix, label = "�rednia d�ugo�� scie�ki")
pse <- plotWithStandardError(avgPathLengthMatrix, label = "�rednia d�ugo�� scie�ki")
psda <- plotApproxStandardDeviation(avgPathLengthMatrix, label = "�rednia d�ugo�� scie�ki")
psea <- plotApproxStandardError(avgPathLengthMatrix, label = "�rednia d�ugo�� scie�ki")

saveAvgHeatMap(avgPathLengthAvgForSampleHeatMap, 'srednia_dlugosc_sciezki')
saveHeatMap(avgPathLengthHeatMap, 'srednia_dlugosc_sciezki')
savePlotSD(psd, 'srednia_dlugosc_sciezki')
savePlotSE(pse, 'srednia_dlugosc_sciezki')
savePlotSDA(psda, 'srednia_dlugosc_sciezki')
savePlotSEA(psea, 'srednia_dlugosc_sciezki')

#Avg Betweeness
avgBetweenessHeatMap = prepareHeatMapForMatrix(avgBetweenessMatrix, '�rednia centralno��')
avgBetweenessAvgForSample <- prepareColumnsMeans(avgBetweenessMatrix)
avgBetweenessAvgForSampleHeatMap <- prepareHeatMapForMatrix(avgBetweenessAvgForSample,'�rednia centralno��\n�rednia dla okresu')
avgBetweenessAvgForSampleHeatMap <- removeBottomTicks(avgBetweenessAvgForSampleHeatMap)

psd <- plotWithStandardDeviation(avgBetweenessMatrix, label = "�rednia centralno��")
pse <- plotWithStandardError(avgBetweenessMatrix, label = "�rednia centralno��")
psda <- plotApproxStandardDeviation(avgBetweenessMatrix, label = "�rednia centralno��")
psea <- plotApproxStandardError(avgBetweenessMatrix, label = "�rednia centralno��")
plotHist <- plotHistogram(avgBetweenessMatrix, "�rednia centralno��", x_ticks = 4)

saveHeatMap(avgBetweenessHeatMap, 'srednia_centralnosc')
saveAvgHeatMap(avgBetweenessAvgForSampleHeatMap, 'srednia_centralnosc')
savePlotSD(psd, 'srednia_centralnosc')
savePlotSE(pse, 'srednia_centralnosc')
savePlotSDA(psda, 'srednia_centralnosc')
savePlotSEA(psea, 'srednia_centralnosc')
saveHistogram(plotHist, 'srednia_centralnosc')

#Avg degree
avgDegreeMap = prepareHeatMapForMatrix(avgDegreeMatrix, '�redni stopie� w�z�a',numsize = 2.5)
avgDegreeAvgForSample <- prepareColumnsMeans(avgDegreeMatrix)
avgDegreeAvgForSampleHeatMap <- prepareHeatMapForMatrix(avgDegreeAvgForSample,'�redni stopie� w�z�a\n�rednia dla okresu', numsize = 2.5)
avgDegreeAvgForSampleHeatMap <- removeBottomTicks(avgDegreeAvgForSampleHeatMap)

psd <- plotWithStandardDeviation(avgDegreeMatrix, label = '�redni stopie� w�z�a')
pse <- plotWithStandardError(avgDegreeMatrix, label = '�redni stopie� w�z�a')
psda <- plotApproxStandardDeviation(avgDegreeMatrix, label = '�redni stopie� w�z�a')
psea <- plotApproxStandardError(avgDegreeMatrix, label = '�redni stopie� w�z�a')

saveHeatMap(avgDegreeMap, 'sredni_stopien_wezla')
saveAvgHeatMap(avgDegreeAvgForSampleHeatMap, 'sredni_stopien_wezla')
savePlotSD(psd, 'sredni_stopien_wezla')
savePlotSE(pse, 'sredni_stopien_wezla')
savePlotSDA(psda, 'sredni_stopien_wezla')
savePlotSEA(psea, 'sredni_stopien_wezla')

plotHist <- plotHistogram(avgDegreeMatrix, xlab = '�redni stopie� w�z�a', y_ticks = 2, x_ticks = 1000, hist_breaks = 150)
saveHistogram(plotHist, 'sredni_stopien_wezla')



# Avg transaction value
avgTransactionValueHeatMap <- prepareHeatMapForMatrix(avgTransactionValueMatrix  , '�rednia warto��\ntransakcji')
avgTransactionValueForSample <- prepareColumnsMeans(avgTransactionValueMatrix )
avgTransactionValueForSampleHeatMap <- prepareHeatMapForMatrix(avgTransactionValueForSample, '�rednia warto�� transakcji\n�rednia dla okresu')
avgTransactionValueForSampleHeatMap <- removeBottomTicks(avgTransactionValueForSampleHeatMap )

psd <- plotWithStandardDeviation(avgTransactionValueMatrix, label = '�rednia warto�� transakcji')
pse <- plotWithStandardError(avgTransactionValueMatrix, label = '�rednia warto�� transakcji')
psda <- plotApproxStandardDeviation(avgTransactionValueMatrix, label = '�rednia warto�� transakcji')
psea <- plotApproxStandardError(avgTransactionValueMatrix, label = '�rednia warto�� transakcji')

saveHeatMap(avgTransactionValueHeatMap, 'wartosc_transakcji')
saveAvgHeatMap(avgTransactionValueForSampleHeatMap, 'wartosc_transakcji')
savePlotSD(psd, 'wartosc_transakcji')
savePlotSE(pse, 'wartosc_transakcji')
savePlotSDA(psda, 'wartosc_transakcji')
savePlotSEA(psea, 'wartosc_transakcji')

# Avg Transaction Period
avgTransactionPeriodHeatMap <- prepareHeatMapForMatrix(avgTransactionPeriodMatrix, '�redni czas r�nic\nkolejnych transakcji')
avgTransactionPeriodForSample <- prepareColumnsMeans(avgTransactionPeriodMatrix)
avgTransactionPeriodForSampleHeatMap <- prepareHeatMapForMatrix(avgTransactionPeriodForSample, '�redni czas r�nic kolejnych transakcji\n�rednia dla okresu')
avgTransactionPeriodForSampleHeatMap <- removeBottomTicks(avgTransactionPeriodForSampleHeatMap)

psd <- plotWithStandardDeviation(avgTransactionPeriodMatrix, label = '�redni czas r�nic kolejnych transakcji')
pse <- plotWithStandardError(avgTransactionPeriodMatrix, label = '�redni czas r�nic kolejnych transakcji')
psda <- plotApproxStandardDeviation(avgTransactionPeriodMatrix, label = '�redni czas r�nic kolejnych transakcji')
psea <- plotApproxStandardError(avgTransactionPeriodMatrix, label = '�redni czas r�nic kolejnych transakcji')

saveHeatMap(avgTransactionPeriodHeatMap, 'roznica_czasow') 
saveAvgHeatMap(avgTransactionPeriodForSampleHeatMap, 'roznica_czasow') 
savePlotSD(psd, 'roznica_czasow')
savePlotSE(pse, 'roznica_czasow')
savePlotSDA(psda, 'roznica_czasow')
savePlotSEA(psea, 'roznica_czasow')


#Transacion Boundary Difference 
transactionTimeBoundaryDiffHeatMap <- prepareHeatMapForMatrix(transactionTimeBoundaryDiffMatrix , 'Czas r�nic\ngranicznych transakcji', numsize = 2.5)
transactionTimeBoundaryDiffForSample <- prepareColumnsMeans(transactionTimeBoundaryDiffMatrix)
transactionTimeBoundaryDiffForSampleHeatMap <- prepareHeatMapForMatrix(transactionTimeBoundaryDiffForSample, '�redni czas r�nic\ngranicznych transakcji dla okresu', numsize = 2.5)
transactionTimeBoundaryDiffForSampleHeatMap  <- removeBottomTicks(transactionTimeBoundaryDiffForSampleHeatMap )

psd <- plotWithStandardDeviation(transactionTimeBoundaryDiffMatrix, label = '�redni czas r�nic granicznych transakcji')
pse <- plotWithStandardError(transactionTimeBoundaryDiffMatrix, label = '�redni czas r�nic granicznych transakcji')
psda <- plotApproxStandardDeviation(transactionTimeBoundaryDiffMatrix, label = '�redni czas r�nic granicznych transakcji')
psea <- plotApproxStandardError(transactionTimeBoundaryDiffMatrix, label = '�redni czas r�nic granicznych transakcji')

saveHeatMap(transactionTimeBoundaryDiffHeatMap, 'czas_graniczny')
saveAvgHeatMap(transactionTimeBoundaryDiffForSampleHeatMap, 'czas_graniczny')
savePlotSD(psd, 'czas_graniczny')
savePlotSE(pse, 'czas_graniczny')
savePlotSDA(psda, 'czas_graniczny')
savePlotSEA(psea, 'czas_graniczny')

#Count of blocks
countOfBlocksHeatMap <- prepareHeatMapForMatrix(countOfBlocksMatrix, 'Ilo�� blok�w\npotrzebnych do\nodnalezienia\n100000 po��cze�')
countOfBlocksForSample <- prepareColumnsMeans(countOfBlocksMatrix)
countOfBlocksForSampleHeatMap <- prepareHeatMapForMatrix(countOfBlocksForSample , '�rednia ilo�� blok�w\npotrzebnych do\nodnalezienia\n100000 po��cze�\n dla okresu')
countOfBlocksForSampleHeatMap <- removeBottomTicks(countOfBlocksForSampleHeatMap)

psd <- plotWithStandardDeviation(countOfBlocksMatrix, label = '�rednia ilo�� blok�w potrzebnych do odnalezienia 100000 po��cze�')
pse <- plotWithStandardError(countOfBlocksMatrix, label = '�rednia ilo�� blok�w potrzebnych do odnalezienia 100000 po��cze�')
psda <- plotApproxStandardDeviation(countOfBlocksMatrix, label = '�rednia ilo�� blok�w potrzebnych do odnalezienia 100000 po��cze�')
psea <- plotApproxStandardError(countOfBlocksMatrix, label = '�rednia ilo�� blok�w potrzebnych do odnalezienia 100000 po��cze�')

saveHeatMap(countOfBlocksHeatMap, 'ilosc_blokow') 
saveAvgHeatMap(countOfBlocksForSampleHeatMap, 'ilosc_blokow')  
savePlotSD(psd, 'ilosc_blokow')
savePlotSE(pse, 'ilosc_blokow')
savePlotSDA(psda, 'ilosc_blokow')
savePlotSEA(psea, 'ilosc_blokow')
