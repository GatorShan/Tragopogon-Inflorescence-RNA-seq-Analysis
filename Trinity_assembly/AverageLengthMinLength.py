#! /usr/bin/env python

Usage = """
AverageLength.py -version 1.0
Usage:
	AverageLength.py *.txt
"""

import sys
from Bio import SeqIO

Length = 0
SeqNum = 0
Min = 10000

for read in SeqIO.parse(str(sys.argv[1]), "fasta"):
	Length += len(read)
	SeqNum += 1
	if len(read) < Min:
		Min = len(read)

Average = Length/SeqNum

print('Total length: %d' % Length)
print('Total sequence number: %d' % SeqNum)
print('Average Lenth: %.1f' % Average)
print('Min contig length: %d' % Min)