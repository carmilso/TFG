#!/bin/bash

# EXAMPLE USAGE: ./toHtmlFormat.sh index.log

file="$1"
format=${2:-"utf-8"}

cat $file | \
  sed "s/^/<p>/" | \
  sed "s/$/<\/p>/" | \
  sed "1i<HTML>\n<HEAD>\n<meta charset=$format>" | \
  sed "\$a</HEAD>\n</HTML>"
