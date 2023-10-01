#!/bin/sh

! [ "$1" -gt 0 ] 2>/dev/null && \
    echo Give a number && \
    exit 1

DIR="p$1"
mkdir -p "$DIR"
ln "problems/p$1.html" "$DIR/desc.html"
