# Path to your oh-my-zsh installation.
export ZSH="/Users/proton/.oh-my-zsh"

# Set name of the zsh theme.
ZSH_THEME="spaceship"
SPACESHIP_BATTERY_SHOW="false"
SPACESHIP_USER_SHOW="false"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export EDITOR="code --wait"

export LESS="-F -X $LESS"

# Aliases
alias gst="git status"
alias glog="git log --oneline"
alias rm="rm -i"
alias diff="diff -u"

# Put Homebrew's sbin in path
export PATH="/usr/local/sbin:$PATH"

# Add pyenv executable directory to PATH
export PATH="$PYENV_ROOT/bin:$PATH"

# Initialize pyenv if it exists
if command -v pyenv 1>/dev/null 2>&1
then
  eval "$(pyenv init -)"
fi

# Creates a virtual env in the project
export PIPENV_VENV_IN_PROJECT=1

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"




source "/Users/proton/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
