#!/bin/bash
brightness=$(brightnessctl get)
max=$(brightnessctl max)
percent=$((brightness * 100 / max))

if [ "$percent" -le 30 ]; then
    icon="󰃞"
elif [ "$percent" -le 70 ]; then
    icon="󰃟"
else
    icon="󰃠"
fi

echo "$icon  $percent%"
