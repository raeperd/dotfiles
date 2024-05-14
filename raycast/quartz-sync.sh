#!/bin/zsh

# Raycast Script Command Template
#
# Duplicate this file and remove ".template." from the filename to get started.
# See full documentation here: https://github.com/raycast/script-commands
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Quartz Sync
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Raycast Scripts

z raeperd.github.io && npx quartz sync
