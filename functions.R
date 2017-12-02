setwd("D:/PWR/mgr/PracaMagisterska/R")
pathTime = '/time'
pathCoins = '/coins'
pathFull = '/full'
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
  path <- getPath(pathFull,sampleIndex)
  cat('Start analyse of sample ', path, sep = separator)
  cat('\n')
  return(path)
}

getTimePath <- function(sampleIndex) {
  path <- getPath(pathTime,sampleIndex)
  cat('Start analyse of sample ', path, sep = separator)
  cat('\n')
  return(path)
}

getPath <- function(pathSuffix, sampleIndex) {
  return(paste(pathBase, sampleIndex , pathSuffix, sep = separator))
}

prepareDiagonalMatrix <- function(count) {
  return(matrix(nrow = count, ncol = filecount))
}

readFilesNames <- function(path, count) {
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

readFile <- function(filename) {
  return(read.csv2(filename, sep=" ", header = F))  
}

readResultFile <- function(filename) {
  matrix <- read.csv2(paste(pathResult, filename, sep = separator), dec = ".", 
                      sep=" ", header = F, stringsAsFactors=FALSE, as.is=T)
  rownames(matrix) <- paste('T', 1:10, sep = getSeparator())
  colnames(matrix) <- c("2015-03-31", "2015-06-30","2015-09-30","2015-12-31","2016-03-31","2016-06-30","2016-09-30",'2016-12-31','2017-03-31','2017-06-30')
  matrix <- as.matrix(matrix)
  matrix <- specifDecimal(matrix)
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

prepareHeatMapForMatrix <- function(matrix, name) {
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
    geom_text(aes(Var2, Var1, label = value), color = "black", size = 2.5) +
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

