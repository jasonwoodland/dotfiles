function Alias(lhs, rhs)
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

command -nargs=0 -bang Bdelete :call Bdelete('<bang>' == '!')

nnoremap Q <nop>

onoremap <silent> i/ :<C-U>normal! T/vt/<CR>
onoremap <silent> a/ :<C-U>normal! F/vf/<CR>
xnoremap <silent> i/ :<C-U>normal! T/vt/<CR>
xnoremap <silent> a/ :<C-U>normal! F/vf/<CR>

cabbrev vsb vert sb

