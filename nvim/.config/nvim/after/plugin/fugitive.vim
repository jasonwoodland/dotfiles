augroup Fugitive
  autocmd FileType fugitive setl signcolumn=no
  autocmd FileType fugitive setl nonumber
  autocmd FileType gitcommit setlocal spell
augroup END

" Fix git hook output on commit (see: https://github.com/tpope/vim-fugitive/issues/1446)
" let g:fugitive_pty = 0

function! Alias(lhs, rhs)
  exe printf('cnoreabbrev <expr> %s (getcmdtype() == ":" && getcmdline() =~ "^%s$") ? "%s" : "%s"', a:lhs, a:lhs, a:rhs, a:lhs)
endfunction

call Alias("git", "Git")

function! GitAliasCallback(j, d, e)
  for l in a:d
    let p = split(l, " ")
    if len(p) < 2
      continue
    endif
    if p[2][0] == '!'
      call Alias("g".p[0], "Git ".p[0])
    else
      call Alias("g".p[0], "Git ".join(p[2:], " "))
    endif
  endfor
endfunction

function! GitAliasExit(j, d, e)
  cuna gph
  cuna gpl
  call Alias("gph", "FugitiveJob git push -u origin")
  call Alias("gpl", "FugitiveJob git pull")
endfunction

call jobstart("git alias", {'on_stdout':'GitAliasCallback', 'on_exit':'GitAliasExit'})
