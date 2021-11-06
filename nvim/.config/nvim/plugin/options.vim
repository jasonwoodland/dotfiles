
let g:user='Jason Woodland'
let g:email='me@jasonwoodland.com'

" lang messages ja_JP

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

" Don't give intro message
set shortmess+=I

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

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

set magic
set ignorecase
set smartcase
set hlsearch
set incsearch

" Tab/S-Tab for moving between search matches
set wildcharm=<c-x>
cnoremap <expr> <Tab>   getcmdtype() =~ '[?/]' ? "<c-g>" : "<c-z>"
cnoremap <expr> <S-Tab> getcmdtype() =~ '[?/]' ? "<c-t>" : "<S-Tab>"

set noerrorbells
set novisualbell

" Don't bell on <Esc>
set belloff=all

" No visual bell
set t_vb=

" Don't typeout key sequences
set notimeout

" Don't move cursor to matching parentheses
set matchtime=0

set grepprg=rg\ --vimgrep
set grepformat^=%f:%l:%c:%m

set completeopt=menu,menuone,noselect

