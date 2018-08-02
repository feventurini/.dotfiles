# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# use miniconda2 as main python package manager
export PATH="$HOME/lib/miniconda2/bin:$PATH"

# ~/dev folder where are the projects are, adding to the pythonpath for "import project"
# without manually adding the folder in the code/command line
export PYTHONPATH="$HOME/dev/:$PYTHONPATH"

# luigi client config
export LUIGI_CONFIG_PATH="$HOME/.luigiconf"

export DEFAULT_USER=`whoami`
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
# export MANPATH="/usr/local/man:$MANPATH"

export TERM='xterm-256color'
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='rmate'
else
  export EDITOR='code'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

ZSH_THEME="spaceship"
COMPLETION_WAITING_DOTS=false

plugins=(git mercurial osx web-search zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Shortcut for mounting the dev box unless mounted, also called at login
# needs the proper alias/proxy command configured in ~/.ssh/config
# change names of folder/remote server as needed
export DEVBOX_VOLUME_PATH="$HOME/Devbox"
export DEVBOX_SSH_ALIAS="fededev"

mountdevbox() {
  { # try
  if mount | grep "on $DEVBOX_VOLUME_PATH" > /dev/null; then
    :
  else
    mkdir -p $DEVBOX_VOLUME_PATH
    volname=${DEVBOX_VOLUME_PATH##*/}
    sshfs $DEVBOX_SSH_ALIAS: -o volname=$volname $DEVBOX_VOLUME_PATH
  fi
  } || {
  # catch
  echo "Unable to mount remote file system $DEVBOX_SSH_ALIAS"
  }
}

# call at login
mountdevbox

# Fix some cosmetic issues with spaceship and mercurial
export VIRTUAL_ENV_DISABLE_PROMPT=true
# better autosuggest
export ZSH_AUTOSUGGEST_STRATEGY='match_prev_cmd'
bindkey '^ ' autosuggest-accept
# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'


# https://github.com/arzzen/calc.plugin.zsh/blob/master/calc.plugin.zsh
autoload -U zcalc
function __calc_plugin {
    zcalc -e "$*"
}
alias calc='noglob __calc_plugin'
aliases[=]='noglob __calc_plugin'

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi