#!/usr/bin/env python

from __future__ import print_function
import deb822
import sys

versions = set()
with open(sys.argv[1]) as f:
    for pkg in deb822.Deb822.iter_paragraphs(f):
        ver = pkg.get('Version')
        if ver:
            versions.add(ver)

# create a list of all possible combinations of two versions by iterating
# through the list of versions and comparing every version with all that come
# after it
versions = sorted(versions)
l = len(versions)
for i,v1 in enumerate(versions):
    print("%f %%\r"%((i*100.0)/l), file=sys.stderr, end="")
    for v2 in versions[i+1:]:
        print("%s\t%s"%(v1,v2))
