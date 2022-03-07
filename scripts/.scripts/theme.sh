sed -i -n 's/DARK/LIGHT/
t
s/LIGHT/DARK/' /Users/samuelvicente/.config/kitty/kitty.conf /Users/samuelvicente/.config/nvim/init.lua;

ps ax | grep "Kitty.app" | awk 'NR==1 {print$1}' | xargs kill -USR1;

osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode';


