# vim:fdm=marker

# Prompt {{{
  if [ $SSH_CONNECTION ]; then
    PROMPT='%n@%m %1~ %# '
  else
    PROMPT='%m %1~ %# '
  fi

# }}}

# Key bindings {{{

  # Vi & emacs bindings {{{

    # 10ms for key sequences
    KEYTIMEOUT=1

    # Get the bindings for emacs mode, then re run them when bound to vi-mode. Clever, eh?
    bindkey -e
    bindings=`bindkey` 
    bindkey -v
    while IFS= read -r binding; do
      eval "bindkey -v $binding"
    done <<< "$bindings"
    unset bindings binding

    # Change cursor shape for different vi modes
    source ~/.zsh/vi-mode.zsh

  # }}}

  # History key binds {{{

    # Up/down to match history
    autoload -Uz up-line-or-beginning-search
    autoload -Uz down-line-or-beginning-search
    zle -N up-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "^[[A" up-line-or-beginning-search
    bindkey "^[[B" down-line-or-beginning-search
    bindkey '^P' up-history
    bindkey '^N' down-history

  # }}}

# }}}

# Completion {{{

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

    HISTFILE=~/.histfile
    HISTFILESIZE=100000
    HISTSIZE=100000
    SAVEHIST=100000
    setopt append_history
    setopt inc_append_history
    setopt share_history
    setopt hist_find_no_dups
    setopt hist_ignore_dups
    setopt hist_ignore_space

  # }}}

  # Watch background jobs and notify immediately
  setopt notify

  # Check jobs before exiting shell
  setopt checkjobs

  # Case-insensitive globbing
  setopt no_case_glob
  unsetopt beep

# }}}

# Window title {{{

  # Use CWD as terminal title
  _update_terminal_title() {
    echo -ne "\033]0;${PWD##*/}\007"
  }
  autoload -U add-zsh-hook
  add-zsh-hook precmd _update_terminal_title

# }}}

# Environment variables {{{

  source ~/.acme.sh/acme.sh.env

  export GOPATH="$HOME/.go"

  PATH="/opt/homebrew/bin:$PATH"
  PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
  PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
  PATH="/usr/local/bin:$PATH"
  PATH="$GOPATH/bin:$PATH"
  export PATH

  export VISUAL=nvim
  export EDITOR=nvim
  export REACT_EDITOR=none # don't open vim on development crash

  # Add local completion (docker, it's already added to fpath)
  # fpath=(~/.zsh/completion $fpath)

  export FZF_DEFAULT_OPTS='
    --color=fg:-1,bg:-1,hl:-1
    --color=fg+:regular:-1,bg+:#2d323b,hl+:-1
    --color=info:-1,prompt:-1,pointer:-1
    --color=marker:-1,spinner:-1,header:-1,gutter:-1
  '

# }}}

# Aliases {{{

  source ~/.zsh/git-alias.zsh
  source ~/.zsh/tmux-alias.zsh

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

  alias sum="awk '{s+=\$1} END {print s}'"
  alias beep="(afplay /System/Library/Sounds/Hero.aiff &)"

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

  sysclean() {
    rm -rf $(brew --cache)
    npm cache clean --force
    yarn cache clean
    docker system prune # -a # prune unused AND dangling
  }

  # irc {{{

    irc() {
      if [[ -v TMUX ]]; then
        tmux switch-client -t irc 2>/dev/null
        if [[ $? -eq 0 ]]; then
          return
        fi
      fi

      tmux attach -t irc 2>/dev/null
      if [[ $? -eq 0 ]]; then
        return
      fi

      tmux new-session -s irc -d 'weechat' \; set status off 2>/dev/null
      if [[ $? -eq 0 ]]; then
        if [[ -v TMUX ]]; then
          tmux switch-client -t irc 2>/dev/null
        else
          tmux attach -t irc
        fi
      else
        tmux new -s irc -A 'weechat' \; set status off
      fi
    }

  # }}}

  # nvim-session {{{

    nvim-session() {
      if [[ $# -eq 1 ]]; then
        selected=$1
      else
        items=(
          ~/ispec/*/
          ~/ispec/*/go/
          ~/ispec/*/*/apps/*/
          ~/projects/*/
          ~/projects/cone/
          ~/projects/cone/*/
          ~/.dotfiles/
          ~/.dotfiles/*/
        )

        selected=`printf "%s\n" "${items[@]}" | sort | fzf`

        if [[ $selected == '' ]]; then
          return
        fi
      fi

      pushd $selected >/dev/null
      # if [[ -f Session.vim ]]; then
      #   nvim -S
      # else
      nvim -c ":pwd"
      # fi
      popd >/dev/null
    }
    alias v=nvim-session

  # }}}

# }}}
