#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cl='clear'
alias rofi-emoji='rofimoji'
alias ex=exit

PS1='[\u@\h \W]\$ '

#PS1='~ \$ '
. "$HOME/.cargo/env"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"



# Habilitar el autocompletado
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

