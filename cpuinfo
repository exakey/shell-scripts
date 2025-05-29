#!/usr/bin/env sh

# CPU model
model=$(cat /proc/cpuinfo | grep 'model name' | head -n 1 | awk -F ': ' '{print $2}')

# CPU utilization
utilization=$(top -bn1 | awk '/^%Cpu/ {print 100 - $8}')

# Clock speed
freqlist=$(cat /proc/cpuinfo | grep "cpu MHz" | awk '{ print $4 }')
maxfreq=$(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq | sed 's/...$//')
frequency=$(echo $freqlist | tr ' ' '\n' | awk "{ sum+=\$1 } END {printf \"%.0f/$maxfreq MHz\", sum/NR}")

# CPU temp
temp=$(sensors | awk '/Package id 0/ {print $4}' | awk -F '[+.]' '{print $2}')
if [ -z "$temp" ]; then
    temp=$(sensors | awk '/Tctl/ {print $2}' | tr -d '+°C')
fi
if [ -z "$temp" ]; then
    temp="N/A"
fi

# map icons
set_ico="{\"thermo\":{\"0\":\"\",\"45\":\"\",\"65\":\"\",\"85\":\"\"},\"emoji\":{\"0\":\"❄️\",\"45\":\"☁️\",\"65\":\"🔥\",\"85\":\"🌋\"},\"util\":{\"0\":\"󰾆\",\"30\":\"󰾅\",\"60\":\"󰓅\",\"90\":\"\"}}"
eval_ico() {
    map_ico=$(echo "${set_ico}" | jq -r --arg aky "$1" --argjson avl "$2" '.[$aky] | keys_unsorted | map(tonumber) | map(select(. <= $avl)) | max')
    echo "${set_ico}" | jq -r --arg aky "$1" --arg avl "$map_ico" '.[$aky] | .[$avl]'
}

thermo=$(eval_ico thermo $temp)
emoji=$(eval_ico emoji $temp)
speedo=$(eval_ico util $utilization)

# Print cpu info (json)
echo "{\"text\":\"${temp}°C\", \"tooltip\":\"${model}\n${thermo} Temperature: ${temp}°C ${emoji}\n${speedo} Utilization: ${utilization}%\n Clock Speed: ${frequency}\"}"
