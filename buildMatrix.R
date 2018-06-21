library(dplyr)
library(readr)

clinicalFilePath <- commandArgs()[7] # Samples.txt file
lowQualitySamplesFilePath <- commandArgs()[8] # PoorQualitySamples.txt file
duplicateSamplesFilePath <- commandArgs()[9]
outFilePath <- commandArgs()[10] 
inDirPath <- commandArgs()[11] # Expression Data

print(clinicalFilePath)
print(lowQualitySamplesFilePath)
print(outFilePath)
print(inDirPath)

# read clinical file and loop through sample ID
clinicalFile <- read_tsv(clinicalFilePath)
sampleIDs <- as.vector(clinicalFile$Samples)

lowQualitySamples <- read_tsv(lowQualitySamplesFilePath)
duplicateSamples <- read_tsv(duplicateSamplesFilePath)

mergedData <- NULL

for (sampleID in sampleIDs)
{
print(sampleID)
# somewhere in here, need to ignore low quality samples
  if (!sampleID %in% duplicateSamples$Sample_ID) {
    if (!sampleID %in% lowQualitySamples$Sample_ID) {
      inFilePath <- paste(inDirPath, sampleID, sep="/")
      inFileData <- read_tsv(inFilePath)

      if (is.null(mergedData)) {
        mergedData <- inFileData
      } else {
        mergedData <- inner_join(mergedData, inFileData)
      }
    } else {
      print(paste(sampleID, " is excluded due to low quality score", sep=""))
    }
  } else {
    print(paste(sampleID, " is excluded due to duplicates", sep=""))
  }
}

mergedData <- as.data.frame(mergedData)

rownames(mergedData) <- mergedData$X
mergedData <- mergedData[,-1]

dataMatrix <- as.matrix(mergedData)
dataMatrix <- t(dataMatrix)

#head(dataMatrix[1:5,1:5])

write.table(dataMatrix, outFilePath, quote = F, sep = "\t", col.names = NA, row.names = T)

# convert to a regular data frame
# set the row names to the values in the first column (gene names)
# exclude the first column
# convert to matrix
# transpose (t function)
# hopefully row names and col names still in tact
# write_table to save the data outFilePath
