#!/usr/bin/env python3

Usage = """
ExtractInfo_V4.0.py
Usage:
	ExtractInfo_V4.0.py 5400_loci.csv matrix.csv
"""

import sys,os

InFileName1 = sys.argv[1]
InFileName2 = sys.argv[2]
OutFileName = os.path.splitext(InFileName2)[0] + '_5400.csv'
OutFile = open(OutFileName, 'w')
Delimiter = ','

if len(sys.argv) < 3:
	print(Usage)
else:
	InFile1 = open(InFileName1, 'r')
	for Line1 in InFile1:
		Line1 = Line1.strip('\n')
		NoBias = Line1
		InFile2 = open(InFileName2, 'r')
		for Line2 in InFile2:
			Line2 = Line2.strip('\n')
			ElementList2 = Line2.split(Delimiter)
			MatrixLoci = ElementList2[0]
			if NoBias == MatrixLoci:
				OutFile.write(Line2 + "\n")
		InFile2.close()
	InFile1.close()
OutFile.close()