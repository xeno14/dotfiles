#!/bin/bash


#
# create symbolic links to dotfiles/folders in this folder
#  



for i in $(find $(pwd) -maxdepth 1 -mindepth 1); do
	fname=$(basename $i)

	if [ $fname != $(basename $0) -a $fname != ".git" ]; then
		target=$HOME

		if [ $(echo $fname | cut -c1) == "." ]; then
			target=$target/$fname
		else
			target=$target/"."$fname
		fi

		#create backups
		mv $target $target".bak" 

		#create symbolic link
		ln -s $i $target

		if [ $? -eq 0 ]; then
			echo "Link: "$target" -> "$fname
		else
			echo "Link: Error has occured. "$target" -> "$fname
		fi
	fi
done

#install NeoBundle
mkdir -p $HOME/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
