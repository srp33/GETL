#!/bin/bash

set -o errexit

txtDir=TXT
rowDir=Rows

mkdir -p $rowDir
#rm -f $rowDir/*

firstFile=$(for f in TXT/*; do echo $f; break; done | head -n 1)

#for f in $(ls $txtDir/*.gz | head)
for f in $txtDir/*.gz
do
  sample=$(basename $f)
  sample=${sample/\.gz/}

  if [ ! -f $rowDir/$sample.gz ]
  then
    echo $sample
    python BuildMatrixRow.py $f $firstFile $rowDir/.header.gz $rowDir/$sample.gz
  fi
done
