#!/bin/bash


# dotfiles へリンクを貼る

for i in $(find $(pwd) -maxdepth 1 -mindepth 1); do
	fname=$(basename $i)

	#自分にはリンク貼らない
	if [ $fname != $0 ]; then
		target=$HOME

		if [ $(echo $fname | cut -c1) == "." ]; then
			target=$target/$fname
		else
			target=$target/"."$fname
		fi

		#バックアップの作成
		mv $target $target".bak"

		#シンボリックリンクの作成
		ln -s $i $target

		if [ $? -eq 0 ]; then
			echo "Link: "$target" -> "$fname
		else
			echo "Link: Error has occured."
		fi
	fi
done
