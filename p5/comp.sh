#!/bin/sh

ARCH="native"
[ -n "$1" ] && ARCH="$1"

g++ \
    -Ofast \
    -march=$ARCH \
    -flto \
    -static \
    -o p5azi p5azi.cpp

rustc \
    -C opt_level=3 \
    -C target_cpu=$ARCH \
    -C target_feature=+crt-static \
    -C lto \
    p5.rs

strip p5azi
strip p5
