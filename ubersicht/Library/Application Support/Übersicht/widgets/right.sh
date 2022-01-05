#!/bin/sh

battery=`pmset -g batt | awk '{getline; $3=substr($3, 1, length($3)-1); $4=($4=="charging;") ? "" : ""; print $3" "$4}'`

date=$(date +%d/%m/%Y\ %H:%M)

audio=$(osascript -e 'set ovol to output volume of (get volume settings)')

echo "$audio%  | $battery | $date"


