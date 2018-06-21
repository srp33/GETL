#!/bin/bash

set -o errexit

downloadDir=Downloads
celDir=CEL
txtDir=TXT

mkdir -p $downloadDir $celDir $txtDir

if [ ! -f GSM.txt ]
then
  python ParseGEOIDs.py GEO_Search_Results.txt > GSM.txt
fi

#for gsm in $(cat GSM.txt)
for gsm in $(head -n 10 GSM.txt)
do
  celFilePath=$celDir/$gsm.CEL.gz

  if [ -f $celFilePath ]
  then
    continue
  fi

  echo $gsm
  Rscript --vanilla download.R $gsm $downloadDir $celFilePath
done
exit

for celFilePath in $celDir/*
do
  sampleID=${celFilePath/\.CEL\.gz/}
  sampleID=$(basename $sampleID)
  txtFilePath=$txtDir/$sampleID

  if [ -f $txtFilePath ]
  then
    continue
  fi

  Rscript --vanilla scanNormalize.R $sampleID $celFilePath $txtFilePath
break

done

exit

function normalize {
  f=$1

  datasetId=$(dirname $f)
  datasetId=$(dirname $datasetId)
  datasetId=$(basename $datasetId)

  sampleId=$(basename $f)
  sampleId=${sampleId/\.gz/}
  sampleId=${sampleId/\.CEL/}

  if [[ "$sampleId" == "GSM125119" ]]
  then
    echo $f
    echo This sample will be skipped because it has a known quality issue.
    return
  fi
  if [[ "$sampleId" == "GSM125120" ]]
  then
    echo $f
    echo This sample will be skipped because it has a known quality issue.
    return
  fi

  scanOutputDirPath=Expression_Data/${datasetId}/Processed/scan
  scanOutputFilePath=$scanOutputDirPath/${sampleId}
  upcOutputDirPath=${scanOutputDirPath/scan/upc}
  upcOutputFilePath=$upcOutputDirPath/${sampleId}

  if [[ ! -e $upcOutputFilePath ]]
  then
    mkdir -p $(dirname $scanOutputFilePath) $(dirname $upcOutputFilePath)

#    sbatch ./Expression_Scripts/scanNormalization $sampleId $datasetId $f $scanOutputFilePath $upcOutputFilePath
  fi
}

for datasetId in GSE10320 GSE15296 GSE19804 GSE20189 GSE21510 GSE25507 GSE27854 GSE30784 GSE32646 GSE37147 GSE37199 GSE37745 GSE38958 GSE39491 GSE40292 GSE4271 GSE46449 GSE46691 GSE5460 GSE27342 GSE63885 GSE43176 GSE30219 GSE37892 GSE27279 GSE58697 GSE1456 GSE6532 GSE26682 GSE2109 GSE5462 GSE20181 GSE46995 GSE39582
do
  downloadDir=Expression_Data/$datasetId/Unprocessed
  mkdir -p $downloadDir
  if [ "$(ls -A $downloadDir)" ]
  then
    echo $datasetId already downloaded.
  else
    echo Downloading $datasetId
    Rscript --vanilla Expression_Scripts/download.R $datasetId $downloadDir
    gzipFixFileNames $downloadDir
    break
  fi
done

Rscript --vanilla Expression_Scripts/installBrainArray.r

for f in Expression_Data/*/Unprocessed/*.CEL.gz
do
  if [[ $f == *"GSE46995"* ]]
  then
    continue
  fi

  normalize $f
  break
done

#for f in Expression_Data/GSE46995/Unprocessed/*.CEL.gz
#do
#  usePlatform=$(Rscript --vanilla Expression_Scripts/UsePlatform.R $f)
#
#  echo $f
#
#  if [[ "$usePlatform" == "[1] FALSE" ]]
#  then
#    echo This sample is on a platform that is not supported for this study.
#    return
#  else
#    normalize $f
#  fi
#done

# Run one sample per data set interactively so that CDF files are downloaded

for d in Expression_Data/*
do
  for f in $d/Unprocessed/*.CEL*
  do
    outFile=${f/Unprocessed/QualityScores}
    outFile=${outFile/\.CEL\.gz/}

    if [ ! -f $outFile ]
    then
      echo $f
      ./Expression_Scripts/checkQuality $f $outFile
    fi

    break # So we only process one sample per data set
  done
break
done

# When executing the next part, use nohup. Example: nohup ./executeNormalization &

for f in Expression_Data/*/Unprocessed/*.CEL*
do
  outFile=${f/Unprocessed/QualityScores}
  outFile=${outFile/\.CEL\.gz/}

  if [ ! -f $outFile ]
  then
    echo $f
    sbatch ./Expression_Scripts/checkQuality $f $outFile
    sleep 15
    break
  fi
done

# Concatenate all Score Files
tail -q -n 1 Expression_Data/*/QualityScores/* >> QualityScoresAll.txt
