#!/bin/bash
# ─────────────────────────────────────────────────────────────
#  waybar-toggle.sh
#  Called by Hyprland on Super+W
#  Toggles Waybar visibility and sets a "force hidden" flag
#  so the autohide daemon doesn't fight against it
# ─────────────────────────────────────────────────────────────

FORCE_FLAG="/tmp/waybar_force_hidden"

if [ -f "$FORCE_FLAG" ]; then
    # Currently force-hidden → show it
    rm -f "$FORCE_FLAG"
    pkill -SIGUSR1 waybar
else
    # Currently visible → force hide
    touch "$FORCE_FLAG"
    pkill -SIGUSR1 waybar
fi
