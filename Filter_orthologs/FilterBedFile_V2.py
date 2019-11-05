#!/usr/bin/env python3

Usage = """
FilterBedFile_V2
Usage:
	FilterBedFile_V2.py Shared_*_orthologs.txt *FullName.txt.filtered_Q.bed 
"""

import sys,os,re

InFileName1 = sys.argv[1]
InFileName2 = sys.argv[2]
OutFileName = 'Tpr-tdu_overlaps_orthologs.bed'
OutFile = open(OutFileName, 'w')
Delimiter = '\t'

if len(sys.argv) < 2:
	print(Usage)
else:
	InFile1 = open(InFileName1, 'r')
	for Line1 in InFile1:
		Line1 = Line1.strip('\n')
		ElementList1 = Line1.split(Delimiter)
		Tpr_1 = ElementList1[0]
		InFile2 = open(InFileName2, 'r')
		for Line2 in InFile2:
			Line2 = Line2.strip('\n')
			ElementList2 = Line2.split(Delimiter)
			Tpr_2 = ElementList2[0]
			if Tpr_1 == Tpr_2:
				OutFile.write(Line2 + "\n")
		InFile2.close()
	InFile1.close()
OutFile.close()
