# Set Spaceship as a prompt
autoload -U promptinit; promptinit
prompt spaceship
SPACESHIP_USER_SHOW="false"
SPACESHIP_VI_MODE_SHOW="false"

# Save history so we get auto suggestions
HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTFILE=$HOME/.zsh_history

# Enable autocompletions
autoload -U compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zmodload -i zsh/complist
compinit

# Options
setopt auto_cd              # cd by typing directory name if it's not a command
setopt auto_list            # automatically list choices on ambiguous completion
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks   # remove superfluous blanks from history items
setopt inc_append_history   # save history entries as soon as they are entered
setopt share_history        # share history between different instances
setopt correct_all          # autocorrect commands
unsetopt BEEP               # no beep sounds
bindkey -e                  # emacs keybinds

# basic exports
export EDITOR="nvim"
export VISUAL="$EDITOR"
export CLICOLOR=1

# Aliases
alias g++="g++ -std=c++17 -Wall"
alias rm="rm -i"
alias r="ranger"
alias lzg="lazygit"
alias lzd="lazydocker"
alias ipy="ipython"
alias t='tmux attach || tmux new -s BASE'

# Put Homebrew's sbin in path
export PATH="/usr/local/sbin:$PATH"


# -------------------------==> FZF settings <== ------------------------------#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=75%
--multi
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || 
  ([[ -d {} ]] && (tree -C {} | less)) || echo {} 3> /dev/null | head -200'
"
export FZF_DEFAULT_COMMAND="fd --hidden --exclude '.git' --exclude 'node_modules'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# ----------------------------------------------------------------------------#


# -------------------------==> nvm settings <== ------------------------------#
export NVM_DIR="$HOME/.nvm"
alias loadnvm='[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"'
[[ -r $NVM_DIR/bash_completion ]] && \. $NVM_DIR/bash_completion
# ----------------------------------------------------------------------------#


# -----------------------==> conda initialize <== ----------------------------#
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
# ----------------------------------------------------------------------------#


# -----------------------==> pyenv initialize <== ----------------------------#
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init - --no-rehash)"
fi

export PIPENV_VENV_IN_PROJECT=1
export PYENV_ROOT=$HOME/.pyenv
export PATH="$PYENV_ROOT/shims:$PATH"
# ----------------------------------------------------------------------------#


# ZSH Packages
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
