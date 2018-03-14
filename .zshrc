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

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='code'
else
  export EDITOR='rmate'
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

# wth!? I'll leave it
TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}

# Fix some cosmetic issues with spaceship and mercurial
export VIRTUAL_ENV_DISABLE_PROMPT=true

# better autosuggest
export ZSH_AUTOSUGGEST_STRATEGY='match_prev_cmd'

# Can't remember why these are here, I think I messed up CTRL+L for clearing once
bindkey '^ ' autosuggest-accept
bindkey '^l' clear-screen

# Wrapper for source activate, works with conda. I don't want to type "source"
activate() { source activate "$1"; }
deactivate() { source deactivate "$1"; }

# aliases I like
# rapid edit of zsh config files
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
# rsync source target, .py files only
alias rsync_pyonly='rsync -zarv --include="*/" --include="*.py" --exclude="*"'
# config files
alias sshconfig="code ~/.ssh/config"

alias synctodev="rsync_pyonly ~/dev/telecticcrawler fededev:~/dev/"
alias syncfromdev="rsync_pyonly fededev:~/dev/telecticcrawler ~/dev/ "

# C client for mercurial, marginally faster
alias hg=chg

# MAKE SURE I DONT FUCK UP
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# CANT BE BOTHERED TO TYPE THE VOWELS
alias clr='clear'

# FOR ALIAS TO BE SUDO-ed
alias sudo='sudo '

# Download file with original filename
alias get="curl -O -L"

# Faster cd to common 
alias dl='cd ~/Downloads'
alias dt='cd ~/Desktop'

# macOS specific commands, comment if linux
alias showHiddenFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideHiddenFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
