# vim:fdm=marker

# Prompt & highlighting {{{

  if [ $SSH_CONNECTION ]; then
    PROMPT='%n@%m %1~ %# '
  else
    PROMPT='%m %1~ %# '
  fi

  zle_highlight=( region:bg=0 )

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
    bindkey '^P' up-line-or-beginning-search
    bindkey '^N' down-line-or-beginning-search

  # }}}

  # Completion menu bindings {{{

    zmodload zsh/complist
    bindkey -M menuselect '^p' reverse-menu-complete
    bindkey -M menuselect '^n' menu-complete
    bindkey -M menuselect '^e' undo
    bindkey -M menuselect '^y' accept-line

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

  PATH="/opt/homebrew/bin:$PATH"
  PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
  PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
  PATH="$GOPATH/bin:$PATH"
  PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
  PATH="$HOME/.cargo/bin:$PATH"
  export PATH

  export VISUAL=nvim
  export EDITOR=nvim
  export REACT_EDITOR=none # don't open vim on development crash
  export IRCSERVER="fileputcontents.com:6697"

# }}}

# Aliases {{{

  source ~/.zsh/git-alias.zsh
  source ~/.zsh/projdir.zsh
  source ~/.zsh/terraform.zsh

  alias vi=nvim
  alias vim=nvim
  alias vimdiff="nvim -d"
  alias vh="sudo vi /etc/hosts"
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
  alias icat="kitty +kitten icat"
  alias beep="(afplay /System/Library/Sounds/Hero.aiff &)"

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

# }}}

# Functions {{{

  rnd_alnum() {
    LC_CTYPE=C tr -dc '[:alnum:]' < /dev/urandom | head -c${1:-32} | xargs echo
  }

  rnd_print() {
    LC_CTYPE=C tr -dc '[:print:]' < /dev/urandom | tr -d "'\"\\" | head -c${1:-32} | xargs -0 echo
  }

  csb() {
    clear && printf '\e[3J'
  }

  sys_clean() {
    rm -rf $(brew --cache)
    npm cache clean --force
    yarn cache clean
    docker system prune # -a # prune unused AND dangling
  }

  pj_task() {
    echo $(basename `git rev-parse --show-toplevel`) $(git branch --show-current)
  }

# }}}


# BEGIN_KITTY_SHELL_INTEGRATION
if test -e "/Applications/kitty.app/Contents/Resources/kitty/shell-integration/kitty.zsh"; then source "/Applications/kitty.app/Contents/Resources/kitty/shell-integration/kitty.zsh"; fi
# END_KITTY_SHELL_INTEGRATION

# pnpm
export PNPM_HOME="/Users/jason/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
