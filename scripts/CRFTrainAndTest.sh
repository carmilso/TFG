#!/bin/bash

# EXAMPLE USAGE: ./CRFTrainAndTest.sh

for f in $(ls ../crf/ | grep -E '(en|fr)_\w+_CRF_train'); do
  lang=${f%%_*}
  translator_aux=${f#*_}
  translator=${translator_aux%%_*}
  model="model_"$lang"_"$translator
  filename=$translator\_$lang
  echo "Training CRF model for $translator (lang $lang) ..."
  crf_learn ../template_crf ../crf/$f ../crf/$model
  # printf "Testing CRF model of $translator (lang $lang) ...\t"
  # crf_test -m ../crf/$model ../logs/test1_$lang\_text_prepared.log > ../crf/test_$filename\_text.log
  # crf_test -m ../crf/$model ../logs/test1_$lang\_speech_prepared.log > ../crf/test_$filename\_speech.log
  printf "Ok!\n"
done

for f in $(ls ../crf/ | grep -E '(en|fr)_CRF_train'); do
  lang=${f%%_*}
  model="model_"$lang"_allTranslators"
  filename=$lang\_allTranslators
  echo "Training CRF model for all translators (lang $lang) ..."
  crf_learn template_crf crf/$f crf/$model
  # printf "Testing CRF model of all translators (lang $lang) ...\t"
  # crf_test -m ../crf/$model ../logs/test1_$lang\_text_prepared.log > ../crf/test_$filename\_text.log
  # crf_test -m ../crf/$model ../logs/test1_$lang\_speech_prepared.log > ../crf/test_$filename\_speech.log
  printf "Ok!\n"
done
