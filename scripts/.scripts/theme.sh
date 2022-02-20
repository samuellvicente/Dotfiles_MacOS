sed -i -n 's/DARK/LIGHT/
t
s/LIGHT/DARK/' /Users/samuelvicente/.config/kitty/kitty.conf /Users/samuelvicente/.config/nvim/init.lua;
ps ax | grep "Kitty.app" | awk 'NR==1 {print$1}' | xargs kill -USR1

