#!/usr/bin/env sh

wayConf="$HOME/.config/waybar"

if pgrep -x "waybar" >/dev/null; then
        pkill -x "waybar"
else
        case "$1" in
                c) waybar -c "${wayConf}/corner.jsonc" -s "${wayConf}/corner.css" ;;
                t) waybar -c "${wayConf}/top.jsonc" -s "${wayConf}/top.css" ;;
                b) waybar -c "${wayConf}/bottom.jsonc" -s "${wayConf}/bottom.css" ;;
                tb) waybar -c "${wayConf}/topbottom.jsonc" -s "${wayConf}/topbottom.css" ;;
                lr) waybar -c "${wayConf}/leftright.jsonc" -s "${wayConf}/leftright.css" ;;
        esac
fi
