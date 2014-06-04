#!/bin/bash
#
# updates to the next version and adds the changes to the index

oldname=CHANGETHIS
if [ $1 ]; then
  name="$1"
else
  defaultname=`basename $PWD`
  read -e -p "what's the name? [$defaultname] " name; [ $name ] || name="$defaultname"
  unset defaultname
fi

echo "setting name to $name"
echo "Note that this is a one-time operation and cannot be repeated"

sed -i -e "s/$oldname/$newname/g" *

