#! /bin/bash

set -eu
set -o pipefail

if [ $# -lt 2 ]
then
  echo "USAGE: dot.sh <input> <source dir>" 1>&2
  exit 1
fi

input=$1
src=$2

for i in $(grep -vE "^\s*#" ${input})
do
  echo ${i}
  if [ -L ${HOME}/${i} ]; then continue; fi
  if [ -f ${HOME}/${i} ]; then rm -f ${HOME}/${i}; fi
  mkdir -p ${HOME}/$(dirname ${i})
  ln -s ${src}/${i} ${HOME}/${i}
done
