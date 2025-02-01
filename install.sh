#!/bin/bash

set -u

DOTPATH=$(cd "$(dirname "$0")" && pwd)
cd "$DOTPATH"

link_dotfiles() {
  for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".config" ] && continue
    [ "$f" = ".Xresources" ] && continue
    ln -snfv $DOTPATH/"$f" ~/
  done

  if [ "$(uname)" = "Linux" ]; then
    ln -snfv "$DOTFILES_DIR/.Xresources" ~/
  fi
}

link_config_files() {

  echo "Apply common config"
  ln -snfv $DOTPATH/.config/nvim ~/.config/

  case "$(uname)" in
  Darwin)
    echo "Apply config for macOS"
    ;;
  Linux)
    echo "Apply config for Linux"
    ln -snfv "$DOTPATH/.config/dunst" ~/.config/
    ln -snfv "$DOTPATH/.config/i3" ~/.config/
    ln -snfv "$DOTPATH/.config/picom" ~/.config/
    ln -snfv "$DOTPATH/.config/rofi" ~/.config/
    ;;
  *)
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
    ;;
  esac
}

link_dotfiles
link_config_files
