#!/usr/bin/env sh

# scrDir=$(dirname "$(realpath "$0")")
# source "$scrDir"/globalcontrol.sh
# rofiConf="${confDir}/rofi/quickapps.rasi"
#
# [[ "$rofiScale" =~ ^[0-9]+$ ]] || rofiScale=10
# r_scale="configuration {font: \"Monocraft ${rofiScale}\";}"
# r_override="window {height: 18em; width: 14em; border: ${hypr_width}px; border-radius: 0;} element {border-radius: 0;}"
#
# shader_status=$(hyprshade current)
# shader_list=$(ls "$confDir/hypr/shaders" | sed 's/\.[^.]*$//')
#
# read -r selected_shader <<<"${selected_option:2}"
#
# if [[ "$shader_status" =~ "" ]]; then
#   selected_option=$(echo -e "$shader_list" | uniq -u | rofi -dmenu -theme-str "$r_override" -theme-str "$r_scale" -config "$rofiConf")
#
# else
#   selected_option=$(echo -e "Disable\n$shader_list" | uniq -u | rofi -dmenu -theme-str "$r_override" -theme-str "$r_scale" -config "$rofiConf")
# fi
#
# if [ "$selected_option" = "" ]; then
#   exit
#
# elif [ "$selected_option" = "Disable" ]; then
#   hyprshade off
#
# elif [ "$selected_option" = "*.frag" ]; then
#   hyprshade on "$selected_shader"
# fi


#!/usr/bin/env sh

# Set up script directory and configuration paths
scrDir=$(dirname "$(realpath "$0")")
source "$scrDir"/globalcontrol.sh
rofiConf="${confDir}/rofi/quickapps.rasi"

# Set font scaling and rofi theme options
[[ "$rofiScale" =~ ^[0-9]+$ ]] || rofiScale=10
r_scale="configuration {font: \"Monocraft ${rofiScale}\";}"
r_override="window {height: 18em; width: 14em; border: ${hypr_width}px; border-radius: 0;} element {border-radius: 0;}"

# Get the current shader status and list of available shaders
shader_status=$(hyprshade current)
shader_list=$(ls "$confDir/hypr/shaders" | sed 's/\.[^.]*$//')

# Check if there is an active shader
if [[ "$shader_status" == "" ]]; then
  # If no shader is active, offer "Toggle" as the first option
  selected_option=$(echo -e "Enable\n$shader_list" | rofi -dmenu -theme-str "$r_override" -theme-str "$r_scale" -config "$rofiConf")
else
  # If a shader is active, offer "Disable" as the first option
  selected_option=$(echo -e "Disable\n$shader_list" | rofi -dmenu -theme-str "$r_override" -theme-str "$r_scale" -config "$rofiConf")
fi

# Exit if no option is selected
if [ "$selected_option" = "" ]; then
  exit
fi

# Handle shader toggling or enabling
if [ "$selected_option" = "Disable" ]; then
  hyprshade off  # Disable the shader
elif [ "$selected_option" = "Enable" ]; then
  # Enable the most recent shader (the last one from the list)
  last_shader=$(tail -n 1 "$confDir/hypr/shaders/.last_shader.txt")
  hyprshade on "$last_shader"
else
  # Enable the selected shader
  hyprshade on "$selected_option"

  # Update the last used shader (for future "Toggle" option)
  echo "$selected_option" > "$confDir/hypr/shaders/.last_shader.txt"
fi
shader_status=$(hyprshade current)
notify-send "Shader: $shader_status"
