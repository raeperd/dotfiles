#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Append Clipboard to Daily Note
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 📋

# Documentation:
# @raycast.description Append clipboard content to Obsidian daily note with timestamp
# @raycast.author raeperd
# @raycast.authorURL https://raycast.com/raeperd

import sys
from datetime import datetime
import urllib.parse
import subprocess

def main():
    # Get clipboard content
    try:
        result = subprocess.run(["pbpaste"], capture_output=True, text=True)
        message = result.stdout.strip()
    except subprocess.CalledProcessError:
        print("failed: cannot read clipboard")
        sys.exit(1)
    
    # Get current time in HH:mm format
    current_time = datetime.now().strftime("%H:%M")
    
    # Format the message with timestamp
    formatted_message = f"- {current_time} {message}"
    
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