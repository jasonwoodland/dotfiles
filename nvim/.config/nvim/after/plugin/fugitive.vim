augroup Fugitive
  autocmd FileType fugitive setl signcolumn=no
  autocmd FileType fugitive setl nonumber
  autocmd FileType gitcommit setlocal spell
augroup END

" Fix git hook output on commit (see: https://github.com/tpope/vim-fugitive/issues/1446)
let g:fugitive_pty = 0

nnoremap <silent> <leader>g :call ToggleGit()<CR>

function ToggleGit()
  if bufwinnr(".git/index") == -1
    Git
  else
    exe "bd".bufnr(".git/index")
  endif
endfunction

call Alias("git", "Git")
nnoremap g<space> :Git<space>

function! GitAliasCallback(j, d, e)
  for l in a:d
    let p = split(l, " ")
    if len(p) > 5
      call Alias("g".p[0], "Git ".p[0])
    elseif len(p) >= 3
      call Alias("g".p[0], "Git ".join(p[2:], " "))
    endif
  endfor
endfunction
function! GitAliasExit(j, d, e)
  cuna gph
  cuna gpl
  call Alias("gph", "bot new +resize10 term://git push -u origin \\| startinsert")
  call Alias("gpl", "bot new +resize10 term://git pull \\| startinsert")
endfunction
call jobstart("git alias", {'on_stdout':'GitAliasCallback', 'on_exit':'GitAliasExit'})
