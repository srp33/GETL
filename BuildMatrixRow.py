import sys, gzip

inFilePath = sys.argv[1]
firstFilePath = sys.argv[2]
outHeaderFilePath = sys.argv[3]
outFilePath = sys.argv[4]

isFirst = inFilePath == firstFilePath

inFile = gzip.open(inFilePath)
sampleID = inFile.readline().rstrip("\n").split("\t")[1]

genes = []
values = []
for line in inFile:
    lineItems = line.rstrip("\n").split("\t")
    genes.append(lineItems[0])
    values.append(lineItems[1])

inFile.close()

firstGenes = []
firstFile = gzip.open(firstFilePath)
firstFile.readline()
for line in firstFile:
    lineItems = line.rstrip("\n").split("\t")
    firstGenes.append(lineItems[0])
firstFile.close()

if genes != firstGenes:
    print("The genes in " + inFilePath + " do not match those in " + firstFilePath + ".")
    sys.exit(1)

if isFirst:
    outHeaderFile = gzip.open(outHeaderFilePath, 'w')
    outHeaderFile.write("\t".join([""] + genes) + "\n")
    outHeaderFile.close()

outFile = gzip.open(outFilePath, 'w')
outFile.write("\t".join([sampleID] + values) + "\n")
outFile.close()
