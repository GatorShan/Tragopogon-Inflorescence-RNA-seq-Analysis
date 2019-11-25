#!/usr/bin/env python3

Usage = """
FilterBedFile_Poly_V1
Usage:
	FilterBedFile_Poly_V1 bayes_flag_sig_Filtered_Tdu-Tpr_overlap.csv *FullName.txt.filtered_S.bed 
"""

import sys,os,re

InFileName1 = sys.argv[1]
InFileName2 = sys.argv[2]
OutFileName = 'Tdu-tpr_overlaps_orthologs_poly.bed'
OutFile = open(OutFileName, 'w')
Delimiter = '|'

if len(sys.argv) < 2:
	print(Usage)
else:
	InFile1 = open(InFileName1, 'r')
	for Line1 in InFile1:
		Line1 = Line1.strip('\n')
		ElementList1 = Line1.split(Delimiter)
		Tdu_1 = ElementList1[1]
		InFile2 = open(InFileName2, 'r')
		for Line2 in InFile2:
			Line2 = Line2.strip('\n')
			ElementList2 = Line2.split(Delimiter)
			Tdu_2 = ElementList2[0]
			if Tdu_1 == Tdu_2:
				OutFile.write(Line2 + "\n")
		InFile2.close()
	InFile1.close()
OutFile.close()
