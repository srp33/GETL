#!/bin/bash

#set -o errexit

downloadDir=Downloads
celDir=CEL
txtDir=TXT

mkdir -p $downloadDir $celDir

if [ ! -f GSM.txt ]
then
  python ParseGEOIDs.py GEO_Search_Results.txt > GSM.txt
fi

function tryDownload {
  #for gsm in $(cat GSM.txt)
  for gsm in $(head -n 50000 GSM.txt)
  do
    celFilePath=$celDir/$gsm.CEL.gz
    txtFilePath=$txtDir/$gsm.gz

    if [ -f $celFilePath ]
    then
      continue
    fi

    if [ -f $txtFilePath ]
    then
      continue
    fi

    echo $gsm
    mkdir -p $downloadDir/$gsm
    timeout 10 Rscript --vanilla download.R $gsm $downloadDir/$gsm $celFilePath
    rm -rf $downloadDir/$gsm
    sleep 1
  done
}

for i in {1..10}
do
  tryDownload
  sleep 120
done
