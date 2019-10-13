#!/usr/bin/env python3

Usage = """
Filter_V1.0.py
Usage:
	Filter_V1.0.py Shared_reciprocated_blast_hits_SingleCopyOrthogroups_parser_FullDescription.txt
"""

import sys,os,re

InFileName = sys.argv[1]
OutFileName = os.path.splitext(InFileName)[0] + '_filtered.txt'
OutFile = open(OutFileName, 'w')
Delimiter = '\t'

if len(sys.argv) < 2:
	print(Usage)
else:
	InFile = open(InFileName, 'r')
	for Line in InFile:
		Line = Line.strip('\n')
		ElementList = Line.split(Delimiter)
		# elementlist 5 (column 6) is the p value
		# elementlist 6 (column 7) is identity
		QueryLength = float(ElementList[1])
		SubjectLength = float(ElementList[3])
		AlignmentLength = float(ElementList[8])
		P_VAL = float(ElementList[5])
		Identity = float(ElementList[6])
		if P_VAL <= 1e-5 and Identity >= 80:
			OutFile.write(Line + "\n")
	InFile.close()
OutFile.close()
