#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
EXAMPLE USAGE: ./computeSegments.py ../logs/google_en_treated.log | ./computeTags.py
'''

import sys
import codecs
import fileinput
from string import *

UTF8Reader = codecs.getreader('utf-8')
sys.stdin = UTF8Reader(sys.stdin)


tags = codecs.open('../segment_tags', 'r', 'utf-8').readlines()

for line in fileinput.input():
  line = line.split('|')
  for segment in line:
    segment = segment.split()
    tag = tags.pop(0)
    if len(segment):
      for word in xrange(len(segment)):
        if not word:
          print strip(segment[word] + '\tB_' + tag)
        else:
          print strip(segment[word] + '\tI_' + tag)
  print '.\t0\n'
