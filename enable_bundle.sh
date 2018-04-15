#! /bin/sh

echo "make directory  ~/.vim/bundle"
mkdir -p ~/.vim/bundle
echo "copy .vimrc.bundle in ~/.vim"
cp ./.vimrc.bundle ~/.vim/

if [ ! -d ~/.vim/bundle ]; then
    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

