#!/bin/sh
# we need to do this because of bug#47214
split --lines=1000000 --numeric-suffixes --suffix-length=4 --filter='./testdpkg'
