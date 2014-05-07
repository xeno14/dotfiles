#!/bin/bash


#
# create symbolic links to dotfiles/folders in this folder
#  


echo "Execute this script at dotfiles folder"
echo "Are you sure to execute? [y/n]"
read ans

if [ $ans != "y" ]; then
    echo "aborted."
    exit 1
fi


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


git submodule init
git submodule update
