#!/bin/bash

bars=(" " "⣀" "⣄" "⣤" "⣦" "⣶" "⣷" "⣿")
idle_bar="⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀" # flat line shown when nothing is playing

cava -p ~/.config/cava/waybar_cava.conf | while IFS=";" read -ra values; do
    out=""
    is_silent=true

    for v in "${values[@]}"; do
        [[ -z "$v" ]] && continue
        if [[ "$v" -gt 0 ]]; then
            is_silent=false
        fi
        out+="${bars[$v]}"
    done

    if $is_silent; then
        echo "$idle_bar"
    else
        echo "$out"
    fi
done
