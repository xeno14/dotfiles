#!/bin/bash


# get dotfiles dir as absolute path

dotfiledir="$(cd $(dirname $0) && pwd)"
installtxt="${dotfiledir}/install.txt"


# confirmation
# y : create link
# n : exit
# d : dryrun

echo "Linking these files:"
cat "${installtxt}" | while read line
do
  echo $line
done

echo "are you ready? [y/n/d]"
read ans
if [ "${ans}" = "y" ]; then
  dryrunflag=false
elif [ "${ans}" = "d" ]; then
  dryrunflag=true
else
  echo "aborted."
  exit 1
fi

run(){
  if [ $dryrunflag = true ]; then
    echo "${1}"       #dryrun
  else
    echo "${1}" | sh  #run
  fi
}

run "pwd"


# linking dotfiles to $HOME

cat "${installtxt}" | while read line
do
  # if link already exists, remove it
  # if file or directory exits, rename it with suffix ".backYYMMDD"
  target="${HOME}/${line}"
  source="${dotfiledir}/${line}"
  overwriteflag=false
  if [ -L "${target}" ]; then
    echo -e "\e[33moverwrite link \"${target}\"\e[m"
    run "rm \"${target}\""
    overwriteflag=true
  elif [ -f "${target}" -o -d "${HOME}/${line}" ]; then
    target_back="${target}.back$(date +"%y%m%d")"
    echo -e "\e[31mrenamed \"${target}\" to \"${target_back}\"\e[m"
    run "mv \"${target}\" \"${target_back}\"" 
  fi
  # create link
  if [ ! $overwriteflag  ]; then
    echo -e "\e[32mlinked \"${source}\"\e[m"
  fi
  run "ln -s \"${source}\" \"${target}\""
done

# Install dependencies
if [ $dryrunflag = false ]; then
  # install zplug
  # https://github.com/b4b4r07/zplug
  curl -fLo ~/.zplug/zplug --create-dirs git.io/zplug

  # install dein.vim
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh 
  sh install.sh ${HOME}/.config/nvim/dein
fi

# Show message about dependency
echo "Insall dependencies"
echo "peco https://github.com/peco/peco"
[ $(uname) = Darwin ] && echo "reattach-to-user-namespace"
