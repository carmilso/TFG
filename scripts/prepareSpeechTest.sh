#!/bin/bash

# EXAMPLE USAGE: ./prepareSpeechTest.sh ../logs/test1_en_speech.txt

filename=$(echo $1 | sed 's/.*\/\(.*\)/\1/')
lang_tmp=${filename#*_}
lang=${lang_tmp%_*}

sed "s/^\s\+//g" $1 | \
sed "/^$/d" | \
sed "s/[.,/*()¡!?¿;]//g" | \
sed "s/\([0-9]\+\)-\([0-9]\+\)/\1 \2/g" | \
./formatNumbers_$lang.py > /tmp/$filename

awk 'NR==FNR { d[tolower($0)]=$0; next } {
  for (i = 1; i <= NF; i++) {
    lowerword = tolower($i)
    if ( d[lowerword] ) trgt = d[lowerword]
    else trgt = lowerword
    print trgt "\tB_null"
  }
  print ".\t0\n"
}' ../dictionary /tmp/$filename
