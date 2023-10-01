#!/bin/sh

WDIR=/tmp/w3vim/

[ -d "$WDIR" ] && rm "$WDIR"/*
mkdir -p "$WDIR"

# For ultimate correctness...
#for e in "$@";do readlink -f "$e";done | \
#    xargs -P 16 -I{} sh -c "
#    echo \"{}\" | \
#        sed \"s/[^\/]*$//\" | \
#        xargs -IDR mkdir -p \"$WDIR/DR\"
#    w3m \"{}\" | \
#        sed \"1,13d\" | tac | \
#        sed \"1,6d\" | tac > \"$WDIR/{}\""

for e in "$@";do echo "$e" "$e";done | \
    sed 's/^[^ ]*\///' | \
    awk "{print \$2,
    \"| sed '1,13d' | tac | sed '1,7d' | tac >\",
    \"$WDIR\"\$1}" | \
    xargs -P 16 -I{} sh -c 'w3m {}'
