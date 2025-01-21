#!/usr/bin/env sh

if pgrep -x "hyprsunset" >/dev/null; then
        pkill -x "hyprsunset"
        echo "hyprsunset was running and has been killed."
else
        hyprsunset -t 5800 &
        echo "hyprsunset was not running and has been started."
fi
