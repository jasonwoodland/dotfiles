_projdirs=(
  ~/ispec/*/
  ~/ispec/*/go/
  ~/ispec/*/*/apps/*/
  ~/Projects/*/
  ~/Projects/cone/
  ~/Projects/cone/*/
  ~/.dotfiles/
  ~/.dotfiles/*/
)
_projdirs=("${(u)_projdirs[@]}") #`
projdir() {
  if [[ $# -eq 1 ]]; then
    selected=$1
  else
    selected=`printf "%s\n" "${_projdirs[@]}" | sort | fzf --height 40%`
    if [[ $selected == '' ]]; then
      return
    fi
  fi
  dirname=`basename $selected`
  dirname=${dirname##.}
  cd $selected
}
zprojdir() {
  projdir
  zle reset-prompt
}
_projdir() {
  _projdirs=(
    ~/ispec/*/
    ~/ispec/*/go/
    ~/ispec/*/*/apps/*/
    ~/Projects/*/
    ~/Projects/cone/
    ~/Projects/cone/*/
    ~/.dotfiles/
    ~/.dotfiles/*/
  )
  _projdirs=("${(u)_projdirs[@]}") #`
  _describe 'parameters' _projdirs
  return
}
zle -N zprojdir
bindkey -a '^[p' zprojdir
bindkey '^[p' zprojdir
alias p='projdir'
compdef _projdir projdir
