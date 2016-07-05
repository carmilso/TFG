#!/bin/bash

# EXAMPLE USAGE: ./generateCRFTrain.sh

set -o pipefail

function printStatus {
  if [ $? -eq 0 ]; then
    printf "Ok!\n"
  else
    printf "Failed!\n"
    exit 1
  fi
}

if [ ! -d ../crf ]; then
  mkdir ../crf
fi;

rm ../crf/{en,fr}_CRF_train 2> /dev/null

for f in $(ls ../logs/ | grep -E '\w+_(en|fr)_treated.log'); do
  printf "Producing CRF train file for $f ...\t"
  translator=${f%%_*}
  lang_tmp=${f#*_}
  lang=${lang_tmp%_*}
  ./computeSegments.py ../logs/$f | \
  ./computeTags.py | \
  tee ../crf/$lang\_$translator\_CRF_train | \
  tee -a ../crf/$lang\_CRF_train 1> /dev/null
  printStatus
done
