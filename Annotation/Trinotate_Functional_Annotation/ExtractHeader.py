#!/usr/bin/env python

import sys
from Bio import SeqIO

InFileName = sys.argv[1]
OutFileName = sys.argv[2]

OutFile = open(OutFileName, 'w')

with open(InFileName, "rU") as InFile:
	for record in SeqIO.parse(InFile, "fasta"):
		Header = str(record.id) + "\t" + str(record.id)
		OutFile.write(Header+"\n")

OutFile.close()
