#!/bin/bash

# EXAMPLE USAGE: ./prepareTextTest.sh ../logs/test1_en_text_1000.txt

filename=$(echo $1 | sed 's/.*\/\(.*\)/\1/')

sed "s/U[0-9]\+:\(.*\)/\1/g" $1 | \
sed "s/[.,/*()¡!?¿;]//g" > /tmp/$filename

awk 'NR==FNR { d[$0]=NR-1; next } {
  for (i = 1; i <= NF; i++) {
    if ( d[$i] ) trgt = $i
    else trgt = tolower($i)
    print trgt "\tB_null"
  }
  print ".\t0\n"
}' ../dictionary /tmp/$filename
