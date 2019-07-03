#!/bin/bash

set -o errexit

rowDir=Rows
matrixDir=Matrices
matrixFile=$matrixDir/GEO_GPL570_SCAN_$(ls $rowDir | wc -l)samples_$(date +%Y-%m-%d).tsv

mkdir -p $matrixDir
rm -f $matrixFile

zcat $rowDir/.header.gz > $matrixFile

#for f in $rowDir/*.gz
for f in $(ls $rowDir | head -n 1000)
do
  #zcat $f >> $matrixFile
  zcat $rowDir/$f >> $matrixFile
done

gzip $matrixFile
