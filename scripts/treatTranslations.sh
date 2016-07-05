#!/bin/bash

# EXAMPLE USAGE: ./treatTranslations.sh

set -o pipefail

function printStatus {
  if [ $? -eq 0 ]; then
    printf "Ok!\n"
  else
    printf "Failed!\n"
    exit 1
  fi
}

if [ ! -d ../logs/backup ]; then
  mkdir ../logs/backup
fi

for f in $(ls ../logs/ | grep -E '\w+_(en|fr).log'); do
  printf "Processing $f ...\t"
  lang_tmp=${f#*_}
  lang=${lang_tmp%.*}
  mv ../logs/$f ../logs/backup/$f.bak;
  awk 'NR==FNR { d[NR-1]=$0; next } {
    head = ""
    tail = tolower($0)
    while ( match(tail,/\(+[0-9]+\)+/) ) {
      trgt = substr(tail,RSTART,RLENGTH)
      gsub(/[()]/,"",trgt)
      head = head substr(tail,1,RSTART-1) d[trgt]
      tail = substr(tail,RSTART+RLENGTH)
    }
    print head tail
  }' ../dictionary ../logs/backup/$f.bak | \
  sed "s/[#.,/*()¡!?¿;]//g" | \
  sed "s/^\s\+//g" | \
  sed "/^$/d" | \
  sed "s/\([0-9]\)h\([0-9]\)/\1:\2/g" | \
  sed "s/\([0-9]\+:\?[0-9]*\)-à\?-\?\([0-9]\+:[0-9]\+\)/\1 à \2/g" | \
  sed "s/\s00\s/ 12:00 /g" | \
  sed "s/\([^0-9]\s*\):\s*\(.*\)/\1\2/g" | \
  sed "s/\([0-9]\+\)\s*:\s*\([0-9]\+\)/\1:\2/g" | \
  sed "s/\([a-zA-Z]\+\)'\s\+\([a-zA-Z]\+\)/\1'\2/g" | \
  ./formatNumbers_$lang.py > ../logs/${f%.*}_treated.log
  printStatus
done
