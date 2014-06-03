#!/bin/bash
#
# updates to the next version and adds the changes to the index

# get the current version from the branch name
branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
branch_name="(unnamed branch)"     # detached HEAD
branch_name=${branch_name##refs/heads/}
version=${branch_name##release-}
longversion=`sed -e 's/^\([0-9]*\)\.\?\([0-9]*\)\?\.\?\([0-9]*\)\?\([a-z]*[0-9]*\)\?$/\1.\2.\3\4/' -e 's/^\./0./' -e 's/\.\([^0-9]\)/.0\1/g' -e 's/\.\([^0-9]\)/.0\1/g' -e 's/\.$/.0/' <<< $version`
libversion=`sed -e 's/[^0-9.].*//' -e 's/\./:/g' <<< $longversion`

echo "updating to version $version ($longversion | $libversion)"

if ! grep '[0-9]\+:[0-9]\+:[0-9]\+' &>/dev/null <<< $libversion; then
    echo "error: libversion has wrong format" >&2
    exit 1
fi

# update the version information header entry
sed -i -e "/const char version\[\]/ s/\"[^\"]\+\"/\"$version\"/" include/config.hpp

# update autoconf information
sed -i -e "/AC_INIT(/ s/\[[^]]*\]/[$version]/2" configure.ac

# update libversion
sed -i -e "s/\(-version-info\)\s\+[0-9:]*/\1 $libversion/" Makefile.am

# confirm the changes
required="include/config.hpp configure.ac Makefile.am"
for file in $required; do
    if ! git ls-files -m 2>/dev/null | grep $file &>/dev/null; then
        echo "warning: file was not modified: $file" >&2
    fi
done

changed="$required"

git add $changed

git rm --cached $0

echo "done"

rm $0
