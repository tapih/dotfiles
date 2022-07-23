#! /bin/sh

set -e

if [ $# -lt 2 ]
then
  echo "USAGE: dot.sh <target> <destination>" 1>&2
  exit 1
fi

target=$1
source_dir=$2

for i in $(grep -vE "^\s*#" ${target})
do
  echo ${i}
  if [ -L ${HOME}/${i} ]; then continue; fi
  if [ -f ${HOME}/${i} ]; then rm -f ${HOME}/${i}; fi
  mkdir -p ${HOME}/$(dirname ${i})
  ln -s ${source_dir}/${i} ${HOME}/${i}
done
