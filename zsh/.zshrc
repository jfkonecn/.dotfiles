# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#export GCM_CREDENTIAL_STORE="plaintext"

# source ~/.zshrc
export PATH="$HOME/idea-IC-223.8836.41/bin:$PATH"
export PATH="$HOME/.tmux/plugins/tmuxifier/bin:$PATH"
export EDITOR="/usr/bin/nvim"
# https://coderwall.com/p/pb1uzq/z-shell-colors
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'


if [[ $(uname) == "Linux" ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
if [[ $(uname) == "Darwin" ]]; then
    export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi

. "$HOME/.cargo/env"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


export PATH="$PATH:$HOME/bin"


if [[ $(uname) == "Darwin" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
    export JAVA_HOME=/opt/homebrew/opt/openjdk
    #alias j8="export JAVA_HOME=/usr/local/opt/openjdk@8 ; java -version"
    alias j8="export JAVA_HOME=$HOME/Library/Java/JavaVirtualMachines/temurin-1.8.0_402/Contents/Home
 ; java -version"
    #alias j11="export JAVA_HOME=/usr/local/opt/openjdk@11 ; java -version"
    alias j11="export JAVA_HOME=$HOME/Library/Java/JavaVirtualMachines/temurin-11.0.22/Contents/Home
 ; java -version"
    alias j17="export JAVA_HOME=$HOME/Library/Java/JavaVirtualMachines/temurin-17.0.12/Contents/Home
 ; java -version"
    #alias j17="export JAVA_HOME=/usr/local/opt/openjdk@17 ; java -version"
    #alias j20="export JAVA_HOME=/usr/local/opt/openjdk@20 ; java -version"
    alias j21="export JAVA_HOME=$HOME/Library/Java/JavaVirtualMachines/temurin-21.0.7/Contents/Home ; java -version"
    alias j22="export JAVA_HOME=$HOME/Library/Java/JavaVirtualMachines/temurin-22/Contents/Home ; java -version"
fi
if [[ $(uname) == "Linux" ]]; then
    export JAVA_HOME=/usr/lib/jvm/default-java
    alias j8="export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 ; java -version"
    alias j11="export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 ; java -version"
    alias j17="export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64 ; java -version"
    alias j20="export JAVA_HOME=/usr/lib/jvm/java-20-openjdk-amd64 ; java -version"
    export GCM_CREDENTIAL_STORE="secretservice"
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
    alias say='espeak'
fi

alias start-tmux="~/.local/scripts/tmux-sessionizer.sh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias ai='ollama run llama3'

alias format-json='jq '.' --color-output'
alias search-json='jq '.' --color-output | less -NFIRX'
alias find-string-json="$HOME/.local/scripts/find-string-json.sh $1"


# roc programming language
export PATH=$PATH:$HOME/roc

# zig programming language
export PATH=$PATH:$HOME/zig

# zig go binaries
export PATH=$PATH:$HOME/go/bin

export PATH=$PATH:$HOME/oss/ghostty/zig-out/bin


# Set up fzf key bindings and fuzzy completion
# Do COMMAND [DIRECTORY/][FUZZY_PATTERN]**<TAB>
# Need v0.48 or better
#

if [[ $(uname) == "Darwin" ]]; then
    eval "$(fzf --zsh)"
fi

alias gcfzf='git checkout $(git branch | fzf)'

[[ ! -f "$HOME/extends.sh" ]] || source "$HOME/extends.sh"
