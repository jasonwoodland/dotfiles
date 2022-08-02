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
set shiftwidth=2
set softtabstop=2
set expandtab

" Highlight matching braces
set showmatch

" Only show the tabline if there is 2 or more tabs
set showtabline=1

" Use mouse wheel to scroll line by line/char by char
set mousescroll=ver:1,hor:1

" Restore the view when jumping
set jumpoptions+=view

" Don't insert comment leader for o and O
autocmd BufEnter * set formatoptions-=o

" Use system clipboard
set clipboard=unnamed

set splitright
set splitbelow
set number
set nowrap

" Wrap cursor when using arrow keys
set whichwrap+=<,>,[,]

" run modelines in files
set modeline

" run local project .nvimrc or .exrc files
set exrc

" Vertical split/fold fill chars
set fillchars+=vert:│

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
set scrolloff=6

" Minimum number of characters either side of the cursor
set sidescrolloff=6

" Files, backups and undo
set backup

" / - remember 1000 items of search history
" : - remember 1000 items of command-line history
set shada+=/1000,:1000

" Automatically save undo history to an undo file
set undofile

set ignorecase
set smartcase

" Tab/S-Tab for moving between search matches
cnoremap <expr> <Tab>   getcmdtype() =~ '[?/]' ? "<c-g>" : "<c-z>"
cnoremap <expr> <S-Tab> getcmdtype() =~ '[?/]' ? "<c-t>" : "<S-Tab>"

" Don't typeout key sequences
set notimeout

" Don't move cursor to matching parentheses
set matchtime=0

set grepprg="rg --vimgrep --no-heading --smart-case"

set completeopt=menu,menuone,noselect
