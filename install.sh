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

    if [[ $folder == skills ]]; then
        # Unfold installations made before the personal skills directory existed.
        if [[ -L $HOME/.agents && $HOME/.agents -ef "$DOTFILES/skills/.agents" ]]; then
            stow -D -t "$HOME" "${STOW_IGNORE_ARGS[@]}" "$folder"
        fi

        skills_target="$HOME/.agents/skills/me"
        mkdir -p "${skills_target%/*}"
        if [[ -e $skills_target && ! -L $skills_target ]]; then
            if ! rmdir "$skills_target"; then
                printf '%s\n' "Cannot replace non-empty $skills_target" >&2
                exit 1
            fi
        fi

        ln -sfn "$DOTFILES/skills" "$skills_target"
        continue
    fi

    echo "stow $folder"
    stow -t "$HOME" "${STOW_IGNORE_ARGS[@]}" "$folder"
done
popd > /dev/null
