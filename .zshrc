
#--------------------------------------------------#
# Environment variable configuration
#--------------------------------------------------#
export LANG=ja_JP.UTF-8


#--------------------------------------------------#
# Prompt
#--------------------------------------------------#

setopt prompt_subst

## visualize vi mode
# function zle-line-init zle-keymap-select {
#     RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#     RPS2=$PS1
#     zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select

## zsh-vcs-prompt
## https://github.com/yonchu/zsh-vcs-prompt
source ~/.zsh/zsh-vcs-prompt/zshrc.sh
ZSH_VCS_PROMPT_ENABLE_CACHING='true'
ZSH_VCS_PROMPT_UNTRACKED_SIGIL='？'


## PROMPT
PROMPT=""
PROMPT+="%F{yellow}[%~]%f "		#current directory
PROMPT+='$(vcs_super_info)'     #vcs
PROMPT+="
"
PROMPT+="[%n@%m]$ "
PROMPT2=PROMPT




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

# not distinguish capital or not
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

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

## enable cdr
if is-at-least 4.3.11; then
	autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
	add-zsh-hook chpwd chpwd_recent_dirs
	zstyle ':chpwd:*' recent-dirs-max 5000
	zstyle ':chpwd:*' recent-dirs-default yes
	zstyle ':completion:*' recent-dirs-insert both
fi


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

# tmux
case "${OSTYPE}" in
	freebsd*|darwin*)
		alias tmux='/usr/local/Cellar/tmux/1.8/bin/tmux -2'
		;;
	linux*)
		alias tmux='tmux -2'
		;;
esac

# gvim (for OSX)
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

case "${TERM}" in
	kterm*|xterm*|screen*)
		export LSCOLORS=gxfxcxdxbxegedabagacad
		export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
		zstyle ':completion:*' list-colors \
			'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
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
# zaw
#--------------------------------------------------#
if [ -f ~/.zsh/zaw/zaw.zsh ]; then
	source ~/.zsh/zaw/zaw.zsh
	bindkey '^@' zaw-cdr
	bindkey '^xh' zaw-history
fi

