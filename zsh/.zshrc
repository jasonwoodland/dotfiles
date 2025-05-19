# vim:fdm=marker

# Prompt & highlighting {{{

  if [ $SSH_CONNECTION ]; then
    PROMPT='%n@%m %1~ %# '
  else
    PROMPT='%m %1~ %# '
  fi

  zle_highlight=( region:bg=0 )

# }}}

# Prompt integration (OSC 133) {{{

  # setopt PROMPT_SUBST

  PROMPT="%{$(printf '\033]133;A\007')%}$PROMPT"

  preexec() {
    # Command is starting
    printf "\033]133;B\007"
  }

  precmd() {
    printf "\033]133;C\007"
  }

# }}}

# Key bindings {{{

  # Vi & emacs bindings {{{

    # 10ms for key sequences
    KEYTIMEOUT=1

    # Get the bindings for emacs mode, then re run them when bound to vi-mode.
    bindkey -e
    bindings=`bindkey`
    bindkey -v
    while IFS= read -r binding; do
      eval "bindkey -v $binding"
    done <<< "$bindings"
    unset bindings binding

    # Use vi-backward-kill-word in insert mode since the default one doesnt
    # handle WORDCHARS properly
    bindkey "^W" vi-backward-kill-word

    # Clear wordchars so all symbols break words when ^W'ing
    WORDCHARS=

    # j and k to move up/down lines in normal mode
    bindkey -a "j" down-line
    bindkey -a "k" up-line

  # }}}

  # History bindings {{{

    # Up/down to match history
    autoload -Uz up-line-or-beginning-search
    autoload -Uz down-line-or-beginning-search
    zle -N up-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "^[[A" up-line-or-beginning-search
    bindkey "^[[B" down-line-or-beginning-search

  # }}}

  # Completion menu bindings {{{

    zmodload zsh/complist
    bindkey -M menuselect '^p' reverse-menu-complete
    bindkey -M menuselect '^n' menu-complete
    bindkey -M menuselect '^e' undo
    bindkey -M menuselect '^y' accept-line

  # }}}

  # screen-specific bindings {{{

    # Disable XON/XOFF flow control so we can use ^S and ^Q
    stty -ixon

  # }}}

# }}}

# Completion {{{

  # Docker completion
  fpath=(~/.zsh/completion $fpath)

  # Nice completion menu
  zstyle ':completion:*' menu select
  setopt menu_complete

  # Fuzzy completion
  zstyle ':completion:*' matcher-list '' \
    'm:{a-z\-}={A-Z\_}' \
    'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
    'r:|?=** m:{a-z\-}={A-Z\_}'

  # Don't complete functions starting with '_'
  zstyle ':completion:*:functions' ignored-patterns '_*' '*-beginning-search' '*-history'
  zstyle ':completion:*' ignored-patterns '_*'

  # Cache completion
  zstyle ':completion:*' use-cache yes
  zstyle ':completion:*' cache-path ~/.zsh/cache

  # Expand aliases
  zstyle ':completion:*' completer _expand_alias _complete _ignored

  autoload -Uz compinit && compinit

  # Add command to edit command in $EDITOR
  # Triggered using M-x ed <Cr>
  zle -N edit-command-line
  autoload -U edit-command-line

# }}}

# Options {{{

  # Auto chdir
  setopt auto_cd
  alias -- -="cd -"

  # History {{{

    HISTFILE=~/.zsh_history
    HISTFILESIZE=100000
    HISTSIZE=100000
    SAVEHIST=100000
    setopt append_history
    setopt inc_append_history
    setopt share_history
    setopt hist_ignore_space
    setopt hist_find_no_dups
    setopt hist_expire_dups_first
    setopt extended_history

  # }}}

  # Watch background jobs and notify immediately
  setopt notify

  # Check jobs before exiting shell
  setopt checkjobs

  # Case-insensitive globbing
  setopt no_case_glob
  unsetopt beep

# }}}

# Environment variables {{{

  export GOPATH="$HOME/.go"
  export GPG_TTY=$(tty)

  PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
  PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
  PATH="$GOPATH/bin:$PATH"
  PATH="$HOME/.cargo/bin:$PATH"
  PATH="$HOME/.bin:$PATH"
  PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
  PATH="$PATH:/Users/jason/ghq/github.com/migaku-official/migaku-scripts/bin"
  export PATH

  export VISUAL=nvim
  export EDITOR=nvim
  export REACT_EDITOR=none # don't open vim on development crash
  export IRCSERVER="fileputcontents.com:6697"
  export PAGER="less -FKX"

  export LESS="-IRsj12 --mouse"

  # export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/configs/vke-38bc9674-7581-4770-b591-b7568b680c8b.yaml"

  export HOMEBREW_AUTO_UPDATE_SECS=86400 # 1 day

# }}}

# Aliases {{{

  source ~/.zsh/git-alias.zsh
  source ~/.zsh/kubectl-alias.zsh
  source ~/.zsh/projdir.zsh
  source ~/.zsh/terraform.zsh

  alias vi=nvim
  alias vim=nvim
  alias vimdiff="nvim -d"
  alias vh="sudo vi /etc/hosts"
  alias k='kubectl $kargs'
  alias l='linode-cli'
  alias so="source ~/.zshrc"
  alias pg="psql -U postgres"
  alias port="sudo port"
  alias rg="rg -i \
    --colors match:fg:13 \
    --colors line:none \
    --colors column:none \
    --colors path:none \
    --colors path:style:bold"
  alias t="track"
  alias ls="ls --hyperlink=auto"
  alias beep="(afplay /System/Library/Sounds/Submarine.aiff &)"
  alias cl="clockify-cli"
  alias pc="proxychains4"

# }}}

# Programs & Plugins {{{

  # neovim-remote {{{

    if [[ -v NVIM_LISTEN_ADDRESS ]]; then
      alias nvim=nvr
    fi

  # }}}

  # zsh-system-clipboard {{{

    source ~/.zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh

  # }}}

  # fzf {{{

    source ~/.zsh/fzf.zsh
    export FZF_DEFAULT_OPTS='
      --no-bold
      --color=fg:-1,bg:-1,hl:11
      --color=fg+:-1,bg+:8,hl+:11
      --color=info:-1,prompt:12,pointer:-1,input:regular
      --color=marker:-1,spinner:-1,header:-1,gutter:-1
    '

  # }}}

  # clockify-cli {{{

    # source ~/.zsh/clockify-cli-completion.zsh
    # CL_WORKSPACE=64ab5cdc067d213321e3000c

  # }}}

# }}}

# Functions {{{

  function rnd_alnum() {
    LC_CTYPE=C tr -dc '[:alnum:]' < /dev/urandom | head -c${1:-32} | xargs echo
  }

  function rnd_print() {
    LC_CTYPE=C tr -dc '[:print:]' < /dev/urandom | tr -d "'\"\\" | head -c${1:-32} | xargs -0 echo
  }

  function sys_clean() {
    rm -rf $(brew --cache)
    npm cache clean --force
    yarn cache clean
    docker system prune # -a # prune unused AND dangling
  }

  # pj_task() {
  #   echo $(basename `git rev-parse --show-toplevel`) $(git branch --show-current)
  # }

  function lc() {
    for pattern in "$@"; do
      for file in $pattern; do
        if [[ -f "$file" ]]; then
          echo "$file:"
          echo '```'
          cat "$file"
          echo '```'
          echo
        fi
      done
    done
  }

# }}}


# pnpm
export PNPM_HOME="/Users/jason/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
# [ -s "/Users/jason/.bun/_bun" ] && source "/Users/jason/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# . "/Users/jason/.deno/env"

# gcloud completion
source /opt/homebrew/share/google-cloud-sdk/completion.zsh.inc


export CFLAGS="-I/opt/homebrew/include"
export LDFLAGS="-L/opt/homebrew/lib"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# fnm
# FNM_PATH="/Users/jason/Library/Application Support/fnm"
# if [ -d "$FNM_PATH" ]; then
#   export PATH="/Users/jason/Library/Application Support/fnm:$PATH"
#   eval "`fnm env`"
# fi

# eval "$(fnm env --use-on-cd --shell zsh)" > /dev/null

