let g:user='Jason Woodland'
let g:email='me@jasonwoodland.com'

set notimeout

set breakindent
set virtualedit=block

set number

set shiftwidth=2
set softtabstop=2
set expandtab

set ignorecase
set smartcase

set wildignore=.DS_Store
set wildignorecase

set completeopt+=menu,menuone,noselect

set scrolloff=5
set sidescrolloff=5

set mousescroll=ver:1,hor:0

set jumpoptions+=view

set inccommand=split

set splitbelow
set splitright

set fillchars+=vert:│

set nowrap
set whichwrap+=<,>,[,]

set modelines=1
set exrc

" set shortmess+=I

set backup
set backupdir-=.
set undofile

set shada+=/1000,:1000

set clipboard=unnamed

set grepprg="rg --vimgrep --no-heading --smart-case"

autocmd BufEnter * set formatoptions-=o
