#!/bin/sh

#PAMO=751
PSTART=10
PAMO=100

for i in `seq $PSTART $PAMO`
do
	curl "https://projecteuler.net/problem=$i" > cp
	if [ -n "`grep -E "Difficulty rating: [12][05]%" cp`" ]
	then
		mv cp p$i.html
	else
		rm cp
	fi
done
