#!/usr/bin/env zsh

case "${OSTYPE}" in
  darwin*)
    /usr/bin/pmset -g ps | awk '{ if(NR==2) print $2}' | sed "s/;//g"
    ;;
  *)
    echo "-"
    ;;
esac
