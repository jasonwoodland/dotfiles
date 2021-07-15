# Prompt

# # Load version control information
# autoload -Uz vcs_info
# precmd() { vcs_info }

# # Format the vcs_info_msg_0_ variable
# zstyle ':vcs_info:git*' formats " %b"

# # Set up the prompt (with git branch name)
# setopt PROMPT_SUBST
# if [ $SSH_CONNECTION ]; then
#   PROMPT='%n@%m:%1~ ${vcs_info_msg_0_} %# '
# else
#   PROMPT='%m:%1~ ${vcs_info_msg_0_} %# '
# fi

if [ $SSH_CONNECTION ]; then
  PROMPT='%n@%m %1~ %# '
else
  PROMPT='%m %1~ %# '
fi

# Vi-bindings
bindkey -v
KEYTIMEOUT=1

# Up/down to match history
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey '^P' up-history
bindkey '^N' down-history

# backspace and ^H working even after
# returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

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

# Auto chdir
setopt auto_cd
alias -- -="cd -"

# History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt inc_append_history
setopt share_history
setopt histfindnodups
setopt histignoredups
setopt hist_ignore_space

# Watch background jobs and notify immediately
setopt notify

# Check jobs before exiting shell
setopt checkjobs

# Case-insensitive globbing
setopt no_case_glob
unsetopt beep

# Use CWD as terminal title
_update_terminal_title() {
  echo -ne "\033]0;${PWD##*/}\007"
}
autoload -U add-zsh-hook
add-zsh-hook precmd _update_terminal_title

# Add command to edit command in $EDITOR
zle -N edit-command-line
autoload -U edit-command-line

# export PGHOST=localhost
# export PGPORT=5432
# export PGDATABASE=postgres
# export PGUSER=postgres

export GOPATH="$HOME/.go"

PATH="/opt/homebrew/bin:$PATH"
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="$GOPATH/bin:$PATH"
export PATH

source ~/.aliases.vultr

# export TERM=xterm-256color-italic
export VISUAL=nvim
export EDITOR=nvim
export REACT_EDITOR=none # don't open vim on development crash

alias vi=nvim
alias vim=nvim
alias vimdiff="nvim -d"
alias vh="sudo vi /etc/hosts"
alias pg="psql -U postgres"
alias irc="tmux attach -t irc || tmux new -s irc 'TERM=screen-256color-italic weechat' \; set status off"
alias port="sudo port"
alias rg="rg -i \
  --colors match:fg:13 \
  --colors line:none \
  --colors column:none \
  --colors path:none \
  --colors path:style:bold"
alias t="track"


rnd_alnum() {
  LC_CTYPE=C tr -dc '[:alnum:]' < /dev/urandom | head -c${1:-32} | xargs echo
}

rnd_print() {
  LC_CTYPE=C tr -dc '[:print:]' < /dev/urandom | tr -d "'\"\\" | head -c${1:-32} | xargs -0 echo
}

# logged() {
#   awk -F"[\037:]" '{
#     h+=$6
#     m+=$7
#   }
#   END { print h+(m/60) " hours" }' .tc
# }

# # Add homebrew to fpath (it seems to already be added to fpath???)
# if type brew &>/dev/null; then
#   fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
# fi

# Add local completion (docker, it's already added to fpath)
fpath=(~/.zsh/completion $fpath)

for i in ~/.zsh/*.zsh; do
  source $i
done

. ~/.acme.sh/acme.sh.env

autoload -Uz compinit && compinit

tmux-session() {
  if [[ $# -eq 1 ]]; then
    selected=$1
  else
    items=`find ~/ispec -maxdepth 1 -mindepth 1 -type d`"\n"
    items+=`find ~/Projects -maxdepth 1 -mindepth 1 -type d`
    selected=`echo "$items" | fzf`
  fi

  dirname=`basename $selected`

  tmux switch-client -t $dirname > /dev/null 2>&1
  tmux attach -t $dirname > /dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    return
  fi

  tmux new-session -c $selected -d -s $dirname && tmux switch-client -t $dirname || tmux new -c $selected -A -s $dirname
}
alias ts=tmux-session

nvim-session() {
  if [[ $# -eq 1 ]]; then
    selected=$1
  else
    items=(
      ~/ispec/*/
      ~/ispec/*/go/
      ~/ispec/*/*/apps/*/
      ~/Projects/*/
      ~/Projects/cone/
      ~/Projects/cone/*/
    )

    selected=`printf "%s\n" "${items[@]}" | sort | fzf`
  fi

  pushd $selected >/dev/null
  if [[ -f Session.vim ]]; then
    nvim -S
  else
    nvim
  fi
  popd >/dev/null
}
alias v=nvim-session

export FZF_DEFAULT_OPTS='
  --color=fg:-1,bg:-1,hl:-1
  --color=fg+:regular:-1,bg+:#2d323b,hl+:-1
  --color=info:-1,prompt:-1,pointer:-1
  --color=marker:-1,spinner:-1,header:-1,gutter:-1
'

bindkey -s '^T' 'ts\n'

csb() {
  clear && printf '\e[3J'
}

cleanup() {
  rm -rf $(brew --cache)
  npm cache clean --force
  yarn cache clean
  docker system prune -a # prune unused AND dangling
}
