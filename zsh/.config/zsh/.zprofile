# History files 
export LESSHISTFILE=$HOME/.local/share/less/.lesshst

# Locale settings irish english offers best settings
export LANG=en_IE.UTF-8
export LC_ALL=en_IE.UTF-8

# HomeBrew options
export HOMEBREW_CASK_OPTS=--no-quarantine

# Homebrew sbin in path
export PATH="/usr/local/sbin:$PATH"

# Add GOPATH to PATH
export GOPATH="$HOME/.go"
export PATH="$GOPATH/bin:$PATH"

# Add java to PATH
export JAVA_HOME="/usr/local/opt/openjdk@11"
export PATH="$JAVA_HOME/bin:$PATH"

# Dbus for zathura synctex
export DBUS_SESSION_BUS_ADDRESS='unix:path='$DBUS_LAUNCHD_SESSION_BUS_SOCKET
