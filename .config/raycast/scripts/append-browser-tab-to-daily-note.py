#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Append Browser Tab to Daily Note
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🌐

# Documentation:
# @raycast.description Append current browser tab title to Obsidian daily note with timestamp
# @raycast.author raeperd
# @raycast.authorURL https://raycast.com/raeperd

import sys
from datetime import datetime
import urllib.parse
import subprocess

def main():
    # Get frontmost application name
    try:
        frontmost_app = subprocess.run(
            ['osascript', '-e', 'tell application "System Events" to return name of first application process whose frontmost is true'],
            capture_output=True,
            text=True
        ).stdout.strip()
    except subprocess.CalledProcessError:
        print("failed: cannot get active window")
        sys.exit(1)

    # Get browser tab title and URL
    try:
        browser_title = subprocess.run(
            ['osascript', '-e', f'tell application "{frontmost_app}" to return title of active tab of front window'],
            capture_output=True,
            text=True
        ).stdout.strip()
        
        browser_url = subprocess.run(
            ['osascript', '-e', f'tell application "{frontmost_app}" to return URL of active tab of front window'],
            capture_output=True,
            text=True
        ).stdout.strip()
    except subprocess.CalledProcessError:
        print(f"failed: cannot get browser tab info")
        sys.exit(1)
    
    # Get current time in HH:mm format
    current_time = datetime.now().strftime("%H:%M")
    
    # Format the message with timestamp and markdown link
    formatted_message = f"- {current_time} [{browser_title}]({browser_url})"
    
    # URL encode the message
    encoded_message = urllib.parse.quote(formatted_message)
    
    # Construct the Obsidian URI
    uri = f"obsidian://adv-uri?daily=true&data={encoded_message}&mode=append"
    
    # Open Obsidian with the URI
    try:
        result = subprocess.run(["open", "-g", uri], capture_output=True, text=True, check=True)
        print(f"logged: {formatted_message}")
    except subprocess.CalledProcessError as e:
        print(f"failed: cannot open obsidian")
        sys.exit(1)

if __name__ == "__main__":
    main() 