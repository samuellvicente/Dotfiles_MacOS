#!/bin/sh
hour=$(./scripts/hour.sh)
battery=$(./scripts/battery.sh)
#cpuTemp=$(./scripts/cputemp.sh)

echo "$battery | $hour"
#echo "$cputemp | $battery | $hour"
