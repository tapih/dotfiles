#! /bin/sh

for i in $(grep -vE "^\s*#" Gofile | tr "\n" " ")
do
  go install ${i}
done

