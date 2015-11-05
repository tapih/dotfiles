# /bin/bash

echo "overwrite?"
echo "  ~/.vimrc"
echo "  ~/.screenrc"
echo "  ~/.zshrc"
echo "  ~/.dircolors"
echo "(y/n [n]): "
read -t 10 ans

if [ $ans = 'y' ] ; then
    cp .vimrc ~/.vimrc
    cp .zshrc ~/.zshrc
    cp .screenrc ~/.screenrc
    cp .dircolors ~/.dircolors
    source ~/.zshrc
fi
