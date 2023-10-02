#!/bin/sh

[ $# -lt 2 ] && \
    echo Give a program and a number && \
    exit 1

PROG="$1"

# if [ ! -x "$PROG" ]
# then
#     echo Nonex
#     PROG="./$PROG"
#     [ ! -x "$PROG" ] && \
#         echo Give me something to execute && \
#         exit 1
# fi
# 
# echo "$PROG"

INP=$(echo "$2" | tr -d '_-')

if [ "$(uname)" = "FreeBSD" ]
then
        echo "$INP" | xargs /usr/bin/time -lh "$PROG"
else
        echo "$INP" | xargs /usr/bin/time -v "$PROG"
fi
