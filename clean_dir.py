# -*- coding: utf-8 -*-
import os

path = "/storage/test1"

files = os.listdir(path)
for f in files:
    subpath = str(os.path.join(path, f)).strip()
    if (os.path.isdir(subpath) and len(subpath)>10):
        if (f[0] != '.' and os.path.getsize(subpath) == 4096):
            #print subpath
	    os.remove(subpath)
			
