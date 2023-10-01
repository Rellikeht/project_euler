#!/bin/sh

START=1
END=100
if [ "$2" -ge 1 ]
then
    START="$1"
    END="$2"
elif [ "$1" -ge 1 ]
then
    END="$1"
fi

seq "$START" "$END" | xargs -P 16 -I {} wget "https://projecteuler.net/problem={}" -O "p{}.html" > /dev/null
