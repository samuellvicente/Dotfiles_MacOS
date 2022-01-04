#!/bin/sh
/usr/local/bin/istats cpu temp | awk '{print $3}'
