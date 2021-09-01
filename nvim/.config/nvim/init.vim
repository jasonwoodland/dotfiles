" vim:fdm=marker

" Plug {{{

call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'SirVer/ultisnips'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-obsession'

Plug 'jasonwoodland/vim-hyperstyle'
Plug 'michaeljsmith/vim-indent-object'
Plug 'AndrewRadev/splitjoin.vim'

" Only if coc-pairs disabled!!
" Plug 'rstacruz/vim-closer'

" Colorschemes
Plug 'christianchiarulli/nvcode-color-schemes.vim'

call plug#end()

"}}}

" Options {{{

let g:user='Jason Woodland'
let g:email='me@jasonwoodland.com'

lang messages ja_JP

set nocompatible

" If wrapping, indent blocks of text
set breakindent

" Visual block selections, selects whitespace
set virtualedit=block

" Enable wildmenu
set wildmode=full
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Ignore case when completing file names and directories
set wildignorecase

" Indent by 2 spaces, tabs are 8 wide
set tabstop=8
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab

" Highlight matching braces
set showmatch

" Only show the tabline if there is 2 or more tabs
set showtabline=1

" Enable mouse
set mouse=a

" Don't insert comment leader for o and O
autocmd BufEnter * set formatoptions-=o

" Use system clipboard
set clipboard=unnamed

set splitright
set splitbelow
set number
set nowrap

" Only wrap cursor when using arrow keys
set whichwrap=<,>,[,]

" run modelines in files
set modeline

" run local project .nvimrc or .exrc files
set exrc

" Vertical split/fold fill chars
set fillchars=vert:│

if has("nvim")
  " Show substututions in realtime in a split preview
  set inccommand=split
endif

"}}}

" Mappings, commands, abbreviations, aliases {{{

function Alias(lhs, rhs)
  exe printf('cnoreabbrev <expr> %s (getcmdtype() == ":" && getcmdline() =~ "^%s$") ? "%s" : "%s"', a:lhs, a:lhs, a:rhs, a:lhs)
endfunction

nnoremap Q <nop>

onoremap <silent> i/ :<C-U>normal! T/vt/<CR>
onoremap <silent> a/ :<C-U>normal! F/vf/<CR>
xnoremap <silent> i/ :<C-U>normal! T/vt/<CR>
xnoremap <silent> a/ :<C-U>normal! F/vf/<CR>

cabbrev vsb vert sb

" F10 to show the current highlighting group under the cursor
nmap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Trim whitespace
function! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfunction

nmap <silent> <leader><space> :call TrimWhitespace()<cr>

nnoremap <silent> <leader>v :e ~/.config/nvim/init.vim<cr>

" }}}

" Scrolling, display {{{

" lastline - Display as much of the last line as possible
" uhex - show unprintable characters hexadecimal as <xx>
set display=lastline

" Minimum number of lines to keep above and below the cursor
" autocmd BufEnter * set scrolloff=8
set scrolloff=6

" Minimum number of characters either side of the cursor
set sidescrolloff=6

" Smooth horizontal scrolling
set sidescroll=1

"}}}

" Files, buffers, backup, undo {{{

" Reload a buffer if it was changed
set autoread

" Files, backups and undo
set backup
set writebackup
set swapfile
set backupdir=/tmp
set directory=/tmp

" Remember info about open buffers on close
" % - save the buffer list, and restore it when running vim without args.
" ' - remember marks for 100 files
" / - remember 1000 items of search history
" : - remember 1000 items of command-line history
" < - save registers if they're under 100 lines
" s - save registers if they're under 10 kb
set viminfo='100,/1000,:1000,<100,s10

" Automatically save undo history to an undo file
set undofile
set undodir=~/.local/share/nvim/undo

" }}}

" Search, search navigation {{{

set magic
set ignorecase
set smartcase
set hlsearch
set incsearch

" Tab/S-Tab for moving between search matches
set wildcharm=<c-x>
cnoremap <expr> <Tab>   getcmdtype() =~ '[?/]' ? "<c-g>" : "<c-z>"
cnoremap <expr> <S-Tab> getcmdtype() =~ '[?/]' ? "<c-t>" : "<S-Tab>"

" }}}

" Bells, timeouts, matching parentheses {{{

set noerrorbells
set novisualbell

" Don't bell on <Esc>
set belloff=all

" No visual bell
set t_vb=

" Wait 400ms for a key sequence to complete
" set timeoutlen=400 ttimeoutlen=0
set ttimeoutlen=0

" Don't move cursor to matching parentheses
set matchtime=0

" }}}

" Statusline {{{

set laststatus=2 " Always show the status line
set statusline=%!StatusLine()
function! StatusLine()
  let l:status = "%F\ "
  let l:status .= "%m%r%w%h"
  let l:status .= "%=%*"
  let l:status .= "%y\ "
  let l:status .= "%l,%c/%L"
  return l:status
endfunction

" }}}

" Grep {{{

set grepprg=rg\ --vimgrep
set grepformat^=%f:%l:%c:%m

" }}}

" Terminal {{{

set title
set titlestring=%f

tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

augroup ToggleTerminal
  autocmd TermOpen * setlocal signcolumn=no nonumber scrolloff=0 display=
  let t:term_height = 25
  autocmd TabNew * let t:term_height = 25
  autocmd WinLeave * if exists('t:term_bufnr') | let t:term_height = winheight(bufwinnr(t:term_bufnr)) | endif
augroup END

command -nargs=0 TerminalSplit :new|term
command -nargs=0 TerminalVsplit :vnew|term
command -nargs=0 TerminalTab :tabnew|term
command -nargs=0 TerminalReset :exe 'te'|bd!#|let t:term_bufnr = bufnr('%')
call Alias("st", "TerminalSplit")
call Alias("vt", "TerminalVsplit")
call Alias("tt", "TerminalTab")
call Alias("rt", "TerminalReset")

nnoremap <silent> <leader>t :<c-u>call ToggleTerminal(v:count)<CR>
nnoremap <silent> <space>t :<c-u>call ToggleTerminal(v:count)<CR>

function! ToggleTerminal(height)
  if exists('t:term_bufnr') && bufwinnr(t:term_bufnr) > 0
    let t:term_height = winheight(bufwinnr(t:term_bufnr))
    exe bufwinnr(t:term_bufnr).'close'
  else
    if exists('t:term_bufnr') && bufexists(t:term_bufnr)
      exe 'sb'.t:term_bufnr
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
    let t:term_bufnr = bufnr('%')
  endif
endfunction

" }}}

" Sessions, views {{{

" Remember cursor position and folds
set viewoptions=cursor,folds

" Save/restore views when leaving/entering
augroup AutoSaveView
  autocmd!
  autocmd BufWinLeave * if expand("%") != "" | mkview | endif
  autocmd BufWinEnter * if expand("%") != "" | silent! loadview | endif
augroup END

" Enable the following for mksession
set sessionoptions=buffers,curdir,help,resize,tabpages,winpos,winsize

" }}}

" Colorscheme, syntax highlighting {{{

" Always synx syntax from start (fixes inline graphql breaking highlighting)
" autocmd BufEnter * :syntax sync fromstart

" nvcode-color-schemes onedark {{{

  let g:nvcode_termcolors=256
  syntax on
  colorscheme onedark
  set termguicolors
  set pumblend=10
  set winblend=10

  " Fix yellow underline in vue templates
  function! ClearTSStrike(timer)
    hi clear TSStrike
  endfunction
  call timer_start(500, "ClearTSStrike")

  hi clear Error
  hi link Error ErrorMsg

  hi clear MoreMsg " Used by coc-list prompt
  hi clear EndOfBuffer
  hi link EndOfBuffer NonText

  hi clear Search
  hi link Search Visual
  hi clear IncSearch
  hi link IncSearch lCursor

  hi Comment guifg=#7A859B gui=italic
  hi clear Folded
  hi Folded guifg=#7A859B
  hi clear FoldColumn
  hi link FoldColumn Folded
  hi clear MatchParen
  hi link MatchParen Visual

  hi clear CocCodeLens
  hi CocCodeLens guifg=#4b5263 gui=italic

  hi CocErrorSign guifg=#be5046
  hi CocWarningSign guifg=#d19a66
  hi CocInfoSign guifg=#e5c07b
  hi CocHintSign guifg=#61afef

  hi CocErrorHighlight gui=undercurl guisp=#be5046
  hi CocWarningHighlight gui=undercurl guisp=#d19a66
  hi CocInfoHighlight gui=undercurl guisp=#e5c07b
  hi CocHintHighlight gui=undercurl guisp=#61afef

  hi clear CocMenuSel
  hi link CocMenuSel CursorLine
  hi clear QuickFixLine
  hi link QuickFixLine CursorLine

  hi clear CocListMode
  hi clear CocListPath
  hi link CocListMode StatusLine
  hi link CocListPath StatusLine

  hi clear CocExplorerIndentLine
  hi link CocExplorerIndentLine NonText
  hi CocExplorerNormal guibg=#22262d
  hi CocExplorerEndOfBuffer guifg=#22262d guibg=#22262d
  hi CocExplorerVertSplit guifg=#282c34 guibg=#282c34
  autocmd FileType coc-explorer set winhighlight=Normal:CocExplorerNormal,VertSplit:CocExplorerVertSplit,EndOfBuffer:CocExplorerEndOfBuffer

  hi PanelNormal guibg=#22262d
  " autocmd FileType list,qf set winhighlight=Normal:PanelNormal
  autocmd FileType list,qf,help set signcolumn=auto

  hi clear Cursor
  hi link Cursor lCursor

  hi clear VertSplit
  hi VertSplit guifg=#22262d

  hi SignColumn guibg=none
  hi clear DiffChange
  hi link DiffChange LineNr
  hi DiffAdd cterm=none gui=none guifg=none guibg=#2d3828
  hi DiffDelete cterm=none gui=none guifg=#bf383a guibg=none

  hi CocGitAddedSign guifg=#98c379
  hi CocGitRemovedSign guifg=#be5046 
  hi link CocGitTopRemovedSign CocGitRemovedSign

  hi Pmenu guibg=#22262d
  hi clear PmenuSel
  hi link PmenuSel Visual
  hi clear PmenuSbar
  hi PmenuSbar guibg=#32373e
  hi PmenuThumb guibg=#454b54

  hi StatusLine guibg=#22262d
  hi StatusLineNC guifg=#7A859B guibg=#22262d
  hi TabLineFill guibg=#22262d
  hi TabLine guibg=#22262d
  hi TabLineNC guibg=#22262d
  hi TabLineSel guibg=none

  hi clear SpecialKey " fixed unreadable diggraphs output
  hi Special gui=none
  hi link SpecialKey Special

  hi link TermCursorNC Visual

" }}}

hi link netrwTreeBar LineNr

hi link Space Search
match Space /\s\+$/

" }}}

" Languages {{{
" Go {{{

augroup GoLang
  autocmd Filetype go setlocal formatprg=gofmt tabstop=4
  autocmd BufWritePre *.go :Format
  autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
augroup END

" }}}
" JavaScript {{{

autocmd FileType javascript set ft=javascriptreact

" }}}
" }}}

" Plugins {{{
" netrw {{{

let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_list_hide='.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\.\=/\=$'

" }}}
" coc.nvim {{{

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

function! SetupCocCompletion()
  if &ft =~ 'sass\|scss\|css'
    " Use a different i_<CR> mapping for hyperstyle to work
    " inoremap <buffer><silent><expr> <cr> "<C-g>u<CR>\<c-r>=hyperstyle#expand_cr()<CR>\<c-r>=coc#on_enter()\<CR>"
    " return
  endif

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  " inoremap <buffer><silent><expr> <TAB>
  "       \ pumvisible() ? "\<C-n>" :
  "       \ <SID>check_back_space() ? "\<TAB>" :
  "       \ coc#refresh()
  inoremap <silent><expr> <TAB>
    \ pumvisible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ?
    \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  let g:coc_snippet_next = '<tab>'
  let g:coc_snippet_prev = '<s-tab>'

  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <buffer><silent><expr> <c-space> coc#refresh()
  else
    inoremap <buffer><silent><expr> <c-@> coc#refresh()
  endif

  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  " inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
  "   \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
endfunction

autocmd FileType sass,scss,css let b:coc_suggest_disable = 1

autocmd filetype * call SetupCocCompletion()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf :CocCommand workspace.renameCurrentFile<cr>
nmap <leader>re <Plug>(coc-refactor)

" Project linting
nmap <leader>lp :<C-u>call setqflist([]) \| copen \| CocCommand eslint.lintProject<cr>

" Formatting selected code.
vmap <leader>fo <Plug>(coc-format-selected)
nmap <leader>fo <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json,javascript,typescriptreact setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-line)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>c  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>q  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select-backward)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
nmap <silent> <leader>ff :<C-u>Format<cr>

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OrganiseImport :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>x  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" Show symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList symbols<CR>

" coc-list
" File completion
nnoremap <silent><nowait> <space>f  :<C-u>CocList files<CR>
" Most recently used completion
nnoremap <silent><nowait> <space>m  :<C-u>CocList mru<CR>
" Buffer completion
" nnoremap <silent><nowait> <space>b  :<C-u>CocList buffers<CR>
" Window completion
" nnoremap <silent><nowait> <space>b  :<C-u>CocList windows<CR>
" Grep completion
nnoremap <silent><nowait> <space>g  :<C-u>CocList -I grep -S -regex<CR>
nnoremap <silent><nowait> <space>G  :<C-u>CocList -I grep -regex<CR>
command! -nargs=0 Todos         CocList -A --normal grep -e TODO|FIXME

" coc-explorer
nnoremap <silent><nowait> <space>e  :<C-u>CocCommand explorer<CR>


" coc-highlight
command! -nargs=0 PickColor :call CocAction('pickColor')
command! -nargs=0 ColorPresentation :call CocAction('colorPresentation')

" coc-translator
nmap <leader>x <Plug>(coc-translator-p)
vmap <leader>x <Plug>(coc-translator-pv)

autocmd User CocLocationsChange call setloclist(0, g:coc_jump_locations) | lwindow

" coc-git
" navigate chunks of current buffer
nmap [h <Plug>(coc-git-prevchunk)
nmap ]h <Plug>(coc-git-nextchunk)
" navigate conflicts of current buffer
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)


" coc-snippets
" let g:coc_snippet_next = '<tab>'
" let g:coc_snippet_prev = '<s-tab>'

" coc-terminal
" nnoremap <silent> <space>t  :<C-u>CocCommand terminal.Toggle<CR>

" coc hide floating windows on escape
nmap <silent><nowait> <Esc> :call coc#float#close_all() <CR>

" }}}
" fugitive.vim {{{

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
" call Alias("ga", "Git add")
" call Alias("gaa", "Git add --all")
" call Alias("gbl", "Git blame")
" call Alias("gb", "Git branch")
" call Alias("gbl", "Git branch --list")
" call Alias("gcl", "Git clean")
" call Alias("gclo", "Git clone")
" call Alias("gclod", "Git clone --depth=1")
" call Alias("gc", "Git commit")
" call Alias("gca", "Git commit -v --amend")
" call Alias("gcam", "Git commit -v --amend -m")
" call Alias("gcan", "Git commit -v --amend --no-edit")
" call Alias("gcm", "Git commit -v -m")
" call Alias("gco", "Git checkout")
" call Alias("gcob", "Git checkout -b")
" call Alias("gd", "Git diff")
" call Alias("gdn", "Git diff --name-only")
" call Alias("gds", "Git diff --staged")
" call Alias("gdsn", "Git diff --staged --name-only")
" call Alias("gfe", "Git fetch")
" call Alias("gl", "Git log")
" call Alias("glg", "Git log --graph")
" call Alias("gme", "Git merge")
" call Alias("gph", "Dispatch! git push -u origin")
" call Alias("gpl", "Dispatch! git pull")
" call Alias("grst", "Git restore --staged")
" call Alias("gsh", "Git stash")
" call Alias("gs", "Git status")

command -nargs=0 GIssue :call system("gh issue view --web \`git branch --show-current \| grep -o '\\#[0-9]\\+'\`")
command -nargs=0 GPullRequest :call system("gh pr view --web > /dev/null 2>&1 \|\| gh pr create --web --assignee @me")<
command -nargs=0 GRepo :call system("gh repo view --web")

call Alias("gis", "GIssue")
call Alias("gpr", "GPullRequest")
call Alias("gre", "GRepo")

" }}}
" treesitter {{{

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
  context_commentstring = {
    enable = true,
  },
}
EOF

" lua <<EOF
" local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
" parser_config.comment = {
"   used_by = {"js", "ts", "jsx", "tsx", "c", "go", "vue"} -- additional filetypes that use this parser
" }
" EOF

" }}}
" splitjoin.vim {{{

" gS on JSX/HTML tag will land the /> on it's own line
let g:splitjoin_html_attributes_bracket_on_new_line=1

" }}}
" neovim-remote {{{

let $GIT_EDITOR = 'nvr -cc split --remote-wait'
let $EDITOR = 'nvr'
let $VISUAL = 'nvr'

autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

" }}}
" Redir output command {{{

function! Redir(cmd, rng, start, end)
	for win in range(1, winnr('$'))
		if getwinvar(win, 'scratch')
			execute win . 'windo close'
		endif
	endfor
	if a:cmd =~ '^!'
		let cmd = a:cmd =~' %'
			\ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
			\ : matchstr(a:cmd, '^!\zs.*')
		if a:rng == 0
			let output = systemlist(cmd)
		else
			let joined_lines = join(getline(a:start, a:end), '\n')
			let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
			let output = systemlist(cmd . " <<< $" . cleaned_lines)
		endif
	else
		redir => output
		execute a:cmd
		redir END
		let output = split(output, "\n")
	endif
	new
	let w:scratch = 1
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	call setline(1, output)
endfunction

command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)

"}}}
" DISABLED {{{
" vim-closetag (DISABLED) {{{

" let g:closetag_filetypes = "html,php,javascript.jsx,typescript.tsx,javascriptreact,typescriptreact"

" }}}
" nvim-tree (DISABLED) {{{

" let g:nvim_tree_width = 35 "30 by default
" let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
" " let g:nvim_tree_gitignore = 1 "0 by default
" " let g:nvim_tree_auto_open = 1 "0 by default, opens the tree when typing `vim $DIR` or `vim`
" let g:nvim_tree_auto_close = 1 "0 by default, closes the tree when it's the last window
" " let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
" let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
" let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
" let g:nvim_tree_hide_dotfiles = 1 "0 by default, this option hides files and folders starting with a dot `.`
" let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
" let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
" " let g:nvim_tree_tab_open = 1 "0 by default, will open the tree when entering a new tab and the tree was previously open
" " let g:nvim_tree_width_allow_resize  = 1 "0 by default, will not resize the tree when opening a file
" let g:nvim_tree_disable_netrw = 0 "1 by default, disables netrw
" " let g:nvim_tree_hijack_netrw = 0 "1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
" " let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
" let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
" let g:nvim_tree_lsp_diagnostics = 1 "0 by default, will show lsp diagnostics in the tree. See :help nvim_tree_lsp_diagnostics

" nnoremap <leader>e :NvimTreeToggle<CR>

" hi clear NvimTreeIndentMarker
" hi link NvimTreeIndentMarker NonText

" }}}
" Denite (DISABLED) {{{

" let g:fruzzy#usenative = 1
" let g:fruzzy#sortonempty = 1 " default: 1

" " List mappings
" autocmd FileType denite call s:denite_my_settings()
" function! s:denite_my_settings() abort
"   inoremap <silent><buffer><expr> <CR>
"         \ denite#do_map('do_action')
"   nnoremap <silent><buffer><expr> i
"         \ denite#do_map('open_filter_buffer')
"   nnoremap <silent><buffer><expr> <C-w><CR>
"         \ denite#do_map('do_action', 'split')
"   nnoremap <silent><buffer><expr> <C-w>s
"         \ denite#do_map('do_action', 'split')
"   nnoremap <silent><buffer><expr> <C-w>S
"         \ denite#do_map('do_action', 'split')
"   nnoremap <silent><buffer><expr> <C-w><C-s>
"         \ denite#do_map('do_action', 'split')
"   nnoremap <silent><buffer><expr> <C-w>v
"         \ denite#do_map('do_action', 'vsplit')
"   nnoremap <silent><buffer><expr> <C-w>V
"         \ denite#do_map('do_action', 'vsplit')
"   nnoremap <silent><buffer><expr> <C-w><C-v>
"         \ denite#do_map('do_action', 'vsplit')
" endfunction

" " Filter mappings
" autocmd FileType denite-filter call s:denite_filter_my_settings()
" function! s:denite_filter_my_settings() abort
"   nnoremap <silent><buffer><expr> <C-c>
"         \ denite#do_map('quit')
"   inoremap <silent><buffer><expr> <C-c>
"         \ denite#do_map('quit')
"   inoremap <silent><buffer><expr> <Esc>
"         \ denite#do_map('quit')
"   inoremap <silent><buffer><expr> <CR>
"         \ denite#do_map('do_action')
"         \ denite#increment_parent_cursor(1)
"   inoremap <silent><buffer><expr> <C-p>
"         \ denite#increment_parent_cursor(-1)
"   nnoremap <silent><buffer><expr> <C-n>
"         \ denite#increment_parent_cursor(1)
"   nnoremap <silent><buffer><expr> <C-p>
"         \ denite#increment_parent_cursor(-1)
" endfunction

" " For ripgrep
" call denite#custom#var('file/rec', 'command', [
"       \ 'rg',
"       \ '--files',
"       \ '--glob', '!.git',
"       \ '--glob', '!node_modules',
"       \ '--glob', '!__generated__',
"       \ '--color', 'never'
"       \ ])

" " Change matchers
" call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])

" " Change sorters
" call denite#custom#source('_', 'sorters', ['sorter/sublime'])

" " Change default action
" call denite#custom#option('_', 'default_action', 'open')
" call denite#custom#option('_', 'statusline', v:false)


" " Ripgrep command on grep source
" call denite#custom#var('grep', {
"         \ 'command': ['rg'],
"         \ 'default_opts': ['-i', '--vimgrep', '--no-heading'],
"         \ 'recursive_opts': [],
"         \ 'pattern_opt': ['--regexp'],
"         \ 'separator': ['--'],
"         \ 'final_opts': [],
"         \ })

" " Leader mappings
" nmap <silent> <leader>e   :Denite -auto-resize -start-filter -default-action=open file/rec<cr>
" nmap <silent> <leader>sp  :Denite -auto-resize -start-filter -default-action=split file/rec<cr>
" nmap <silent> <leader>vsp :Denite -auto-resize -start-filter -default-action=vsplit file/rec<cr>
" nmap <silent> <leader>b   :Denite -auto-resize -start-filter -default-action=open buffer<cr>
" nmap <silent> <leader>sb  :Denite -auto-resize -start-filter -default-action=split buffer<cr>
" nmap <silent> <leader>vsb :Denite -auto-resize -start-filter -default-action=vsplit buffer<cr>
" nmap <silent> <leader>g   :Denite -auto-resize -start-filter -default-action=open grep<cr>

"}}}
" Lightline (DISABLED) {{{
" let g:lightline = {
"   \ 'colorscheme': 'onedark',
"   \ 'separator': { 'left': '', 'right': '' },
"   \ 'subseparator': { 'left': '', 'right': '' },
"   \ 'active': {
"   \   'left': [ [ 'mode', 'paste' ],
"   \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
"   \ },
"   \ 'component_function': {
"   \   'cocstatus': 'coc#status'
"   \ },
"   \ }

" autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

"}}}
" wilder.nvim (DISABLED) {{{

" call wilder#enable_cmdline_enter()
" set wildcharm=<Tab>
" cmap <expr> <C-N> wilder#in_context() ? wilder#next() : "\<C-N>"
" cmap <expr> <C-P> wilder#in_context() ? wilder#previous() : "\<C-P>"
" cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
" cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
" call wilder#set_option('modes', [':'])

" call wilder#set_option('pipeline', [
"       \   wilder#branch(
"       \     wilder#cmdline_pipeline({
"       \       'fuzzy': 1,
"       \     }),
"       \     wilder#python_search_pipeline({
"       \       'pattern': 'fuzzy',
"       \     }),
"       \   ),
"       \ ])

" let s:highlighters = [
"         \ wilder#pcre2_highlighter(),
"         \ wilder#basic_highlighter(),
"         \ ]

" call wilder#set_option('renderer', wilder#renderer_mux({
"       \ ':': wilder#popupmenu_renderer({
"       \   'highlighter': wilder#basic_highlighter(),
"       \   'left': [
"       \     wilder#popupmenu_devicons(),
"       \   ],
"       \ }),
"       \ }))

" }}}
" }}}
" }}}
