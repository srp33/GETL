#!/bin/bash

set -o errexit

txtDir=TXT
matrixDir=Matrices
matrixFile=$matrixDir/GEO_GPL570_SCAN_$(ls $txtDir | wc -l)samples_$(date +%Y-%m-%d).tsv.gz

mkdir -p $matrixDir
rm -f $matrixFile

firstFile=$(ls $txtDir/*.gz | head -n 1)

for f in $txtDir/*.gz
#for f in $(ls $txtDir/*.gz | head)
do
  echo $f
  python BuildMatrix.py $f $firstFile $matrixFile
done
