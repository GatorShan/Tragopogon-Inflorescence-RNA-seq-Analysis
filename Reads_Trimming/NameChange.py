#! /usr/bin/env python

import re, shutil

InFileName = 'SampleList.txt'

InFile = open (InFileName, 'r')

for Line in InFile:
	Line = Line.strip('\n')
	SearchStr = '[\w\d]+\-(\d+)\-(\d+)[\w\d\-\_]+\_([\w\d]+)\_\d+\.fastq'
	Result = re.search(SearchStr, Line)
	PopulationString = Result.group(1)
	ReplicationString = Result.group(2)
	DirectionString = Result.group(3)
	
	if PopulationString == '2608':
		shutil.copy(Line, 'Tpr_%s_%s_%s.fastq' % (PopulationString, ReplicationString, DirectionString))
	else:
		shutil.copy(Line, 'Tdu_%s_%s_%s.fastq' % (PopulationString, ReplicationString, DirectionString))
		
InFile.close()
