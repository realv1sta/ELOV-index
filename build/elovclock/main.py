#!/usr/bin/env python3
"""elovclock - My recreation of peaclock in Python."""

import atexit
from datetime import datetime
import os
import shutil
import signal
import sys
import time

# Ensure directory of this script is in sys.path for local module import
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from num import PATTERNS, SPACE

_running = True
_is_terminal = False


def _sig_handler(signum, frame):
    global _running
    _running = False


def _restore_terminal():
    if _is_terminal:
        # Show cursor, reset styling, and move cursor to new line
        sys.stdout.write("\033[?25h\033[0m\n")
        sys.stdout.flush()


def render_frame() -> str:
    now = datetime.now()
    time_str = now.strftime("%I:%M %p").upper()

    term_cols, term_lines = shutil.get_terminal_size()
    clock_width = len(time_str) * 11

    output = []
    # Clear screen and move cursor to (0,0)
    output.append("\033[2J")

    if term_cols < clock_width or term_lines < 5:
        output.append("\033[1;1HTerminal too small")
    else:
        x = max(0, (term_cols - clock_width) // 2)
        y = max(0, (term_lines - 5) // 2)

        for row in range(5):
            # ANSI cursor coordinates: 1-indexed (line, column)
            output.append(f"\033[{y + row + 1};{x + 1}H")

            for char in time_str:
                pattern = PATTERNS.get(char, SPACE)
                for cell in pattern[row]:
                    output.append(f"{cell}{cell}")
                output.append(" ")

    return "".join(output)


def main():
    global _running, _is_terminal

    _is_terminal = sys.stdout.isatty()

    if "-h" in sys.argv or "--help" in sys.argv:
        print("Usage: elovclock [OPTIONS]")
        print("A digital terminal clock recreated in Python.")
        print("\nOptions:")
        print("  -1, --once   Print the clock once and exit")
        print("  -h, --help   Show this help message")
        sys.exit(0)

    run_once = "-1" in sys.argv or "--once" in sys.argv

    # Set up signal handling
    signal.signal(signal.SIGINT, _sig_handler)
    signal.signal(signal.SIGTERM, _sig_handler)

    if _is_terminal:
        atexit.register(_restore_terminal)
        # Hide cursor
        sys.stdout.write("\033[?25l")
        sys.stdout.flush()

    try:
        while _running:
            frame = render_frame()
            sys.stdout.write(frame)
            sys.stdout.flush()

            if run_once or not _is_terminal:
                break

            # Sleep synchronized to the next second boundary
            now = time.time()
            sleep_duration = 1.0 - (now % 1.0)
            if sleep_duration <= 0.05:
                sleep_duration = 1.0

            # Break sleep into small chunks for responsive signal handling
            end_time = now + sleep_duration
            while _running and time.time() < end_time:
                time.sleep(min(0.1, max(0.01, end_time - time.time())))
    except KeyboardInterrupt:
        pass
    finally:
        _restore_terminal()


if __name__ == "__main__":
    main()
