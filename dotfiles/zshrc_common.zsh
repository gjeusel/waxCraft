# Used by aliases
export waxCraft_PATH=${0:A:h:h}
source "$waxCraft_PATH/dotfiles/envvar.sh"
source "$waxCraft_PATH/dotfiles/fzf-extras.zsh"

if [ ! -e "$HOME/.config/antigen.zsh" ]; then
  curl -L git.io/antigen -o "$HOME/.config/antigen.zsh"
fi
source "$HOME/.config/antigen.zsh"

# Some options settings:
setopt inc_append_history share_history hist_ignore_all_dups  # history
setopt autocd extendedglob notify nomatch autopushd pushdignoredups promptsubst

autoload -Uz compinit

# Plugins
antigen use oh-my-zsh
antigen bundle git
antigen bundle extract  # generic cmd to decompress files
antigen bundle colored-man-pages
antigen bundle common-aliases
antigen bundle tmux
antigen bundle z
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Docker related
antigen bundle docker
antigen bundle akarzim/zsh-docker-aliases
antigen bundle docker-compose
antigen bundle helm

antigen bundle terraform
antigen bundle gcloud
antigen bundle kubectl
#antigen bundle dbz/kube-aliases


# Golang:
#antigen bundle golang

## Theme Pure:
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
# for 'pure' on remote, user must be part of tty group to get access to zsh-async correctly

# Tell Antigen that you're done.
antigen apply

# AUTO COMPLETION
# Ignore these everywhere except for rm
zstyle ':completion:*:*:*' ignored-patterns '(|*/)__pycache__' \
    '(|*/)*.egg-info' '(*/)#lost+found'
zstyle ':completion:*:rm:*' ignored-patterns '(|*/)*.egg-info'

# Bind ctrl + space
bindkey '^ ' autosuggest-accept

# Auto install tpm (tmux plugin)
#export TERM="tmux-256color"
[ -n "$TMUX" ] && export TERM=screen-256color
if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi


#### ZSH STARTUP OPTIM

# Set up Node Version Manager
nvm() {
  # On first use, it will set nvm up properly which will replace the `nvm`
  # shell function with the real one
  if [ -f "/usr/share/nvm/init-nvm.sh" ]; then
    source /usr/share/nvm/init-nvm.sh
    # See https://github.com/robbyrussell/oh-my-zsh/issues/6163
    if [ -d $HOME/.nvm ]; then
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    fi
    nvm "$@"
  else:
    echo "nvm is not installed" >&2
    return 1
  fi
}

# RVM ( Ruby Versin Manager )
rmv() {
  if [ -f "$HOME/.rvm/scripts/rvm" ]; then
    source /Users/jd5584/.rvm/scripts/rvm
    rvm "$@"
  else:
    echo "rvm is not installed" >&2
    return 1
  fi
}

# https://github.com/zsh-users/antigen/issues/583
source $HOME/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/kubectl/kubectl.plugin.zsh

# Only add in zsh history commnds that did not failed
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }
