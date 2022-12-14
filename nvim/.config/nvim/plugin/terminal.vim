set title
set titlestring=%f

tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

augroup ToggleTerminal
  autocmd TermOpen * setlocal signcolumn=no nonumber norelativenumber scrolloff=0 display=
  let t:term_height = 25
  autocmd TabNew * let t:term_height = 25
  autocmd WinLeave * if exists('t:term_bufnr') | let t:term_height = winheight(bufwinnr(t:term_bufnr)) | endif
augroup END

command! -nargs=0 TerminalSplit :new|term
command! -nargs=0 TerminalVsplit :vnew|term
command! -nargs=? TerminalTab :<args>tabnew|term
command! -nargs=0 TerminalClose :call CloseTerminal()
command! -nargs=0 TerminalReset :exe 'te'|bd!#|let t:term_bufnr = bufnr('%')

call Alias("st", "TerminalSplit")
call Alias("vt", "TerminalVsplit")
call Alias("tt", "TerminalTab")
call Alias("tc", "TerminalClose")

nnoremap <silent> <leader>t :<c-u>call ToggleTerminal(v:count)<CR>
nnoremap <silent> <space>t :<c-u>call ToggleTerminal(v:count)<CR>

function! ToggleTerminal(height)
  if exists('t:term_winid') && win_id2win(t:term_winid) > 0
    let g:term_bufnr = nvim_win_get_buf(t:term_winid)
    let t:term_height = winheight(bufwinnr(g:term_bufnr))
    exe bufwinnr(g:term_bufnr).'close'
  else
    if exists('g:term_bufnr') && bufexists(g:term_bufnr)
      exe 'sb'.g:term_bufnr
      let t:term_winid = win_getid()
    else
      sp term://$SHELL
    endif
    if a:height > 1
      exe 'res'.a:height
    else
      exe 'res'.t:term_height
    endif
    exe 'set wfh'
    exe "normal! \<c-w>J"
    let g:term_bufnr = bufnr()
    let t:term_winid = win_getid()
  endif
endfunction

function! SwitchTerminal(delta)
  let bufs = filter(range(1, bufnr("$")), "getbufvar(v:val, '&buftype', 'ERROR') == 'terminal'")
  let i = index(bufs, bufnr())
  if i == -1
    let i = a:delta == 1 ? len(bufs) - 1 : 0
  else
    let i = i + a:delta
  endif
  let b = bufs[i % (len(bufs))]
  exe 'buffer'.b
endfunction

function! CloseTerminal()
  if &buftype != "terminal"
    return
  endif
  call SwitchTerminal(-1) 
  if g:term_bufnr != bufnr('%')
    bdelete! #
    let g:term_bufnr = bufnr('%')
  else
    bdelete!
  endif
endfunction

nnoremap <silent> [t :call SwitchTerminal(-1)<cr>
nnoremap <silent> ]t :call SwitchTerminal(1)<cr>


function! TerminalJob(cmd)
  bot new +resize10
  call termopen(a:cmd, {'on_exit': 'OnExit'})
  norm G
  let g:terminal_job_bufnr = bufnr()
  wincmd p
  " startinsert
  " tmap <buffer> : <esc>:
endfunction

command! -nargs=1 -complete=shellcmd TerminalJob :call TerminalJob(<q-args>)
command! TerminalJobClose :call TerminalJobClose()

cabbrev tj TerminalJob
cabbrev tjc TerminalJobClose

function! TerminalJobClose()
  exe "bd!".g:terminal_job_bufnr
endfunction

function! OnExit(job_id, code, event) dict
  if a:code == 0
    exe "bd".g:terminal_job_bufnr
  else
    wincmd p
    resize25
    startinsert
  endif
endfunction
