import sys

inFilePath = sys.argv[1]

prefix = "Sample\t\tAccession: "
suffix = "\tID: "

inFile = open(inFilePath)

for line in inFile:
    if line.startswith(prefix):
        gsm = line.split(prefix)[1].split(suffix)[0]
        print(gsm)

inFile.close()
