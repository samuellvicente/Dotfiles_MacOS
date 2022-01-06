# Enable key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Show hidden files in Finder
defaults write com.apple.Finder AppleShowAllFiles true

killall Finder
