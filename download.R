GSMID <- commandArgs()[7]
downloadDir <- commandArgs()[8]
outFilePath <- commandArgs()[9]

suppressPackageStartupMessages(library(GEOquery))
  
downloaded <- getGEOSuppFiles(GSMID, makeDirectory=FALSE, baseDir=downloadDir)
downloadedFilePath <- rownames(downloaded)[1]
success <- file.rename(downloadedFilePath, outFilePath)

#  # We would expect to find a tar file at this location if the download was successful
#  tarFilePath = file.path(tmpDir, paste(GEOID, "_RAW.tar", sep=""))
#
#  if (!file.exists(tarFilePath))
#    stop(paste("No raw data files could be downloaded from GEO for ", GEOID, sep=""))
#
#  # Unpack the tar file
#  dir.create(downloadDir, recursive=TRUE)
#  untar(tarFilePath, exdir=downloadDir)
#
#  # Get list of raw file names that were unpacked
#  inFilePattern = file.path(downloadDir, expectedFilePrefixPattern, sep="")
#  
#  # Reformat the file names for special characters
#  inFileNamePattern = sub("\\-", "\\\\-", glob2rx(basename(inFilePattern)))
#  inFileNamePattern = sub("\\+", "\\\\+", inFileNamePattern)
#
#  # Get the full file paths and make sure we don't have duplicates
#  inFilePaths = list.files(path=dirname(inFilePattern), pattern=inFileNamePattern, full.names=TRUE, ignore.case=TRUE)
#  inFilePaths = unique(inFilePaths)
#
#  # Create the output directory if it doesn't already exist  
#  if (!dir.exists(outputDirPath))
#    dir.create(outputDirPath)
#  
#  # Copy each file to the output directory
#  for (inFilePath in inFilePaths)
#  {
#    file.copy(inFilePath, outputDirPath)
#    print(paste("File copied to ", outputDirPath, "/", basename(inFilePath), sep=""))
#  }
#}
#
#print(paste("GEOID: ", GEOID, sep = ""))
#print(paste("Output directory path: ", outputDirPath, sep = ""))
#
#downloadFromGEO(GEOID, outputDirPath)
