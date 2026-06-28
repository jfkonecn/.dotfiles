#!/usr/bin/env bash

if [[ -z ${DOTFILES:-} ]]; then
    DOTFILES=$HOME/.dotfiles
fi

STOW_FOLDER_EXCEPTIONS=${STOW_FOLDER_EXCEPTIONS:-.git,.steam}

is_exception() {
    local folder=$1
    case ",$STOW_FOLDER_EXCEPTIONS," in
        *",$folder,"*) return 0 ;;
        *) return 1 ;;
    esac
}

stow_ignore_args() {
    echo "$STOW_FOLDER_EXCEPTIONS" | tr ',' '\n' | while IFS= read -r folder
    do
        if [[ -n $folder ]]; then
            printf -- '--ignore=(^|/)%s($|/)\n' "$(printf '%s' "$folder" | sed 's/[][\\.^$*+?(){}|]/\\&/g')"
        fi
    done
}

mapfile -t STOW_IGNORE_ARGS < <(stow_ignore_args)

pushd "$DOTFILES" > /dev/null
if [[ -z ${STOW_FOLDERS:-} ]]; then
    STOW_FOLDERS=$(find . -mindepth 1 -maxdepth 1 -type d -printf '%f\n')
fi

echo "$STOW_FOLDERS" | tr ',' '\n' | while IFS= read -r folder
do
    if [[ -z $folder ]] || is_exception "$folder"; then
        continue
    fi

    echo "stow $folder"
    stow "${STOW_IGNORE_ARGS[@]}" "$folder"
done
popd > /dev/null
