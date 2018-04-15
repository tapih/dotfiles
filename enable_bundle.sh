#! /bin/sh

echo "make directory  ~/.vim/bundle"
mkdir -p ~/.vim/bundle
echo "copy .vimrc.bundle in ~/.vim"
cp ./.vimrc.bundle ~/.vim/

git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

