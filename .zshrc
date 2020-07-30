# --------------------------------------------------------------------------- #
# ------------------------------ Oh My Zsh ---------------------------------- #
# --------------------------------------------------------------------------- #


# Path to your oh-my-zsh installation.
export ZSH="/Users/proton/.oh-my-zsh"

ZSH_THEME="spaceship"
SPACESHIP_BATTERY_SHOW="false"
SPACESHIP_USER_SHOW="false"
SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  package       # Package version
  node          # Node.js section
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  conda         # conda virtualenv section
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  char          # Prompt character
)
source "/Users/proton/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

# disable marking untracked files under VCS as dirty
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git docker)

source $ZSH/oh-my-zsh.sh

export EDITOR="nvim"
export VISUAL="$EDITOR"
export TERM="xterm-256color"

unsetopt BEEP

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Aliases
alias diff="diff -u"
alias g++="g++ -std=c++17"
alias rm="rm -i"
alias r="ranger"

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

# Haskell Compiler Setup
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/proton/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/proton/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/proton/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/proton/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# FZF settings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=75%
--multi
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--border
"
export FZF_DEFAULT_COMMAND="fd --hidden --exclude '.git' --exclude 'node_modules'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

