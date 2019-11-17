#!/usr/bin/env python3

Usage = """
Overlap_filtered_orthologs_V1
Usage:
	Overlap_filtered_orthologs_V1 bayes_flag_sig_TDU_for_UR_Filtered.csv bayes_flag_sig_TPR_for_UR_Filtered.csv 
"""

import sys,os,re

InFileName1 = sys.argv[1]
InFileName2 = sys.argv[2]
OutFileName = 'bayes_flag_sig_Filtered_Tdu-Tpr_overlap.csv'
OutFile = open(OutFileName, 'w')
Delimiter = ','

if len(sys.argv) < 2:
	print(Usage)
else:
	InFile1 = open(InFileName1, 'r')
	next(InFile1)
	for Line1 in InFile1:
		Line1 = Line1.strip('\n')
		ElementList1 = Line1.split(Delimiter)
		Tdu = ElementList1[0]
		InFile2 = open(InFileName2, 'r')
		next(InFile2)
		for Line2 in InFile2:
			Line2 = Line2.strip('\n')
			ElementList2 = Line2.split(Delimiter)
			Tpr = ElementList2[0]
			if Tdu == Tpr:
				OutFile.write(Tpr + "\n")
		InFile2.close()
	InFile1.close()
OutFile.close()
