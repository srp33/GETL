#!/usr/bin/python

import os
import re
import sys
import shutil

filePath = sys.argv[1]

dirPath = os.path.dirname(filePath)
fileName = os.path.basename(filePath)

p = re.compile(".*(GSM\d{4,9}).*", re.IGNORECASE)
m = p.match(filePath)
destFileName = m.group(1)

destFilePath = dirPath + "/" + destFileName.upper() + ".CEL.gz"

print "Previous Name: " + filePath
print "Destination Name: " + destFilePath

shutil.move(filePath, destFilePath)
