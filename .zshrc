# zsh-completions
fpath=(/opt/homebrew/share/zsh-completions $fpath)
# zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
## dark mode
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
# zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# nodebrew path
export PATH=$HOME/.nodebrew/current/bin:$PATH

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

# vim
KEYTIMEOUT=1

autoload -U compinit
compinit -u
