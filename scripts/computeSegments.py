#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
EXAMPLE USAGE: ./computeSegments.py ../logs/google_en_treated.log
'''

import sys
import codecs
from string import *

DEBUG=0

def getSegments(sentence, segments):
  segmentation = []
  vertical = sentence.split()
  horizontal = ' '.join(segments).split()
  limits = ' |'.join(segments).split()
  lenX = len(horizontal)
  lenY = len(vertical)

  def levenshtein_distance():
    D, B = {}, {}
    D[0, 0], B[0, 0] = 0, None

    for i in xrange(1, lenY+1):
      D[i, 0], B[i, 0] = D[i-1, 0] + 1, (i-1, 0)

    for j in xrange(1, lenX+1):
      D[0, j], B[0, j] = D[0, j-1] + 1, (0, j-1)

      for i in xrange(1, lenY+1):
        D[i, j], B[i, j] = min( (D[i, j-1]+1, (i, j-1)), (D[i-1, j]+1, (i-1, j)), (D[i-1, j-1]+(vertical[i-1] != horizontal[j-1]), (i-1, j-1)) )

    return D[lenY, lenX], D, B

  def checkLimit(i, j, iaux, jaux):
    return len(limits) > jaux and limits[jaux].startswith('|')

  def buildSegments(B):
    i, j = lenY, lenX

    while B[i, j]:
      iaux, jaux = B[i, j]
      if iaux == i-1 and jaux == j-1: # substitution
        segmentation.insert(0, vertical[iaux])
      elif iaux == i-1 and jaux == j: # insertion
        if len(segmentation) > 0 and segmentation[0] == '|':
          segmentation.pop(0)
        segmentation.insert(0, vertical[iaux])
      elif iaux == i and jaux == j-1: # deletion
        pass
      if checkLimit(i, j, iaux, jaux):
        segmentation.insert(0, '|')

      i, j = iaux, jaux

  cost, D, B = levenshtein_distance()
  buildSegments(B)
  if DEBUG:
    print '-----------------------------------------------------'
    print 'Sentence:', sentence.rstrip('\n')
    print 'Segments:', segments
    print '\nSegmentation Result:', ' '.join(segmentation), '\n'
    print '\nCost Matrix:', D
    print 'Path Matrix:', B
    print 'Final Cost', cost

  return ' '.join(segmentation)

def getNextSentence(tr):
  segments = []
  sentence = ""
  if not len(tr):
    return None, None
  elif tr[0].strip('\n') != '|||':
    print 'ERROR!'
    sys.exit(1)
  else:
    tr.pop(0)
    sentence = tr.pop(0)
    while len(tr) and tr[0].strip('\n') != '|||':
      segments.append(tr.pop(0))
  return sentence, segments

if __name__=='__main__':
  translation = codecs.open(sys.argv[1], 'r', 'utf-8').readlines()
  sentence, segments = getNextSentence(translation)
  while sentence and segments:
    matched = getSegments(sentence, segments)
    print matched
    sentence, segments = getNextSentence(translation)
