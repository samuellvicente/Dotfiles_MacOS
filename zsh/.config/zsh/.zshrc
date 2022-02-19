# Zsh cache directory
ZCACHE=$HOME/.local/share/zsh

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
setopt prompt_subst
# Quick jump for recent directories
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Disable ctrl-s to freeze terminal.
stty stop undef

# Enable colors and change left prompt:
autoload -U colors && colors	# Load colors
PROMPT="%B%F{magenta}%~ %F{yellow}%(!.%(?.%F{yellow}#.%F{red}#).%(?.%F{yellow}$.%F{red}$)) %f%b"

# Enable git info TODO
#autoload -Uz vcs_info
#zstyle ':vcs_info:*' enable git # just git
#
## add a function to check for untracked files in the directory.
#zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
## 
#+vi-git-untracked(){
#    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
#        git status --porcelain | grep '??' &> /dev/null ; then
#        hook_com[staged]+='!' # signify new files with a bang
#    fi
#}
#
#zstyle ':vcs_info:*' check-for-changes true
## zstyle ':vcs_info:git:*' formats " %r/%S %b %m%u%c "
#zstyle ':vcs_info:git:*' formats "%m %u %c %b %r"
#
#precmd_vcs_info() { vcs_info }
#precmd_functions+=( precmd_vcs_info )
#
#RPROMPT=\$vcs_info_msg_0_

# Load aliases and functions
[ -f "$ZDOTDIR/zsh-aliases" ] && source "$ZDOTDIR/zsh-aliases"
[ -f "$ZDOTDIR/zsh-local-aliases" ] && source "$ZDOTDIR/zsh-local-aliases"
[ -f "$ZDOTDIR/zsh-functions" ] && source "$ZDOTDIR/zsh-functions"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d $ZCACHE/.zcompdump
# Include hidden files.
_comp_options+=(globdots)		
# case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
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
bindkey '^p' up-history
bindkey '^n' down-history
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

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

# Edit line in editor with ctrl-e:
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# Add bd
autoload -Uz $ZDOTDIR/plugins/zsh-bd/bd.zsh
bd.zsh

# Load syntax highlighting;
source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 
