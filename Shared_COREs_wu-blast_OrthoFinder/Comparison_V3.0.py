#!/usr/bin/env python3

Usage = """
Comparison_V3.0.py
Usage:
	Comparison_V3.0.py input1 input2
"""

import sys,os

InFileName1 = sys.argv[1]
InFileName2 = sys.argv[2]
OutFileName = 'Shared_' + os.path.splitext(InFileName1)[0] + '_' + os.path.splitext(InFileName2)[0] + '.txt'
OutFile = open(OutFileName, 'w')
Count = 0
Delimiter = '\t'

if len(sys.argv) < 3:
	print(Usage)
else:
	InFile1 = open(InFileName1, 'r')
	for Line1 in InFile1:
		Line1 = Line1.strip('\n')
		ElementList1 = Line1.split(Delimiter)
		Tpr_1 = ElementList1[0]
		Tdu_1 = ElementList1[1]
		InFile2 = open(InFileName2, 'r')
		for Line2 in InFile2:
			Line2 = Line2.strip('\n')
			ElementList2 = Line2.split(Delimiter)
			Tpr_2 = ElementList2[0]
			Tdu_2 = ElementList2[1]
			if Tpr_1 == Tpr_2 and Tdu_1 == Tdu_2:
				Count += 1
				OutFile.write(Line2 + "\n")
				break
		InFile2.close()
InFile1.close()
OutFile.close()
print(Count)
