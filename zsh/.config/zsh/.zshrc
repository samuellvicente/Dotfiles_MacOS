# Zsh cache directory
ZCACHE=$HOME/.local/share/zsh

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[magenta]%}%~ %{$reset_color%}$ %b"

# Disable ctrl-s to freeze terminal.
stty stop undef

# History file configuration
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=$ZCACHE/.zhistory

# Usefull options
setopt autocd 
setopt extendedglob 
setopt nomatch 
setopt menucomplete
setopt interactive_comments 
setopt complete_in_word
setopt hist_save_no_dups 
setopt share_history

# Quick jump for recent directories
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Load aliases and functions
[ -f "$ZDOTDIR/zsh-aliases" ] && source "$ZDOTDIR/zsh-aliases"
[ -f "$ZDOTDIR/zsh-functions" ] && source "$ZDOTDIR/zsh-functions"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d $ZCACHE/.zcompdump
# Include hidden files.
_comp_options+=(globdots)		

# vi mode
bindkey -v
KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Faster than going to normal mode:
bindkey '^k' up-history
bindkey '^j' down-history

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
# initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    zle -K viins 
    echo -ne "\e[5 q"
}
zle -N zle-line-init
# Use beam shape cursor on startup.
echo -ne '\e[5 q' 
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;} 

# Launch vifm in the current directory
bindkey -s '^o' 'vifm . ^M'

# Edit line in vim with ctrl-e:
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# Add bd
autoload -Uz $ZDOTDIR/plugins/zsh-bd/bd.zsh
bd.zsh

# Load syntax highlighting;
source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 
