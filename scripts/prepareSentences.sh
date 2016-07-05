#!/bin/bash

# EXAMPLE USAGE: ./prepareSentences.sh ../dihana.log

printf "Processing ...\t" 1>&2

awk 'NR==FNR { d[$0]=NR-1; next } {
  output = ""
  found = 0
  if ( match($0, /U[[:digit:]]+:(.*)/, m) ) {
    print "|||"
    found = 1
  }
  else if ( match($0, /([[:upper:]]?[[:lower:]]+.*):.*/, m) ) {
    found = 1
  }
  if (found) {
    $0 = m[1]
    for (i = 1; i <= NF; i++) {
      if ( d[$i] ) output = output " ((" d[$i] "))"
      else output = output " " $i
    }
    gsub(/^[ \t]+/, "", output)
    print output
  }
}' ../dictionary $1

printf "Ok!\n" 1>&2
