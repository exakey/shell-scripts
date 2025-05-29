#!/usr/bin/env sh

scrDir="$(dirname "$(realpath "$0")")"
source "${scrDir}"/globalcontrol_fixed.sh
roconf="${confDir}/rofi/quickapps.rasi"

[[ $rofiScale =~ ^[0-9]+$ ]] || rofiScale=11

if [ ! -f "$roconf" ]; then
        roconf="$(find "${confDir}/rofi/styles" -type f -name "style_*.rasi" | sort -t '_' -k 2 -n | head -1)"
fi

case "${1}" in
        d | --drun) r_mode="drun" ;;
        w | --window) r_mode="window" ;;
        f | --filebrowser) r_mode="filebrowser" ;;
        h | --help)
                echo -e "$(basename "${0}") [action]"
                echo "d :  drun mode"
                echo "w :  window mode"
                echo "f :  filebrowser mode,"
                exit 0
                ;;
        *) r_mode="drun" ;;
esac

[ "$hypr_border" -eq 0 ]
r_override="window {height: 18em; width: 20em; border: ${hypr_width}px; border-radius: 0;} element {border-radius: 0;}"
r_scale="configuration {font: \"Monocraft ${rofiScale}\";}"
i_override="$(gsettings get org.gnome.desktop.interface icon-theme | sed "s/'//g")"
i_override="configuration {icon-theme: \"${i_override}\";}"

rofi -show "$r_mode" -theme-str "$r_scale" -theme-str "$r_override" -theme-str "$i_override" -config "$roconf"
