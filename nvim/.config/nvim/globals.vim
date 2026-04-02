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

" EXTRAS from the vim docs:
" See :help fuzzy-file-picker

" Turn native :find command into a fuzzy, interactive file picker
set findfunc=Find
func Find(arg, _)
  if empty(s:filescache)
    let s:filescache = globpath('.', '**', 1, 1)
    call filter(s:filescache, '!isdirectory(v:val)')
    call map(s:filescache, "fnamemodify(v:val, ':.')")
  endif
  return a:arg == '' ? s:filescache : matchfuzzy(s:filescache, a:arg)
endfunc
let s:filescache = []
autocmd CmdlineEnter : let s:filescache = []

" :Grep searches for lines matching a pattern and updates the results dynamically as you type
command! -nargs=+ -complete=customlist,<SID>Grep
        \ Grep call <SID>VisitFile()

func s:Grep(arglead, cmdline, cursorpos)
  if match(&grepprg, '\$\*') == -1 | let &grepprg ..= ' $*' | endif
  let cmd = substitute(&grepprg, '\$\*', shellescape(escape(a:arglead, '\')), '')
  return len(a:arglead) > 1 ? systemlist(cmd) : []
endfunc

func s:VisitFile()
  let item = getqflist(#{lines: [s:selected]}).items[0]
  let pos  = '[0,\ item.lnum,\ item.col,\ 0]'
  exe $':b +call\ setpos(".",\ {pos}) {item.bufnr}'
  call setbufvar(item.bufnr, '&buflisted', 1)
endfunc

autocmd CmdlineLeavePre :
      \ if get(cmdcomplete_info(), 'matches', []) != [] |
      \   let s:info = cmdcomplete_info() |
      \   if getcmdline() =~ '^\s*fin\%[d]\s' && s:info.selected == -1 |
      \     call setcmdline($'find {s:info.matches[0]}') |
      \   endif |
      \   if getcmdline() =~ '^\s*Grep\s' |
      \     let s:selected = s:info.selected != -1
      \         ? s:info.matches[s:info.selected] : s:info.matches[0] |
      \     call setcmdline(s:info.cmdline_orig) |
      \   endif |
      \ endif
