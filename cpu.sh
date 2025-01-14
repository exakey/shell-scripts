#!/usr/bin/env sh

scrDir=$(dirname "$(realpath "$0")")
source "$scrDir"/globalcontrol.sh
# source $scrDir/cpuinfo.sh
roconf="${confDir}/rofi/cpu.rasi"
LAYOUT=$(hyprctl getoption general:layout | grep "str" | awk '{print $2}' | sed 's/"//g')

[[ "${rofiScale}" =~ ^[0-9]+$ ]] || rofiScale=14
r_scale="configuration {font: \"Monocraft ${rofiScale}\";}"
r_override="window {height: 1.7em; width: 8em; border: ${hypr_width}px; border-radius: 0;} element {border-radius: 0;}"

show_freq_info() {
    local message=$(sudo cpupower frequency-info -fm | grep -E 'current CPU frequency' | sed 's/current //; s/ frequency//; s/ (asserted by call to kernel)//')
    notify-send "$message"
}

freq_range() {
    [ "$1" -ge 400 ] && [ "$1" -le 4400 ]
}

freq=$(
    rofi -p " CPU " -dmenu -theme-str "configuration {display-drun: \"Applications\";}" -theme-str "entry { placeholder: \" MHz\";}" -theme-str "${r_scale}" -theme-str "${r_override}" -config "${roconf}"
)
if [ -n "$freq" ]; then
    case "$freq" in
        l)
            echo "$LAYOUT"
            notify-send -a "t3" -t 800 "${LAYOUT}"
            ;;
        i)
            show_freq_info
            ;;
        min)
            sudo cpupower frequency-set -u 400MHz >/dev/null 2>&1
            show_freq_info
            ;;
        max)
            sudo cpupower frequency-set -u 4000MHz >/dev/null 2>&1
            show_freq_info
            ;;
        *)
            if [[ "$freq" =~ ^[0-9]+$ ]] && freq_range "$freq"; then
                sudo cpupower frequency-set -u "${freq}"MHz >/dev/null 2>&1
                show_freq_info
            else
                notify-send "Invalid input. Please enter a numeric value between 400 and 4400 MHz."
            fi
            ;;
    esac
fi
