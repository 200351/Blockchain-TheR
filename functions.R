setwd("D:/PWR/mgr/PracaMagisterska/R")
pathTimes = '/time'
pathCoins = '/coins'
pathFulls = '/full'
pathBase = 'data/100000/Sample_'
pathResult = 'D:/PWR/mgr/PracaMagisterska/R/results/'
separator = ""

getSeparator <- function() {
  return(separator)
}

getCoinsPath <- function(sampleIndex) {
  path <- getPath(pathCoins,sampleIndex)
  cat('Start analyse of sample ', path, sep = separator)
  cat('\n')
  return(path)
}

getFullPath <- function(sampleIndex) {
  path <- getPath(pathFulls,sampleIndex)
  cat('Start analyse of sample ', path, sep = separator)
  cat('\n')
  return(path)
}

getTimePath <- function(sampleIndex) {
  path <- getPath(pathTimes,sampleIndex)
  cat('Start analyse of sample ', path, sep = separator)
  cat('\n')
  return(path)
}

getPath <- function(pathSuffix, sampleIndex) {
  path <- paste(pathBase, sampleIndex , pathSuffix, sep = separator)
  return(path)
}

prepareDiagonalMatrix <- function(count) {
  return(matrix(nrow = count, ncol = filecount))
}

readFilesNames <- function(path, count=10) {
  filenames <- list.files(path, pattern="*.csv", all.files = TRUE,
                              full.names = TRUE, recursive = FALSE,
                              ignore.case = TRUE)
  
  details = file.info(filenames)
  details = details[with(details, order(as.POSIXct(mtime))), ]
  filenames = rownames(details)
  cat(length(filenames), ' files found in ', path, sep = separator)
  cat('\n')
  filenames = filenames[1:count]
  cat(length(filenames), ' files used ',sep = separator)
  cat('\n')
  return(filenames)
}

readFile <- function(filename, reverseDirection=FALSE) {
  dfBlockchain <- read.csv2(filename, sep=" ", header = F,  dec = ".", stringsAsFactors=FALSE, as.is=T)
  if (reverseDirection) {
    left <- dfBlockchain[,1]
    right <- dfBlockchain[,2]
    dfBlockchain[,1] <- right
    dfBlockchain[,2] <- left
  }
  return(dfBlockchain)
}

readResultFile <- function(filename, specifDecimal = TRUE) {
  matrix <- read.csv2(paste(pathResult, filename, sep = separator), dec = ".", 
                      sep=" ", header = F, stringsAsFactors=FALSE, as.is=T)
  rownames(matrix) <- paste('T', 1:10, sep = getSeparator())
  colnames(matrix) <- c("2015-03-31", "2015-06-30","2015-09-30","2015-12-31","2016-03-31","2016-06-30","2016-09-30",'2016-12-31','2017-03-31','2017-06-30')
  if(specifDecimal) {
    matrix <- as.matrix(matrix)
    matrix <- specifDecimal(matrix)
  }
  return(matrix)  
}

specifDecimal <- function(matrix) {
  for(i in 1:ncol(matrix)){
    for(j in 1:nrow(matrix)){
      if (!is.na(matrix[j,i])) matrix[j,i]  <- as.numeric(format(round(matrix[j,i], 2), nsmall = 2))
    }
  }
  return(matrix)
}

writeToFile <- function(filename, toWrite) {
  setwd("D:/PWR/mgr/PracaMagisterska/R")
  filePath <- paste(pathResult, filename, sep = separator)
  cat('Write to file ', filePath, sep = separator)
  cat('\n')
  write.table(toWrite, file = filePath, sep = " ", row.names = FALSE, col.names = FALSE)
  #unlink(filePath)
}

number_ticks <- function(n) {function(limits) pretty(limits, n)}

prepareHeatMapForMatrix <- function(matrix, name, numsize = 3) {
  library(reshape2)
  matrixCorr <- melt(matrix, na.rm = FALSE)
  matrixCorr[,3] <- as.numeric(matrixCorr[,3])
  for (j in 1:length(matrixCorr[,3])) {
    if (is.infinite(matrixCorr[j,3])) matrixCorr[j,3] <- NA
  }
  # Heatmap
  valuesWithoutNAandInf <- na.omit(matrixCorr[,3])
  library(ggplot2)
  maxInMatrix <- max(valuesWithoutNAandInf)
  minInMatrix <- min(valuesWithoutNAandInf)
  midPoint <- ((as.numeric(maxInMatrix) - as.numeric(minInMatrix)) / 2)
  heatMap <- ggplot(data = matrixCorr, aes(Var2, Var1, fill = value))+
    geom_tile(color = "orange") +
    scale_fill_gradient2(low = "white", high = "red", mid = "orange", na.value = 'black',
                         midpoint = midPoint, limit = c(minInMatrix,maxInMatrix), space = "Lab", 
                         name=name) +
    theme_minimal()+
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, 
                                     size = 10, hjust = 1)) +
    coord_fixed() + 
    geom_text(aes(Var2, Var1, label = value), color = "black", size = numsize) +
    theme(
      axis.title.x = element_blank(),
      axis.title.y =  element_blank(),
      panel.grid.major = element_blank(),
      panel.border = element_blank(),
      panel.background = element_blank(),
      axis.ticks = element_blank())
  return(heatMap)
}



prepareColumnsMeans <- function(matrix) {
  return(colMeans(matrix, na.rm = TRUE))
}

prepareColumnsMeans <- function(matrix) {
  row <- matrix(colMeans(matrix, na.rm = TRUE))
  row <- specifDecimal(row)
  rownames(row) <- c("2015-03-31", "2015-06-30","2015-09-30","2015-12-31","2016-03-31","2016-06-30","2016-09-30",'2016-12-31','2017-03-31','2017-06-30')
  return(row)
}

removeBottomTicks <- function(heatMap) {
  return(heatMap + theme(axis.title.x=element_blank(),
                         axis.text.x=element_blank(),
                         axis.ticks.x=element_blank())) 
}

avg.transaction.value <- function(valueColumn) {
  numericValues <- as.numeric(valueColumn)
  avg <- mean(numericValues)
  avg <- as.numeric(format(round(avg, 2), nsmall = 2))
  return(avg)
}

avg.transaction.period <- function(times) {
  valueColumn <- as.numeric(times[,3])
  valueColumn <- sort(valueColumn, decreasing=TRUE)
  periods <- vector(length = (length(valueColumn) - 1), mode = 'numeric')
  i <- 1
  length <- length(valueColumn)
  while(i < length) {
    period <- valueColumn[i] - valueColumn[i + 1]
    if (period < 0) {
      cat(paste(i, '. Period diffrence less then 0:', times[1,2]))
    }
    periods[i] <- abs(period)
    i <- i + 1
  }
  avg <- mean(periods)
  avg <- as.numeric(format(round(avg, 2), nsmall = 2))
  return(avg)
}

blocksCount <- function(matrix) {
  inputBlockHash <- matrix[,3]
  outputBlockHash <- matrix[,4]
  all <- append(inputBlockHash, outputBlockHash)
  all <- unique(all)  
  count <- length(all)
  return(count)
}

transaction.boundaryDiff <- function(times) {
  valueColumn <- as.numeric(times[,3])
  diff <- valueColumn[1] - valueColumn[length(valueColumn)]
  if (diff < 0) {
    cat(paste('Boundary diffrence less then 0: ', times[1,2]))
  }
  diff <- abs(diff)
  return(diff)
}

toHumanTime <- function(data, SHORT= TRUE) {
  library(lubridate)
  result <- matrix(nrow = nrow(data), ncol = ncol(data))
    for(i in 1:ncol(data)){
      for(j in 1:nrow(data)) {
        td <- seconds_to_period(data[j,i])
        if (SHORT) {
          result[j,i] <- sprintf('%02d:%02.2fs', minute(td), second(td))
        } else {
          result[j,i] <- sprintf('%02d %02d:%02d:%02.2f', day(td), td@hour, minute(td), second(td))
        }
      }
    }
  return(result)
}

plotWithStandardDeviation <- function(matrix, label = "VALUE", title = "TITLE") {
  library(reshape2)
  library(ggplot2)
  library(Rmisc)
  pd <- position_dodge(0.1) # move them .05 to the left and right
  matrixCorr <- melt(matrix, na.rm = FALSE)
  tgc <- summarySE(matrixCorr, measurevar="value", groupvars=c("Var2"))
  ggToPlot = ggplot(tgc, aes(x=Var2, y=value, colour = 1, group = 1)) + 
    geom_errorbar(aes(ymin=value-sd, ymax=value+sd), colour="black", width=.1, position=pd) +
    geom_line(position=pd) +
    geom_point(position=pd, size=3, shape=21, fill="white") + #is filled circle
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, 
                                     size = 10, hjust = 1))+  
    xlab("Czas") +
    ylab(label) +
    theme(legend.position="none")
  return(ggToPlot)
}

plotApproxStandardDeviation <- function(matrix, label = "VALUE", title = "TITLE") {
  library(reshape2)
  library(ggplot2)
  library(Rmisc)
  pd <- position_dodge(0.1) # move them .05 to the left and right
  matrixCorr <- melt(matrix, na.rm = FALSE)
  tgc <- summarySE(matrixCorr, measurevar="value", groupvars=c("Var2"))
  ggToPlot = ggplot(tgc, aes(x=Var2, y=value, colour = 1, group = 1)) + 
    geom_errorbar(aes(ymin=value-sd, ymax=value+sd), colour="black", width=.1, position=pd) +
    stat_summary(fun.data=mean_cl_normal) + 
    geom_smooth(method='lm',formula=y~x, se = FALSE) +
    geom_point(position=pd, size=3, shape=21, fill="white") + #is filled circle
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, 
                                     size = 10, hjust = 1))+  
    xlab("Czas") +
    ylab(label) +
    theme(legend.position="none")
  return(ggToPlot)
}

plotWithStandardError <- function(matrix, label = "VALUE", title = "TITLE") {
  library(reshape2)
  library(ggplot2)
  library(Rmisc)
  pd <- position_dodge(0.1) # move them .05 to the left and right
  matrixCorr <- melt(matrix, na.rm = FALSE)
  tgc <- summarySE(matrixCorr, measurevar="value", groupvars=c("Var2"))
  ggToPlot = ggplot(tgc, aes(x=Var2, y=value, colour = 1, group = 1)) + 
    geom_errorbar(aes(ymin=value-se, ymax=value+se), colour="black", width=.1, position=pd) +
    geom_line(position=pd) +
    geom_point(position=pd, size=3, shape=21, fill="white") + #is filled circle
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, 
                                     size = 10, hjust = 1))+  
    xlab("Czas") +
    ylab(label) +
    theme(legend.position="none")
  return(ggToPlot)
}

plotApproxStandardError <- function(matrix, label = "VALUE", title = "TITLE") {
  library(reshape2)
  library(ggplot2)
  library(Rmisc)
  library(Hmisc)
  
  pd <- position_dodge(0.1) # move them .05 to the left and right
  matrixCorr <- melt(matrix, na.rm = FALSE)
  tgc <- summarySE(matrixCorr, measurevar="value", groupvars=c("Var2"))
  ggToPlot = ggplot(tgc, aes(x=Var2, y=value, colour = 1, group = 1)) + 
    geom_errorbar(aes(ymin=value-se, ymax=value+se), colour="black", width=.1, position=pd) +
    stat_summary(fun.data=mean_cl_normal) + 
    geom_smooth(method='lm',formula=y~x, se = FALSE) +
    geom_point(position=pd, size=3, shape=21, fill="white") + #is filled circle
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, 
                                     size = 10, hjust = 1))+  
    xlab("Czas") +
    ylab(label) +
    theme(legend.position="none")
  return(ggToPlot)
}

makeDir <- function(name) {
  directory <- paste('D:/PWR/mgr/PracaMagisterska/R/charts/', name, sep = "")
  if (dir.exists(directory) == FALSE) {
    dir.create(directory)
  }
}

saveHeatMap <- function(plot, name) {
  makeDir(name)
  savePlot(plot, dpi = 600, paste(name , '/', name, "_hm", sep = ""), height = 150)
}

saveAvgHeatMap <- function(plot, name) {
  makeDir(name)
  savePlot(plot, dpi = 600,  paste(name , '/', name,"_avg_hm", sep = ""))
}

savePlotSD <- function(plot, name) {
  makeDir(name)
  savePlot(plot,  paste(name , '/', name, "_sd", sep = ""), height = 110)
}
savePlotSE <- function(plot, name) {
  makeDir(name)
  savePlot(plot,  paste(name , '/', name,"_se", sep = ""), height = 110)
}

savePlotSDA <- function(plot, name) {
  makeDir(name)
  savePlot(plot,  paste(name , '/', name, "_sda", sep = ""), height = 110)
}
savePlotSEA <- function(plot, name) {
  makeDir(name)
  savePlot(plot,  paste(name , '/', name, "_sea", sep = ""), height = 110)
}
saveHistogram <- function(plot, name) {
  makeDir(name)
  savePlot(plot,  paste(name , '/', name, "_hist", sep = ""), height = 45)
}

savePlot <- function(plot, name = "name", dpi=1200, width = 180, height = 180) {
  ggsave(plot = plot, filename = paste("D:/PWR/mgr/PracaMagisterska/R/charts/", name, ".png", sep = ""), 
         dpi = dpi, width = width, height = height, units = "mm", limitsize = FALSE)
  
}

plotHistogram <- function(matrix, xlab =  '�rednica' , ylab = 'Ilo�� wyst�pie�', 
                          y_ticks = 2, x_ticks = 4, hist_breaks = 1) {
  library(reshape2)
  library(ggplot2)
  matrixCorr <- melt(matrix, na.rm = FALSE)
  ggplot(data=matrixCorr, aes(matrixCorr$value)) + 
    geom_histogram(breaks=seq(0, max(matrix), by = hist_breaks), 
                   col="black", 
                   fill="grey") + 
   # coord_fixed() + 
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, 
                                     size = 10, hjust = 1)) + 
    labs(x=xlab, y=ylab)+
    scale_x_continuous(limits = c(0,(max(matrix))), breaks =  seq(0,max(matrix), x_ticks)) +
    scale_y_continuous(breaks =  seq(0,100000,y_ticks))
}


