#!/bin/bash

set -o errexit

rowDir=Rows
matrixDir=Matrices
matrixFile=$matrixDir/GEO_GPL570_SCAN_$(ls $rowDir | wc -l)samples_$(date +%Y-%m-%d).tsv.gz

mkdir -p $matrixDir
rm -f $matrixFile

cp $rowDir/.header.gz $matrixFile

for f in $rowDir/*.gz
do
  zcat $f | gzip >> $matrixFile
done
