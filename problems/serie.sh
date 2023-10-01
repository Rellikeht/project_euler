#!/bin/sh

START=$(
ls p*.html | \
    sort -k '1.2n' | \
    sed -E 's/p([0-9]*).html/\1/;1q'
)

END=$(
ls p*.html | \
    sort -k '1.2nr' | \
    sed -E 's/p([0-9]*).html/\1/;1q'
)

if [ "$2" -ge "$START" -a "$2" -le "$END" ] 2>/dev/null
then
    END=$2
    [ "$1" -ge "$START" -a "$1" -le "$END" ] 2>/dev/null && START=$1
fi

[ "$1" -ge "$START" -a "$1" -le "$END" ] 2>/dev/null && END=$1

FILES=$(
seq $START $END | \
    sed -E 's/(.*)/p\1.html/'
)

echo "$FILES" | xargs ./w3vim.sh
find /tmp/w3vim/ -type f | \
    sort -k 1.13n | \
    xargs -o svim

