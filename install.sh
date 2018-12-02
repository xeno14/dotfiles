#!/bin/bash

dotfiledir="$(cd $(dirname $0) && pwd)"
installtxt="${dotfiledir}/install.txt"

cat $installtxt | while read line; do
  echo $line
  src=$dotfiledir/$line
  dst=${HOME}/$line
  ln -snfv $src $dst
done

# zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh

# dein.vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh 
sh ./installer.sh $dotfiledir/.config/nvim/dein

# peco
echo "Install peco: https://github.com/peco/peco/releases/latest"
