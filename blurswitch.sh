#!/usr/bin/env sh

BLUR=$(hyprctl getoption decoration:blur:enabled | grep "str" | awk '{print $2}' | sed 's/"//g')

if [ "$BLUR" = "true" ]; then
  sed -i '0,/true/{s/true/false/}' ~/.config/hypr/userprefs.conf
elif [ "$BLUR" = "false" ]; then
  sed -i '0,/false/{s/false/true/}' ~/.config/hypr/userprefs.conf
fi

hyprctl reload

BLUR_INFO=$(hyprctl getoption decoration:blur:enabled | grep "str" | awk '{print $2}' | sed 's/"//g')

notify-send -a "t3" -t 1000 "${BLUR_INFO}"
