#!/bin/bash

bars="▏▎▍▌▋▊▉█"

cava -p ~/.config/cava/config | while read -r line; do
    title=$(playerctl metadata title 2>/dev/null)
    artist=$(playerctl metadata artist 2>/dev/null)

    [ -z "$title" ] && title="No Music"

    text="$title"
    [ -n "$artist" ] && text="$artist - $title"

    short=$(echo "$text" | cut -c1-28)

    out=""
    for i in $line; do
        level=$((i / 13))
        [ $level -gt 7 ] && level=7
        char=$(echo "$bars" | cut -c $((level+1)))
        out="$out$char"
    done

    echo "♫ $short  $out"
done
