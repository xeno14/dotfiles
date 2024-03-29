#--------------------------------------------------#
# Environment variable configuration
#--------------------------------------------------#
typeset -U path
fpath=(${HOME}/.zsh/completion $fpath)


# pyenv
if [ -d $HOME/.pyenv ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi


#--------------------------------------------------#
# Options
#--------------------------------------------------#
#
export TERM=xterm-256color

## auto change directory
setopt auto_cd

## auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd

## command correct edition before each completion attempt
setopt correct

## compacked complete list display
setopt list_packed

## no remove postfix slash of command line
setopt noautoremoveslash

## no beep sound when complete list displayed
setopt nolistbeep
## match capital and lower both
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## ignore
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~'

## Keybind configuration vi like
# bindkey -v

## HISTORICAL BACKWARD/FORWARD SEARCH WITH LINEHEAD STRING BINDED TO ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

## Command history configuration
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=10000
export SAVEHIST=100000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

## Completion configuration
autoload -U compinit
compinit -u

## enable cdr
autoload -Uz is-at-least
if is-at-least 4.3.11; then
	autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
	add-zsh-hook chpwd chpwd_recent_dirs
	zstyle ':chpwd:*' recent-dirs-max 5000
	zstyle ':chpwd:*' recent-dirs-default yes
	zstyle ':completion:*' recent-dirs-insert both
fi

## zmv
autoload -Uz zmv

## report time when process takes time over 3
REPORTTIME=3

setopt hist_ignore_all_dups

# Disable beep.
unsetopt beep

#--------------------------------------------------#
# key binding
#--------------------------------------------------#
bindkey "^[OH" beginning-of-line  # home
bindkey "^[OF" end-of-line        # end
bindkey "^[[3~" delete-char       # del

#--------------------------------------------------#
# Alias configuration
#--------------------------------------------------#

## expand aliases before completing
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

## tmux
alias tmux='tmux -2'

## gvim (for OSX)
case "${OSTYPE}" in
	darwin*)
		alias gvim='env LANG=ja_JP.UTF-8 open -a macvim'
		;;
esac

## cmake-gui for mac
case "${OSTYPE}" in
	darwin*)
    alias cmake-gui='open -a CMake'
    ;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
# alias ks="sl"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias :q='exit'
alias :e='vim'

alias calc='emacs -f full-calc'



#--------------------------------------------------#
# Color Configuration
#--------------------------------------------------#

#export LSCOLORS=gxfxcxdxbxegedabagacad
#export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#zstyle ':completion:*' list-colors ${LS_COLORS}


#--------------------------------------------------#
# zinit
#--------------------------------------------------#
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

### plugins
zinit light "mollifier/anyframe"
zinit light "yonchu/zsh-vcs-prompt" #, use:zshrc.sh
zinit light "zsh-users/zsh-syntax-highlighting"
# zinit light "zsh-users/zaw", use:zaw.zsh


#--------------------------------------------------#
# anyframe
#--------------------------------------------------#
fpath=(${HOME}/.zinit/plugins/mollifier---anyframe(N-/) $fpath)

autoload -Uz anyframe-init
anyframe-init

bindkey '^x:'  anyframe-widget-select-widget
bindkey '^x/'  anyframe-widget-cdr
bindkey '^xp'  anyframe-widget-kill
bindkey '^xh'  anyframe-widget-put-history


#--------------------------------------------------#
# zsh-vcs-prompt
#--------------------------------------------------#
ZSH_VCS_PROMPT_ENABLE_CACHING='true'
ZSH_VCS_PROMPT_UNTRACKED_SIGIL='？'


#--------------------------------------------------#
# zaw
#--------------------------------------------------#
# if zplug check "zsh-users/zaw"; then
#   bindkey '^xg' zaw-git-status
#   bindkey '^xt' zaw-tmux
# fi


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


## PROMPT
PROMPT=""
PROMPT+="%(?.%F{green}^-^%f.%F{red}O_O%f) "
PROMPT+="%F{yellow}[%~]%f "		  #current directory
PROMPT+='$(vcs_super_info)'     #vcs info
PROMPT+="
"
PROMPT+="[%n@%m]$ "
PROMPT2="$ "


#--------------------------------------------------#
# extract compressed files
#--------------------------------------------------#

function extract() {
	case $1 in
		*.tar.gz|*.tgz) tar xzvf $1;;
		*.tar.xz) tar Jxvf $1;;
    *.tar.lz) tar --lzip -xvf $1;;
    *.7z) 7z x $1;;
    *.xz) xz -dv $1;;
		*.zip) unzip $1;;
		*.lzh) lha e $1;;
		*.tar.bz2|*.tbz) tar xjvf $1;;
		*.tar.Z) tar zxvf $1;;
		*.gz) gzip -dc $1;;
		*.bz2) bzip2 -dc $1;;
		*.Z) uncompress $1;;
		*.tar) tar xvf $1;;
		*.arj) unarj $1;;
    *) echo "I don't know such filetype.";;
	esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract



local zsh_local="${HOME}/.zshrc.local"
if [ -f ${zsh_local} ]; then
  source ${zsh_local}
fi


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


open () { explorer.exe "$(wslpath -w "$(realpath "$1")")"  }

if type most > /dev/null 2>&1; then
  export PAGER="most"
fi

