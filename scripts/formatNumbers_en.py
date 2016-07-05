#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
EXAMPLE USAGE: cat ../logs/google_en.log | ./formatNumbers_en.py
'''

import sys
import codecs
import fileinput
from string import *
from re import *
from num2words import num2words

UTF8Reader = codecs.getreader('utf-8')
sys.stdin = UTF8Reader(sys.stdin)


hourspattern = compile('\d+:\d+(:\d+)?')
numeralspattern = compile('\d+(th|st|nd|rd)(-[a-zA-Z]+)?')
worddatepattern = compile('[a-zA-Z]+\d+')

months = 'january february march april may june july august september october november december'.split()

def toWord(num, ord=False):
  return strip(num2words(int(num), ordinal=ord))

for line in fileinput.input():
  line = line.strip('\n')
  wordlist = line.split()
  sentence = ""
  for i in xrange(len(wordlist)):
    word = wordlist[i]
    if word.isdigit():
      # print '----------------->', word
      if i > 0 and wordlist[i-1].lower() in months:
        sentence += " " + toWord(word, True)
      elif i+1 < len(wordlist) and wordlist[i+1] in months:
        sentence += " " + toWord(word, True) + " of"
      elif i+1 < len(wordlist) and wordlist[i+1] == 'of':
        sentence += " " + toWord(word, True)
      elif i > 0 and wordlist[i-1].lower() == 'the':
        sentence += " " + toWord(word, True)
      else:
        sentence += " " + toWord(word)
    elif hourspattern.match(word):
      # print '----------------->', word
      hour = word.split(':')
      if hour[0] == '00' or hour[0] == '0': hour[0] = '12'
      if hour[1] == '00':
        sentence += " " + toWord(hour[0]) + " o'clock"
      elif hour[1] == '15':
        sentence += " quarter past " + toWord(hour[0])
      elif hour[1] == '30':
        sentence += " half past " + toWord(hour[0])
      elif hour[1] == '45':
        sentence += " quarter to " + toWord(hour[0])
      elif hour[1] < '30':
        sentence += " " + toWord(hour[1]) + " past " + toWord(hour[0])
      elif hour[1] <= '60':
        sentence += " " + toWord(hour[0]) + " " + toWord(hour[1])
    elif numeralspattern.match(word):
      nums = word.split('-')
      sentence += " " + toWord(nums[0][:-2], True)
      if len(nums) > 1: sentence += " " + nums[1]
    elif worddatepattern.match(word):
      dig = ""
      for c in word:
        if c.isdigit(): dig += c
        else: sentence += c
      if i > 0 and wordlist[i-1].lower() in months \
      or i+1 < len(wordlist) and wordlist[i+1] in months:
        sentence += " " + toWord(dig, True)
      else:
        sentence += " " + toWord(dig)
    else:
      sentence += " " + word

  print strip(sentence)
