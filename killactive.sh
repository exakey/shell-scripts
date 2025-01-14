#!/usr/bin/bash

send-notfy "I AM KILLING"
if [ "$(hyprctl activewindow -j | jq -r ".class")" = "Steam" ]; then
  xdotool getactivewindow windowunmap
else
  hyprctl dispatch killactive ""
fi
