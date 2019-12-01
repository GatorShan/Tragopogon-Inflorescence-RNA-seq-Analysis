#!/usr/bin/env python3

Usage = """
Extract_homeolog_expression_biased_orthologs.py
Usage:
	Extract_homeolog_expression_biased_orthologs.py bayes_flag_sig_Tms_for_UR.csv bayes_flag_sig_Tml_for_UR.csv
"""

import sys,os

InFileName1 = sys.argv[1]
InFileName2 = sys.argv[2]

# These two outfiles are for Tms
OutFileName1_1 = os.path.splitext(InFileName1)[0] + '_bias_Tdu.csv'
OutFileName1_2 = os.path.splitext(InFileName1)[0] + '_bias_Tpr.csv'

# These two outfiles are for Tml
OutFileName2_1 = os.path.splitext(InFileName2)[0] + '_bias_Tdu.csv'
OutFileName2_2 = os.path.splitext(InFileName2)[0] + '_bias_Tpr.csv'

# open these files at the same time
OutFile1_1 = open(OutFileName1_1, 'w')
OutFile1_2 = open(OutFileName1_2, 'w')
OutFile2_1 = open(OutFileName2_1, 'w')
OutFile2_2 = open(OutFileName2_2, 'w')
Delimiter = ","

if len(sys.argv) < 3:
	print(Usage)
else:
	InFile1 = open(InFileName1, 'r')
	next(InFile1)
	for Line1 in InFile1:
		Line1 = Line1.strip('\n')
		ElementList1 = Line1.split(Delimiter)
		Sig1 = int(ElementList1[13])
		q5_theta1 = float(ElementList1[4])
		if Sig1 == 1 and q5_theta1 < 0.5:
			OutFile1_1.write(Line1 + "\n")
		elif Sig1 == 1 and q5_theta1 > 0.5:
			OutFile1_2.write(Line1 + "\n")
				
	InFile2 = open(InFileName2, 'r')
	next(InFile2)
	for Line2 in InFile2:
		Line2 = Line2.strip('\n')
		ElementList2 = Line2.split(Delimiter)
		Sig2 = int(ElementList2[13])
		q5_theta2 = float(ElementList2[4])
		if Sig2 == 1 and q5_theta2 < 0.5:
			OutFile2_1.write(Line2 + "\n")
		elif Sig2 == 1 and q5_theta2 > 0.5:
			OutFile2_2.write(Line2 + "\n")
	
	InFile1.close()
	InFile2.close()
OutFile1_1.close()
OutFile1_2.close()
OutFile2_1.close()
OutFile2_2.close()
