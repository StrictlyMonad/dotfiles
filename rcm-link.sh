#!/usr/bin/env bash


export THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export DOTFILES_DIR="$(readlink -f $THIS_DIR/dotfiles)"

echo $DOTFILES_DIR
rcup -d $DOTFILES_DIR -S "emacs.d" -S "config/taffybar" -S "config/xmonad" -S "config/xmonad/taffybar"
