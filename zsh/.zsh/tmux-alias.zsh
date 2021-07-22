# ts() {
#   tmux -2 attach -t $1 2> /dev/null || tmux -2 new -s $1
# }

s() {
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

  dirname=`basename $selected`

  tmux switch-client -t $dirname > /dev/null 2>&1
  tmux attach -t $dirname > /dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    return
  fi

  tmux new-session -c $selected -d -s $dirname && tmux switch-client -t $dirname || tmux new -c $selected -A -s $dirname
}

# don't froget to rm ~/.zcompdump when you're finished

alias tl="tmux ls"
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'
