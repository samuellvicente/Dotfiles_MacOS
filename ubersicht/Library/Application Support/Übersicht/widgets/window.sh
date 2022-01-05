#!/bin/bash

/usr/local/bin/yabai -m query --windows --display $1 | /usr/local/bin/jq '.[] | "\(.focused) \(.space) \(.app) \(.title)"' | sed -E "s/\\\//g" | tr -d '"' | /Users/samuelvicente/Library/Application\ Support/Übersicht/widgets/filter.awk
