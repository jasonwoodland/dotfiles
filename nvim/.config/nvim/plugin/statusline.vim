set statusline=%!StatusLine()

function! StatusLine()
  let l:status = "%F\ "
  let l:status .= "%m%r%w%h"
  let l:status .= "%=%*"
  let l:status .= "%y\ "
  let l:status .= "%l,%c/%L"
  return l:status
endfunction
