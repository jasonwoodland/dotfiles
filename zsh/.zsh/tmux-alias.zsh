ts() {
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
      ~/.dotfiles/
      ~/.dotfiles/*/
    )
    items=("${(u)items[@]}") #`

    selected=`printf "%s\n" "${items[@]}" | sort | fzf --height 40%`

    if [[ $selected == '' ]]; then
      return
    fi
  fi

  dirname=`basename $selected`
  dirname=${dirname##.}

  if [[ -v TMUX ]]; then
    tmux switch-client -t $dirname 2>/dev/null
    if [[ $? -eq 0 ]]; then
      return
    fi
  fi

  tmux attach -t $dirname 2>/dev/null
  if [[ $? -eq 0 ]]; then
    return
  fi

  tmux new-session -s $dirname -d -c $selected 2>/dev/null
  if [[ $? -eq 0 ]]; then
    if [[ $2 != "" ]]; then
      tmux send-keys -t $dirname "$2" Enter
    fi
    if [[ -v TMUX ]]; then
      tmux switch-client -t $dirname 2>/dev/null
    else
      tmux attach -t $dirname
    fi
  fi
}

# don't forget to rm ~/.zcompdump when you're finished

alias tl="tmux ls"
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'
