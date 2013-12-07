# users generic .zshrc file for zsh(1)

#alias gvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim -g "$@"'

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8

## Default shell configuration
#
# set prompt
#
autoload colors
colors
PROMPT="[%n@%m] $ "
PROMPT2="[%n@%m]$ "
RPROMPT="%{${fg[yellow]}%}[%~]%{${reset_color}%}"



# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes 
# to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

## Completion configuration
#
autoload -U compinit
compinit

## Alias configuration
#
# expand aliases before completing
#
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

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"

## terminal configuration
#
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
#
case "${TERM}" in
	kterm*|xterm*)
		precmd() {
			echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
		}
		export LSCOLORS=gxfxcxdxbxegedabagacad
		export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
		zstyle ':completion:*' list-colors \
			'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
		;;
esac

## load user .zshrc configuration file
#
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine


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


#when something is done collectly, say something
export VOICE_FAILED=~/Music/voices/kugimiya_machigai.wav
function statusVoice(){
if [ $(echo $?) -eq 0 ]; then
	say complete
else
	afplay $VOICE_FAILED
fi
}
#alias make="make; statusVoice"

#g++ always allow c++0x
alias g++="g++ -std=c++0x"
