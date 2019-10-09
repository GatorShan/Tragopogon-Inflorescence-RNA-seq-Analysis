Usage = """
ExtractFiles.py -version 1.0
Usage:
	ExtracFiles.py Orthogroups_SingleCopyList.txt Orthogroups.tsv
"""

import sys

OutFileName = "SingleCopyOrthogroups.tsv"
OutFile = open(OutFileName, 'w')

if len(sys.argv) < 3:
	print(Usage)
else:
	Infile1 = sys.argv[1]
	Infile2 = sys.argv[2]
	
	Delimiter = '\t'
	List = open(Infile1, 'r')
	for Item in List:
		Item = Item.strip('\n')
		Content = open(Infile2, 'r')
		for Line in Content:
			Line = Line.strip('\n')
			ElementList = Line.split(Delimiter)
			Name = str(ElementList[0])
			if Item == Name:
				OutFile.write(Line + "\n")
		Content.close()
	List.close()
OutFile.close()
