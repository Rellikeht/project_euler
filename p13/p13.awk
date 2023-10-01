#BEGIN {FS="";c=0}
#{for (i=1;i<=NF;i++) {c+=$i}}
BEGIN {c=0}
{c+=$0}
END {print c}
