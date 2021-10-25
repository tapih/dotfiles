#! /bin/sh

set -e

if [ $# -lt 2 ]
then
  echo "USAGE: dot.sh <file> <dotfile directory>" 1>&2
  exit 1
fi

file=$1
directory=$2

for i in $(grep -vE "^\s*#" ${file})
do
  echo ${i}
  if [ -L ${HOME}/${i} ]; then continue; fi
  if [ -f ${HOME}/${i} ]; then rm -f ${HOME}/${i}; fi
  mkdir -p ${HOME}/$(dirname ${i})
  ln -s ${directory}/${i} ${HOME}/${i}
done
