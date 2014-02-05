#!/bin/bash


# dotfiles へリンクを貼る

for i in $(find $(pwd) -maxdepth 1 -mindepth 1); do
	fname=$(basename $i)

	#自分にはリンク貼らない
	if [ $fname != $(basename $0) -a $fname != ".git" ]; then
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
			echo "Link: Error has occured. "$target" -> "$fname
		fi
	fi
done

#NeoBundleのインストール
if [ ! -d $HOME/.vim/bundle ]; then
	mkdir -p $HOME/.vim/bundle
fi
if [ ! -f $HOME/.vim/bundle/neobundle.vim ]; then
	git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
else
	"NeoBundle is already installed."
fi
