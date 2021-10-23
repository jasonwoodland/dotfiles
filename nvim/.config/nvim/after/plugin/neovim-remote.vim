let $GIT_EDITOR = 'nvr -cc split --remote-wait'
let $EDITOR = 'nvr'
let $VISUAL = 'nvr'

autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
