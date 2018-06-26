#!/bin/bash

#set -o errexit

celDir=CEL
txtDir=TXT
tmpFile=/tmp/getl_normalize

mkdir -p $celDir $txtDir

rm -f $tmpFile

for celFilePath in $celDir/*
do
  sampleID=${celFilePath/\.CEL\.gz/}
  sampleID=$(basename $sampleID)
  txtFilePath=$txtDir/$sampleID

  if [ -f $txtFilePath.gz ]
  then
    continue
  fi

  echo "Rscript --vanilla scanNormalize.R $sampleID $celFilePath $txtFilePath; gzip $txtFilePath" >> $tmpFile
done

if [ -f $tmpFile ]
then
  chmod 777 $tmpFile
  parallel -a $tmpFile --ungroup --max-procs 40
  rm -f $tmpFile
fi
