#!/usr/bin/env python3
import os, json, subprocess, time

FIFO = "/tmp/cava-waybar.fifo"
BRAILLE = [" ", "⢀", "⢠", "⢰", "⢸"]

def bar_to_braille(val):
    return BRAILLE[min(int(val), 4)]

def make_fifo():
    if not os.path.exists(FIFO):
        os.mkfifo(FIFO)

def main():
    make_fifo()
    cava = subprocess.Popen(
        ["cava", "-p", os.path.expanduser("~/.config/cava/waybar")],
        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
    )
    try:
        with open(FIFO, "r") as fifo:
            while True:
                line = fifo.readline().strip()
                if not line:
                    time.sleep(0.05)
                    continue
                try:
                    vals = [int(x) for x in line.split(";") if x]
                except ValueError:
                    continue
                if not any(v > 0 for v in vals):
                    print(json.dumps({"text": "", "class": "inactive"}), flush=True)
                    continue
                print(json.dumps({"text": "".join(bar_to_braille(v) for v in vals), "class": "active"}), flush=True)
    finally:
        cava.terminate()

if __name__ == "__main__":
    main()
