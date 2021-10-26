let $GIT_EDITOR = 'nvr -cc split --remote-wait'
let $EDITOR = 'nvr'
let $VISUAL = 'nvr'

augroup NeovimRemote
  autocmd!
  autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
augroup END
