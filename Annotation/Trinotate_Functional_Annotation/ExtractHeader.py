#!/usr/bin/env python

import sys
from Bio import SeqIO

InFileName = sys.argv[1] # the fasta file contains all genes/supertranscripts
OutFileName = sys.argv[2] # the gene_trans_map file

OutFile = open(OutFileName, 'w')

with open(InFileName, "rU") as InFile:
	for record in SeqIO.parse(InFile, "fasta"):
		Header = str(record.id) + "\t" + str(record.id) # duplicate the header line of the fasta file, separated by a tab
		OutFile.write(Header+"\n") # write out the duplicated header line

OutFile.close()
