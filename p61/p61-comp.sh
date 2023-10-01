#!/bin/sh
./p61-filter.awk p61-nums.txt | sort -u | grep -Ev "[0-9]{5}" > p61-check.txt
#cat p61-check.txt | ./p61.cl
