#!/bin/bash
# ─────────────────────────────────────────────────────────────
#  waybar-autohide.sh
#  • Hides Waybar when any window is open
#  • Shows Waybar when all windows close
#  • Reacts to mouse hover at top of screen (via hyprctl)
#  • Super+W toggle is handled separately via Hyprland keybind
# ─────────────────────────────────────────────────────────────

LOCK_FILE="/tmp/waybar_hidden_by_autohide"
HOVER_ZONE=5          # pixels from top that trigger show-on-hover
HIDE_DELAY=0.4        # seconds before hiding after a window opens
SHOW_DELAY=0.1        # seconds before showing after all windows close

waybar_running() {
    pgrep -x waybar &>/dev/null
}

waybar_visible() {
    # Returns 0 (true) if waybar is NOT hidden
    ! [ -f /tmp/waybar_force_hidden ]
}

hide_waybar() {
    touch "$LOCK_FILE"
    pkill -SIGUSR1 waybar 2>/dev/null   # SIGUSR1 = toggle hide in waybar
}

show_waybar() {
    rm -f "$LOCK_FILE"
    pkill -SIGUSR1 waybar 2>/dev/null
}

# Get number of normal (non-special, non-floating-only) windows on active workspace
window_count() {
    hyprctl clients -j 2>/dev/null \
        | python3 -c "
import sys, json
clients = json.load(sys.stdin)
ws = $(hyprctl activeworkspace -j 2>/dev/null | python3 -c 'import sys,json; print(json.load(sys.stdin)[\"id\"])' 2>/dev/null || echo 1)
count = sum(1 for c in clients if c.get('workspace', {}).get('id') == ws and not c.get('hidden', False))
print(count)
" 2>/dev/null || echo 0
}

currently_hidden=false

handle_event() {
    local line="$1"

    # Events that mean a window opened or closed
    case "$line" in
        openwindow*|closewindow*|movewindow*|workspace*|focusedmon*)
            sleep "$HIDE_DELAY"
            count=$(window_count)

            if [ "$count" -gt 0 ] && [ "$currently_hidden" = false ]; then
                hide_waybar
                currently_hidden=true
            elif [ "$count" -eq 0 ] && [ "$currently_hidden" = true ]; then
                show_waybar
                currently_hidden=false
            fi
            ;;
    esac
}

# ── Hover detection loop (background) ─────────────────────────
hover_loop() {
    while true; do
        # Get mouse Y position
        mouse_y=$(hyprctl cursorpos -j 2>/dev/null | python3 -c "import sys,json; print(json.load(sys.stdin).get('y', 999))" 2>/dev/null || echo 999)

        if [ "$mouse_y" -le "$HOVER_ZONE" ] 2>/dev/null; then
            # Mouse at top — temporarily show
            if [ "$currently_hidden" = true ]; then
                pkill -SIGUSR1 waybar 2>/dev/null
                sleep 3   # keep visible for 3s while hovering
                # Re-hide if still windows open
                count=$(window_count)
                if [ "$count" -gt 0 ]; then
                    pkill -SIGUSR1 waybar 2>/dev/null
                fi
            fi
        fi
        sleep 0.3
    done
}

# ── Main ───────────────────────────────────────────────────────
echo "[waybar-autohide] Starting..."

# Start hover detection in background
hover_loop &
HOVER_PID=$!

# Clean up on exit
trap "kill $HOVER_PID 2>/dev/null; rm -f $LOCK_FILE; exit" SIGTERM SIGINT

# Listen to Hyprland socket events
socat -U - UNIX-CONNECT:/tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock 2>/dev/null \
| while IFS= read -r line; do
    handle_event "$line"
done

# Fallback if socat not available
if [ $? -ne 0 ]; then
    echo "[waybar-autohide] socat not found, trying nc..."
    nc -U /tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock 2>/dev/null \
    | while IFS= read -r line; do
        handle_event "$line"
    done
fi
