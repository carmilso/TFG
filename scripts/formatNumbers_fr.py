#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import codecs
import fileinput
from string import *
from re import *
from ntlfrench import *

UTF8Reader = codecs.getreader('utf8')
sys.stdin = UTF8Reader(sys.stdin)


patronhoras = compile("(l')?\d+:(\d?)")
patrondias = compile("\d+\.\d")
patrondiainverso = compile("\d+-[a-zA-Z]+")
patronhorabing = compile("[a-zA-Z]+-\d+:(\d?)")
patronfechabing = compile("[a-zA-Z]+\d+")
patrondiaextra = compile("\d+(ème|e|po|)")
patrondia = compile("\d+")

meses=["","janvier","février","mars","avril","mai","juin","juillet","août","septembre","octobre","novembre","décembre"]

for linea in fileinput.input():
	linea=sub("\n","",linea)
	listapal=linea.split()
	frase=""
	for i in range(len(listapal)):
		pal=listapal[i]
		if pal.isdigit():
			frase+=" "+strip(convNombre2lettres(int(pal)))
		elif patronhoras.match(pal):
			if pal.startswith("l'"): pal = pal[2:]
			horas=pal.split(":")
			if horas[1]!="":
				if horas[0]=="1":
					frase+=" l'"+strip(convNombre2lettres(int(horas[0])))+"e heures "+strip(convNombre2lettres(int(horas[1])))
				else:
					if listapal[i-1]==u"à":
						frase=frase[:-2]+"aux "+strip(convNombre2lettres(int(horas[0])))+" heures "+strip(convNombre2lettres(int(horas[1])))
					elif listapal[i-1]=="de":
						frase=frase[:-2]+"des "+strip(convNombre2lettres(int(horas[0])))+" heures "+strip(convNombre2lettres(int(horas[1])))
					else:
						frase+=" les "+strip(convNombre2lettres(int(horas[0])))+" heures "+strip(convNombre2lettres(int(horas[1])))		
			else:
				if horas[0]=="1":
					frase+=" l'"+strip(convNombre2lettres(int(horas[0])))+"e heures"
				else:
					if listapal[i-1]==u"à":
						frase=frase[:-2]+"aux "+strip(convNombre2lettres(int(horas[0])))+" heures"
					elif listapal[i-1]=="de":
						frase=frase[:-2]+"des "+strip(convNombre2lettres(int(horas[0])))+" heures"
					else:					
						frase+=" les "+strip(convNombre2lettres(int(horas[0])))+" heures"
		elif patrondiainverso.match(pal):
			fecha=pal.split('-')
			frase+=" "+fecha[1]+" "+strip(convNombre2lettres(int(fecha[0])))
		elif patronhorabing.match(pal):
			hora=pal.split("-")
			horas=hora[1].split(":")
			frase+=" "+hora[0]+"-"+strip(convNombre2lettres(int(horas[0])))+" "+strip(convNombre2lettres(int(horas[1])))
		elif patronfechabing.match(pal):
			frase+=" "
			dia=""
			for l in pal:
				if not l.isdigit(): frase+=l
				else: dia+=l
			frase+=" le "+strip(convNombre2lettres(int(dia)))
		elif patrondiaextra.match(pal):
			frase+=" "+strip(convNombre2lettres(int(patrondia.match(pal).group(0))))
		elif patrondias.match(pal):
			fecha=pal.split(".")
			frase+=" le "+strip(convNombre2lettres(int(fecha[0])))+" "+meses[int(fecha[1])]
		elif pal=="1er":
			frase+=" "+"premier"
		elif pal==u"1ère" or pal=="1ere":
			frase+=" "+"première"
		else:
			frase+=" "+pal
	# print sub("[ ]+"," ",strip(lower(frase)))
	print sub("[ ]+"," ",strip(frase))
