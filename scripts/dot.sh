#! /bin/sh
for i in $(cat Dotfile)
  do rm -rf ${HOME}/${i}
  mkdir -p $(dirname ${i})
  ln -s $(pwd)/dotfiles/${i} ${HOME}/${i}
done
