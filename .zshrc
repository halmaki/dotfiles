# -----------------------------------
# PATH設定
# -----------------------------------
typeset -U path PATH
path=(
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /Library/Apple/usr/bin
  ~/bin
)
eval "$(/opt/homebrew/bin/mise activate zsh)" # mise

# -----------------------------------
# Zshプラグイン設定
# -----------------------------------
## zplug
source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "mafredri/zsh-async"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"

# local plugins
zplug "~/.zsh", from:local
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

## fzf
source <(fzf --zsh)
if [[ -n "$TMUX" ]]; then
  export FZF_DEFAULT_OPTS="--style full --preview 'fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}' --tmux 80%"

else
  export FZF_DEFAULT_OPTS="--style full --preview 'fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}'"
fi

# -----------------------------------
# エイリアス設定
# -----------------------------------
alias ll='ls -alG'
alias cp="${ZSH_VERSION:+nocorrect} cp -i"
alias mv="${ZSH_VERSION:+nocorrect} mv -i"
alias mkdir="${ZSH_VERSION:+nocorrect} mkdir"
alias du='du -h'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias gm='gomi' # b4b4r07/gomi

# -----------------------------------
# setopt
# -----------------------------------
setopt auto_pushd
setopt share_history
setopt hist_reduce_blanks
setopt hist_ignore_all_dups

# -----------------------------------
# その他の設定
# -----------------------------------
KEYTIMEOUT=1  # vim

autoload -U compinit
compinit -u