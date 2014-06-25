#!/bin/sh

# some examples where `sort -V` does the wrong thing:
# 0.04-1-5             0.4-3
# 0.1+20080921-2       0.1-1+b8
# 0.1+dfsg-4           000.001-4
# 0.1.0+20071012-1.2   0.1.0-1.1
# 0.3.0+20091229-1     0.3.0-7.2
# 0.6.0+git20130305-5  0.6.0-5+b1
# 0:2009.10.04-1       1.0pre11-1
# 0:2009.10.04-1       1.240-1
# 0:2009.10.04-1       1.7.2.4-4.1
# 0:2009.10.04-1       2.3-12
# 0:2009.10.04-1       8.0.184.15484+dfsg-2
# 1.0+dfsg-1           1.00-6

i=0
while read line; do
	printf "$i\r" >&2
	i=$((i+1))
	set -- $line
	newest=$( ( echo "$1"; echo "$2" ) | sort -V | tail -n1)
	if [ "$1" != "$newest" ]; then
		printf "<"
	else
		printf ">"
	fi
	printf " %s\t%s\n" $1 $2
done
