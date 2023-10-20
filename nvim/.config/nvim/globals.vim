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
cabbrev vsb vert sb
cabbrev %% %:h
