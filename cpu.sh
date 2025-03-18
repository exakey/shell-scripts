#!/usr/bin/env sh

scrDir=$(dirname "$(realpath "$0")")
source "$scrDir"/globalcontrol_fixed.sh
roconf="${confDir}/rofi/cpu.rasi"

[[ ${rofiScale} =~ ^[0-9]+$ ]] || rofiScale=14
r_scale="configuration {font: \"Monocraft ${rofiScale}\";}"
r_override="window {height: 1.7em; width: 8em; border: ${hypr_width}px; border-radius: 0;} element {border-radius: 0;}"

current=$(cat /proc/cpuinfo | grep "cpu MHz" | head -n 1 | awk '{print int($4/10+0.5)*10}')

show_freq_info()
{
        local message=$(cat /proc/cpuinfo | grep "cpu MHz" | head -n 1 | awk '{print int($4/10+0.5)*10}')
        notify-send "CPU: $message MHz"
}

min=400
# max=3200
max=4460

freq_range()
{
        [ "$1" -ge $min ] && [ "$1" -le $max ]
}

freq=$(
        rofi -p " CPU " -dmenu -theme-str 'configuration {display-drun: "Applications";}' -theme-str 'entry { placeholder: " MHz";}' -theme-str "${r_scale}" -theme-str "${r_override}" -config "${roconf}"
)

case "${1}" in
        i)
                new=$((current + 200))
                if [ "$new" -le "$max" ]; then
                        sudo cpupower frequency-set -u ${new}MHz > /dev/null 2>&1
                        show_freq_info
                else
                        notify-send "Cannot increase frequency beyond $max MHz."
                fi
                exit
                ;;
        d)
                new=$((current - 200))
                if [ "$new" -ge "$min" ]; then
                        sudo cpupower frequency-set -u ${new}MHz > /dev/null 2>&1
                        show_freq_info
                else
                        notify-send "Cannot decrease frequency below $min MHz."
                fi
                exit
                ;;

        m) if [ -n "$freq" ]; then
                case "$freq" in
                        i)
                                notify-send "CPU: $current MHz"
                                ;;
                        min)
                                sudo cpupower frequency-set -u 400MHz > /dev/null 2>&1
                                show_freq_info
                                ;;
                        max)
                                sudo cpupower frequency-set -u 3200MHz > /dev/null 2>&1
                                show_freq_info
                                ;;
                        *)
                                if [[ $freq =~ ^[0-9]+$ ]] && freq_range "$freq"; then
                                        sudo cpupower frequency-set -u "${freq}"MHz > /dev/null 2>&1
                                        show_freq_info
                                else
                                        notify-send "Invalid input. Please enter a numeric value between $min and $max MHz."
                                fi
                                ;;
                esac
        fi ;;
esac
