#!/bin/sh
[ "$(pgrep "Spotify" | wc -l)" -ne "0" ] &&
IFS='|'  &&
echo "$(echo 'tell application "Spotify"
        set theTrack to current track
        set theArtist to artist of theTrack
        set theName to name of theTrack
        return theArtist & "|" & theName
      end tell' | osascript)" | {
        read -r theArtist theName &&
        if [ -z "$theArtist" ]
        then
          echo ""
        else
          echo "$theArtist: $theName |" || echo "Not Connected To Spotify"
        fi
      }

