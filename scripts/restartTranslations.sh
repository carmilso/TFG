#!/bin/bash

# EXAMPLE USAGE: ./restartTranslations.sh

if [ $(ls ../logs | grep _treated | wc -l) -eq 0 ]; then exit 1; fi

for f in $(ls ../logs/ | grep -E '\w+_(en|fr)_treated.log'); do
  f_bak=${f%_*}.log
  rm ../logs/$f
  mv ../logs/backup/$f_bak.bak ../logs/$f_bak
done

rm -r ../logs/backup

echo "Ok!"
