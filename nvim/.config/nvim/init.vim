" vim:fdm=marker

" Plug {{{

call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'onsails/lspkind-nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'nvim-telescope/telescope.nvim'

" Plug 'SirVer/ultisnips'

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
Plug 'rstacruz/vim-closer' " Only if coc-pairs disabled!!
Plug 'christianchiarulli/nvcode-color-schemes.vim'

call plug#end()

"}}}

" Options {{{

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

"}}}

" Mappings, commands, abbreviations, aliases {{{

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

" Don't typeout key sequences
set notimeout

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
command -nargs=? TerminalTab :<args>tabnew|term
command -nargs=0 TerminalReset :exe 'te'|bd!#|let t:term_bufnr = bufnr('%')
call Alias("st", "TerminalSplit")
call Alias("vt", "TerminalVsplit")
call Alias("tt", "TerminalTab")
call Alias("tr", "TerminalReset")

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
  echo b
  exe 'buffer'.b
endfunction

nnoremap <silent> [t :call SwitchTerminal(-1)<cr>
nnoremap <silent> ]t :call SwitchTerminal(1)<cr>

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

  hi NvimTreeNormal guibg=#22262d
  hi NvimTreeEndOfBuffer guifg=#22262d guibg=#22262d
  hi NvimTreeVertSplit guifg=#282c34 guibg=#282c34

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
  hi link netrwTreeBar LineNr

  hi link Space Search
  match Space /\s\+$/

  hi clear TelescopeBorder
  hi TelescopeBorder guifg=#7A859B guibg=#22262d
  hi TelescopeNormal guibg=#22262d
  hi TelescopePreviewNormal guibg=#22262d

" }}}
" }}}

" Languages {{{
" Go {{{

augroup GoLang
  autocmd Filetype go setlocal formatprg=gofmt tabstop=4
  autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
augroup END

" }}}
" Javascript {{{

augroup Javascript
  autocmd FileType javascript set ft=javascriptreact
augroup END

" }}}
" Typescript {{{

augroup Typescript
  command -nargs=0 OrganizeImports :lua vim.lsp.buf.execute_command({command = '_typescript.organizeImports', arguments = {vim.fn.expand('%:p')}})
augroup END
" }}}
" }}}

" Plugins {{{
" nvim-tree.lua {{{
lua<<EOF
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup {
  -- disables netrw completely
  disable_netrw       = false,
  -- hijack netrw window on startup
  hijack_netrw        = false,
  -- open the tree when running this setup function
  open_on_setup       = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup  = {},
  -- closes neovim automatically when the tree is the last **WINDOW** in the view
  auto_close          = true,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab         = false,
  -- hijacks new directory buffers when they are opened.
  update_to_buf_dir   = {
    -- enable the feature
    enable = false,
    -- allow to open the tree if it was previously closed
    auto_open = true,
  },
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = true,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd          = false,
  -- show lsp diagnostics in the signcolumn
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = true,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },

  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 30,
    -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
    height = 30,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    auto_resize = false,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {
        { key = "<C-s>", cb = tree_cb("split") },
        { key = "h", cb = tree_cb("close_node") },
        { key = "l", cb = tree_cb("open_node") },
      }
    }
  }
}
EOF

nnoremap <space>e <cmd>NvimTreeToggle<cr>

" }}}
" nvim-lspconfig {{{

lua<<EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>rf', '<cmd>lua vim.lsp.util.rename(vim.fn.expand("%"), vim.fn.input("New Filename: ", vim.fn.expand("%")))<CR>', opts)
  buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities
  }

  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end)
 
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = {
    prefix = '', -- Could be '●', '▎', 'x'
    
  }
})
EOF

" }}}
" gitsigns.nvim {{{

lua<<EOF
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  keymaps = {
    -- Default keymap options
    noremap = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
  },
  current_line_blame_formatter_opts = {
    relative_time = false
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}

EOF
" }}}
" nvim-cmp {{{
lua<<EOF
local lspkind = require 'lspkind' 
local cmp = require 'cmp'
local luasnip = require 'luasnip'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
  formatting = {
    format = lspkind.cmp_format({with_text = true})
  }
}
EOF
" }}}
" telescope.nvim {{{
lua<<EOF
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    find_files = {
    },
    live_grep = {
    },
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
EOF
nnoremap <space>f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <space>g <cmd>lua require('telescope.builtin').live_grep()<cr>
" }}}
" netrw {{{

let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_list_hide='.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\.\=/\=$'
hi link netrwTreeBar LineNr


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
  call Alias("gph", "Dispatch! git push -u origin")
  call Alias("gpl", "Dispatch! git pull")
endfunction
call jobstart("git alias", {'on_stdout':'GitAliasCallback', 'on_exit':'GitAliasExit'})

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

lua <<EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.comment = {
  used_by = {"js", "ts", "jsx", "tsx", "c", "go", "vue"} -- additional filetypes that use this parser
}
EOF

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
" }}}
