#!/bin/awk -f
#BEGIN {FS="[ 	()]*"} {print $2, $7, "\n", substr($2,1,2), substr($7,3,2), "\n\n"}
#BEGIN {FS="[ 	()]*"} /\([0-9]+( [0-9]+){5,}/ {if (substr($2,1,2) == substr($7,3,2)) {print $0}}

BEGIN {FS="[ 	()]*";ORS=" ";print "c"}
#/\([0-9]+( [0-9]+){5,}/
{for (i=2;i<=(NF-6);i++)
#	{print i, ":", substr($i,1,2), substr($(i+5),3,2)}}
#	{print i, ":", $i, $(i+5)}}

#BEGIN {FS="[ 	()]*"}
#/\([0-9]+( [0-9]+){5,}/ {for (i=1;i<(NR-5);i++)
	{if (substr($i,1,2) == substr($(i+5),3,2)) {for (j=i;j<=(i+5);j++) {print $j}; print "\n"}}}
END {ORS="\n";print " "}
