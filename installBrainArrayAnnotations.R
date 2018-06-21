library(SCAN.UPC)

tmpDir = tempdir()
tmpFile <- paste0(tmpDir, '/GSM494556.CEL.gz')
download.file('https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSM494556&format=file&file=GSM494556%2ECEL%2Egz', tmpFile)
InstallBrainArrayPackage(tmpFile, "20.0.0", "hs", "ensg")
