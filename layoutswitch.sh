#!/usr/bin/env sh

LAYOUT=$(hyprctl getoption general:layout | grep "str" | awk '{print $2}' | sed 's/"//g')

if [ "$LAYOUT" = "dwindle" ]; then
    sed -i '0,/dwindle/{s/dwindle/master/}' ~/.config/hypr/userprefs.conf
elif [ "$LAYOUT" = "master" ]; then
    sed -i '0,/master/{s/master/dwindle/}' ~/.config/hypr/userprefs.conf
fi

hyprctl reload

NEW_LAYOUT=$(hyprctl getoption general:layout | grep "str" | awk '{print $2}' | sed 's/"//g')

notify-send -a "t3" -t 1000 "${NEW_LAYOUT}"
