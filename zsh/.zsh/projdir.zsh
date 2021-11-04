_projdirs=(
  ~/github.com/*/*
  ~/github.com/ispec-inc/*/go/
  ~/github.com/ispec-inc/*/*/apps/*/
)
_projdirs=("${(u)_projdirs[@]}") #`
projdir() {
  if [[ $# -eq 1 ]]; then
    selected=$1
  else
    selected=`printf "%s\n" "${_projdirs[@]}" | sort | fzf`
    if [[ $selected == '' ]]; then
      return
    fi
  fi
  dirname=`basename $selected`
  dirname=${dirname##.}
  cd $selected
}
tprojdir() {
  if [[ $# -eq 1 ]]; then
    selected=$1
  else
    selected=`printf "%s\n" "${_projdirs[@]}" | sort | fzf`
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
  zle reset-prompt
}
zprojdir() {
  projdir
  zle reset-prompt
}
_projdir() {
  _describe 'parameters' _projdirs
  return
}
zle -N zprojdir
bindkey -a '^[p' zprojdir
bindkey '^[p' zprojdir
bindkey -as '^[]' 'itprojdir\n'
bindkey -s '^[]' '^utprojdir\n'
alias p='projdir'
compdef _projdir projdir
