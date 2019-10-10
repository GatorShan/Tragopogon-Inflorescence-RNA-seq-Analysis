#!/usr/bin/env python3

Usage = """
NameChange.py -version 2.0
Usage:
	NameChange.py infile.txt
"""

import sys

OutFileName = "Tpr_DB_Tdu_query_parser_single_hit_FullName.txt"
OutFile = open(OutFileName, 'w')

if len(sys.argv) < 2:
	print(Usage)
else:
	InFileName = sys.argv[1]
	Delimiter = '\t'
	InFile = open(InFileName, 'r')
	for Line in InFile:
		Line = Line.strip('\n')
		ElementList = Line.split(Delimiter)
		ElementList[0] = 'Tdu_' + str(ElementList[0])
		ElementList[2] = 'Tpr_' + str(ElementList[2])
		NewLine = '\t'.join(ElementList)
		OutFile.write(NewLine + "\n")
	InFile.close()
OutFile.close()