#! /bin/sh
#
# install.sh
# Copyright (C) 2019 hmuraoka <hmuraoka@melchior.local>
#
# Distributed under terms of the MIT license.
#

SOURCE_ROOT_DIR=`cd $(dirname $0) && pwd`
TARGET_ROOT_DIR=`cd ~ && pwd`

function make_link() {
    if [ -e $2 ]; then
        echo "Skip: "$2 " already exists."
    else
        ln -s $1 $2
    fi
}

make_link $SOURCE_ROOT_DIR"/.screenrc" $TARGET_ROOT_DIR"/.screenrc"
make_link $SOURCE_ROOT_DIR"/.ideavimrc" $TARGET_ROOT_DIR"/.ideavimrc"
make_link $SOURCE_ROOT_DIR"/.zshrc" $TARGET_ROOT_DIR"/.zshrc"
make_link $SOURCE_ROOT_DIR"/nvim" $TARGET_ROOT_DIR"/.config/nvim"

function make_cache_name() {
    echo ".cache"$1".sh"
}

# install go dependencies
GO111MODULE=off
go get -u golang.org/x/tools/cmd/goimports
go get -u github.com/mdempsky/gocode

# install dein
CACHE_INDEX=1
CACHE_NAME=`make_cache_name $CACHE_INDEX`
while [ -e $CACHE_NAME ]
do
    CACHE_INDEX=`expr $CACHE_INDEX + 1`
    CACHE_NAME=`make_cache_name $CACHE_INDEX`
done

echo "install dein"
TARGET_DIR=$TARGET_ROOT_DIR/.cache/dein
[ -e $TARGET_DIR ] || mkdir -p $TARGET_DIR
curl -sS https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $CACHE_NAME
[ -e $TARGET_DIR"/repos/github.com/Shougo/dein.vim" ] || sh $CACHE_NAME $TARGET_DIR
rm -f $CACHE_NAME

echo "install NeoBundle"
TARGET_DIR=$TARGET_ROOT_DIR/.vim/bundle
[ -e $TARGET_DIR ] || mkdir -p $TARGET_DIR
curl -sS https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > $CACHE_NAME
[ -e $TARGET_DIR"/neobundle.vim" ] || sh $CACHE_NAME
rm -f $CACHE_NAME

