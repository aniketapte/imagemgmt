#!/usr/bin/python

# Finds all files in the current directory that end with jpg, avi or mpg.
# Finds mod-time of such files and renames the file with a prefix of the mod-time
# in YYYYMMDDHHMMSS format. If the filename already contains the prefix (14-digit string),
# the file is ignored.

# Needs Python 2.6+

import os
import re
from datetime import datetime

reobj = re.compile('^[0-9]{14}_+')

for f in os.listdir('.'):
    if f.lower().endswith( ('.jpg', '.avi', '.mpg') ):
        if reobj.match(f):
            print 'Ignoring "%s, already in correct format.' % f
            continue
        tstamp = datetime.fromtimestamp(os.stat(f).st_mtime).strftime('%Y%m%d%H%M%S')
        newname = '%s_%s' % (tstamp, f)
        os.rename(f, newname)
        print '%s -> %s' % (f, newname)

