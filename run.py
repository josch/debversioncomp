#!/usr/bin/env python

import deb822

versions = set()
with open("/home/josch/gsoc2012/bootstrap/Packages") as f:
    for pkg in deb822.Deb822.iter_paragraphs(f, use_apt_pkg=False):
        ver = pkg.get('Version')
        if ver:
            versions.add(ver)

# create a list of all possible combinations of two versions by iterating
# through the list of versions and comparing every version with all that come
# after it
versions = sorted(versions)
for i,v1 in enumerate(versions):
    for v2 in versions[i+1:]:
        print("%s\t%s"%(v1,v2))
