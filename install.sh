#!/bin/bash

set -u

BASEDIR=$(dirname $0)
DOTPATH=$PWD
cd $BASEDIR

echo $BASEDIR
echo $DOTPATH
for f in .??*; do
  [ "$f" = ".git" ] && continue
  [ "$f" = ".config" ] && continue
  ln -snfv $DOTPATH/"$f" ~/
done

ln -snfv $DOTPATH/.config/nvim ~/.config/

if [ "$(uname)" == 'Darwin' ]; then

elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  ln -snfv $DOTPATH/.config/dunst ~/.config/
  ln -snfv $DOTPATH/.config/i3 ~/.config/
  ln -snfv $DOTPATH/.config/picom ~/.config/
  ln -snfv $DOTPATH/.config/rofi ~/.config/
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi
