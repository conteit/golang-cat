#!/usr/bin/env bash

if [[ $(git diff --stat) != '' ]]; then
  echo "Working Dir is dirty. Commit changes, stash or revert, then retry!"
  exit 1
fi

v=$1
if [[ "$v" == "" ]]; then
    latesttag=$(git describe --tags)
    patch=$(echo $latesttag | cut -d . -f 3 | cut -d- -f 1)
    v="$(echo $latesttag | cut -d . -f 1,2).$(($patch + 1))"
    echo "Going to build version: $v"
    git tag "$v"
fi

VERSION="$v" make