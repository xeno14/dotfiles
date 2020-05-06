#!/bin/bash

dotfiledir="$(cd $(dirname $0) && pwd)"
installtxt="${dotfiledir}/install.txt"

cat $installtxt | while read line; do
  echo $line
  src=$dotfiledir/$line
  dst=${HOME}/$line
  ln -snfv $src $dst
done

# zinit
# https://github.com/zdharma/zinit
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

# dein.vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh 
sh ./installer.sh $dotfiledir/.config/nvim/dein

# peco
echo "Install peco: https://github.com/peco/peco/releases/latest"
