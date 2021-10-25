local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local use = require('packer').use
require('packer').startup(function()
  -- use 'sheerun/vim-polyglot'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'nvim-lua/plenary.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'lewis6991/gitsigns.nvim'

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'petertriho/cmp-git'
  use 'saadparwaiz1/cmp_luasnip'
  use 'tamago324/cmp-zsh'

  use 'jose-elias-alvarez/nvim-lsp-ts-utils'

  use 'L3MON4D3/LuaSnip'
  use 'onsails/lspkind-nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'nvim-telescope/telescope.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'tpope/vim-sensible'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-abolish'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-repeat'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-rsi'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-vinegar'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-obsession'
  use 'jasonwoodland/vim-hyperstyle'
  use 'michaeljsmith/vim-indent-object'
  use 'AndrewRadev/splitjoin.vim'
  use 'rstacruz/vim-closer'
  use 'christianchiarulli/nvcode-color-schemes.vim'
end)
