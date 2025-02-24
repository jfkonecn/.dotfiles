#!/usr/bin/env bash

chsh -s $(which zsh)

if [[ -z $STOW_FOLDERS ]]; then
    STOW_FOLDERS="git,nvim,tmux,zsh,bin,i3,ghostty,yabai"
fi

if [[ -z $DOTFILES ]]; then
    DOTFILES=$HOME/.dotfiles
fi

STOW_FOLDERS=$STOW_FOLDERS DOTFILES=$DOTFILES $DOTFILES/install.sh
