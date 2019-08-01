#!/usr/bin/env python3.7

import iterm2
from sys import argv

async def main(connection):
    profiles = [p for p in await iterm2.PartialProfile.async_query(connection) if p.name.startswith("Default ")]
    if len(argv) > 1:
        is_dark_theme = str(argv[1])
    else:
        import subprocess
        result = subprocess.run(['osascript', '-e', 'tell application "System Events" to tell appearance preferences to return (get dark mode as text)'], stdout=subprocess.PIPE)
        is_dark_theme = str(result.stdout.rstrip().decode("utf-8"))

    for p in profiles:
        if "Light" in p.name and is_dark_theme == "false":
            await p.async_make_default()
        elif "Dark" in p.name and is_dark_theme == "true":
            await p.async_make_default()

iterm2.run_until_complete(main)
