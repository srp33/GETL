import sys

inFilePath = sys.argv[1]

inFile = open(inFilePath)

series = None
sample = None

for line in inFile:
    if line.startswith("Platform: "):
        series = line.rstrip("\n").split("Series: ")[1].split(" Dataset: ")[0].split(" Datasets: ")[0]
    if line.startswith("Sample\t\tAccession: "):
        gsm = line.split("Sample\t\tAccession: ")[1].split("\tID: ")[0]
        print("{}\t{}".format(gsm, series))

inFile.close()
