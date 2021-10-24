#! /bin/sh

set -e

if [ $# -lt 1 ]
then
  echo "USAGE: dot.sh <file>" 1>&2
  exit 1
fi

file=$1

for i in $(grep -vE "^\s*#" ${file})
do
  echo ${i}
  if [ -L ${HOME}/${i} ]; then continue; fi
  if [ -f ${HOME}/${i} ]; then rm -f ${HOME}/${i}; fi
  mkdir -p $(dirname ${i})
  ln -s $(pwd)/dotfiles/${i} ${HOME}/${i}
done
