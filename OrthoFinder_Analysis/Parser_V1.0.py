#!/usr/bin/env python3

Usage = """
Parser_V1.0.py
Usage:
	Parser_V1.0.py input.tsv
"""

import sys,re,os

Delimiter = '\t'

InFileName = sys.argv[1]
InFile = open(InFileName, 'r')
OutFileName = os.path.splitext(InFileName)[0] + '_parser.tsv'
OutFile = open(OutFileName, 'w')

if len(sys.argv) < 2:
	print(Usage)
else:
	for Line in InFile:
		Line = Line.strip('\n')
		ElementList = Line.split(Delimiter)
		Tdu = str(ElementList[1])
		Tpr = str(ElementList[2])
		MyRe = r"\w+ GENE.(\w+)\~\~.+"
		MyResult_Tdu = re.search(MyRe, Tdu)
		MyResult_Tpr = re.search(MyRe, Tpr)
		First = 'Tpr_' + str(MyResult_Tpr.group(1))
		Second = 'Tdu_' + str(MyResult_Tdu.group(1))
		OutFile.write(First + "\t" + Second + "\n")
InFile.close()
OutFile.close()
