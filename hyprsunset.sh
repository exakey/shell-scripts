#!/usr/bin/env sh

if pgrep -x "hyprsunset" >/dev/null; then
        pkill -x "hyprsunset"
else
        hyprsunset -t 5400 &
fi
