#!/usr/bin/env bash

set -euo pipefail

DOTFILES=${DOTFILES:-"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"}
BINDINGS="$HOME/.config/hypr/bindings.lua"
BACKUP=

if [[ -z ${STOW_FOLDERS:-} ]]; then
    STOW_FOLDERS="git,nvim,tmux,zsh,bin,ghostty,codex,opencode,skills,omarchy"
fi

if [[ -e $BINDINGS && ! -L $BINDINGS ]]; then
    BACKUP="$BINDINGS.backup.$(date +%Y%m%d%H%M%S)"
    mv "$BINDINGS" "$BACKUP"
fi

if ! STOW_FOLDERS="$STOW_FOLDERS" DOTFILES="$DOTFILES" "$DOTFILES/install.sh"; then
    if [[ -n $BACKUP ]]; then
        mv "$BACKUP" "$BINDINGS"
    fi
    exit 1
fi

hyprctl reload
hyprctl configerrors
