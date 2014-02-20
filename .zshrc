#--------------------------------------------------#
# For MaxOS
#--------------------------------------------------#
if [ $(uname) = "Darwin" ]
then
	#alias to MacVim
	alias gvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim -g "$@"'
fi



#--------------------------------------------------#
# Environment variable configuration
#--------------------------------------------------#
export LANG=ja_JP.UTF-8



#--------------------------------------------------#
# Prompt
#--------------------------------------------------#
autoload colors
colors

PROMPT="[%n@%m]$ "
PROMPT2="[%n@%m]$ "
RPROMPT="%1(v|%F{green}%1v%f|)%{${fg[yellow]}%}[%~]%{${reset_color}%}"



#--------------------------------------------------#
# Options
#--------------------------------------------------#

# auto change directory
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd

# command correct edition before each completion attempt
setopt correct

# compacked complete list display
setopt list_packed

# no remove postfix slash of command line
setopt noautoremoveslash

# no beep sound when complete list displayed
setopt nolistbeep

# Keybind configuration vi like
bindkey -v

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

## Command history configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

## Completion configuration
autoload -U compinit
compinit



#--------------------------------------------------#
# Alias configuration
#--------------------------------------------------#

# expand aliases before completing
setopt complete_aliases # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
	freebsd*|darwin*)
		alias ls="ls -G -w"
		;;
	linux*)
		alias ls="ls --color"
		;;
esac

case "${OSTYPE}" in
	darwin*)
		alias gvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/MacVim'
		;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias g++="g++ -std=c++0x"	#always allow c++11
alias :q='exit'
alias :e='vim'



#--------------------------------------------------#
# Terminal configuration
#--------------------------------------------------#

unset LSCOLORS
case "${TERM}" in
	xterm)
		export TERM=xterm-color
		;;
	kterm)
		export TERM=kterm-color
		# set BackSpace control character
		stty erase
		;;
	cons25)
		unset LANG
		export LSCOLORS=gxfxcxdxbxegedabagacad
		export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
		zstyle ':completion:*' list-colors \
			'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
		;;
esac



# set terminal title including current directory
# and current branch if the directory is git repo
#

autoload -Uz vcs_info
case "${TERM}" in
	kterm*|xterm*)
		precmd() {
			psvar=()
			LANG=en_US.UTF-8 vcs_info
			[[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
			echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}${BRANCH}\007"
		}
		export LSCOLORS=gxfxcxdxbxegedabagacad
		export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
		zstyle ':completion:*' list-colors \
			'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
		zstyle ':vcs_info:*' formats '[%b]'
		zstyle ':vcs_info:*' actionformats '[%b|%a]'
		;;
esac



#--------------------------------------------------#
# extract compressed files
#--------------------------------------------------#

function extract() {
	case $1 in
		*.tar.gz|*.tgz) tar xzvf $1;;
		*.tar.xz) tar Jxvf $1;;
		*.zip) unzip $1;;
		*.lzh) lha e $1;;
		*.tar.bz2|*.tbz) tar xjvf $1;;
		*.tar.Z) tar zxvf $1;;
		*.gz) gzip -dc $1;;
		*.bz2) bzip2 -dc $1;;
		*.Z) uncompress $1;;
		*.tar) tar xvf $1;;
		*.arj) unarj $1;;
	esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract



#--------------------------------------------------#
# Vi like status
#
# http://www.zsh.org/mla/users/2002/msg00108.html
#--------------------------------------------------#

# function zle-line-init zle-keymap-select {
#     export p_vistatus="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#     #RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#     #RPS2=$RPS1
#     zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select


# #Reads until the given character has been entered.
# #
# readuntil () {
#     typeset a
#     while [ "$a" != "$1" ]
#     do
#         read -E -k 1 a
#     done
# }
#
# #
# # If the $SHOWMODE variable is set, displays the vi mode, specified by
# # the $VIMODE variable, under the current command line.
# # 
# # Arguments:
# #
# #   1 (optional): Beyond normal calculations, the number of additional
# #   lines to move down before printing the mode.  Defaults to zero.
# #
# showmode() {
#     typeset movedown
#     typeset row
#
#     # Get number of lines down to print mode
#     movedown=$(($(echo "$RBUFFER" | wc -l) + ${1:-0}))
#
#     # Get current row position
#     echo -n "\e[6n"
#     row="${${$(readuntil R)#*\[}%;*}"
#
#     # Are we at the bottom of the terminal?
#     if [ $((row+movedown)) -gt "$LINES" ]
#     then
#         # Scroll terminal up one line
#         echo -n "\e[1S"
#
#         # Move cursor up one line
#         echo -n "\e[1A"
#     fi
#
#     # Save cursor position
#     echo -n "\e[s"
#
#     # Move cursor to start of line $movedown lines down
#     echo -n "\e[$movedown;E"
#
#     # Change font attributes
#     echo -n "\e[1m"
#
#     # Has a mode been set?
#     if [ -n "$VIMODE" ]
#     then
#         # Print mode line
#         echo -n "-- $VIMODE -- "
#     else
#         # Clear mode line
#         echo -n "\e[0K"
#     fi
#
#     # Restore font
#     echo -n "\e[0m"
#
#     # Restore cursor position
#     echo -n "\e[u"
# }
#
# clearmode() {
#     VIMODE= showmode
# }
#
# #
# # Temporary function to extend built-in widgets to display mode.
# #
# #   1: The name of the widget.
# #
# #   2: The mode string.
# #
# #   3 (optional): Beyond normal calculations, the number of additional
# #   lines to move down before printing the mode.  Defaults to zero.
# #
# makemodal () {
#     # Create new function
#     eval "$1() { zle .'$1'; ${2:+VIMODE='$2'}; showmode $3 }"
#
#     # Create new widget
#     zle -N "$1"
# }
#
# # Extend widgets
# makemodal vi-add-eol           INSERT
# makemodal vi-add-next          INSERT
# makemodal vi-change            INSERT
# makemodal vi-change-eol        INSERT
# makemodal vi-change-whole-line INSERT
# makemodal vi-insert            INSERT
# makemodal vi-insert-bol        INSERT
# makemodal vi-open-line-above   INSERT
# makemodal vi-substitute        INSERT
# makemodal vi-open-line-below   INSERT 1
# makemodal vi-replace           REPLACE
# makemodal vi-cmd-mode          NORMAL
#
# unfunction makemodal
