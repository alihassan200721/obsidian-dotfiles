#!/bin/bash

bar="▁▂▃▄▅▆▇█"

cava -p ~/.config/cava/config | while read -r line; do
    output=""
    for i in $line; do
        level=$((i / 12))
        [ $level -gt 7 ] && level=7
        char=$(echo $bar | cut -c $((level+1)))
        output="${output}${char}"
    done
    echo "$output"
done
