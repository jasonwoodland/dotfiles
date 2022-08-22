_getprojdirs() {
  declare arr="$1"
  dirs=(
    ~/ghq/github.com/*/*/
    ~/ghq/github.com/*/dotfiles/*/
  )
  dirs=("${(u)dirs[@]}") #`
  arr=$dirs
}
projdir() {
  _getprojdirs dirs
  if [[ $# -eq 1 ]]; then
    selected=$1
  else
    selected=`printf "%s\n" "${dirs[@]}" | sort | fzf`
    if [[ $selected == '' ]]; then
      return
    fi
  fi
  dirname=`basename $selected`
  dirname=${dirname##.}
  cd $selected
}
tprojdir() {
  _getprojdirs dirs
  if [[ $# -eq 1 ]]; then
    selected=$1
  else
    selected=`printf "%s\n" "${dirs[@]}" | sort | fzf`
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
  _getprojdirs dirs
  _describe 'parameters' dirs
  return
}
zle -N zprojdir
compdef _projdir projdir
bindkey '^ ' zprojdir
bindkey -a '^ ' zprojdir
