#!/bin/sh

SOLS=$(find .. -name '*sols.txt')
grep --color=always "^$1\." $SOLS
