#!/bin/sh

CONTENT=$(
grep --color=never 'Difficulty rating: ' p* | \
    sed -E 's/^(p[0-9]*)\.html:.*(rating: [0-9]*%).*$/\1 \2/' | \
    sort -k 1.2n
)

if [ "$1" = "r" -o "$1" = "-r" ]
then
    echo "$CONTENT" | sort -s -k 3.1nr
elif [ -n "$1" ]
then
    echo "$CONTENT" | sort -s -k 3.1n
else
    echo "$CONTENT"
fi
