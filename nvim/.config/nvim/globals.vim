function! Alias(lhs, rhs)
  exe printf('cnoreabbrev <expr> %s (getcmdtype() == ":" && getcmdline() =~ "^%s$") ? "%s" : "%s"', a:lhs, a:lhs, a:rhs, a:lhs)
endfunction

function! Bdelete(force)
  let l:alt=@#
  enew
  if a:force
    bdelete! #
  else
    bdelete #
  endif
  if strlen(l:alt) > 0
    exe 'edit '.l:alt
    let @#=l:alt
  endif
endfunction

command! -nargs=0 -bang Bdelete :call Bdelete('<bang>' == '!')

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

command! -nargs=0 SynGroup :call SynGroup()
cabbrev vsb vert sb

autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
