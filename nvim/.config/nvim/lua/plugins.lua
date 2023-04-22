local plugins = {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },         -- Required
      { 'hrsh7th/cmp-nvim-lsp' },     -- Required
      { 'hrsh7th/cmp-buffer' },       -- Optional
      { 'hrsh7th/cmp-path' },         -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' },     -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' }, -- Required
      -- { 'rafamadriz/friendly-snippets' }, -- Optional
    }
  },
  { 'lewis6991/gitsigns.nvim' },
  {
    'zbirenbaum/copilot-cmp',
    dependencies = { 'zbirenbaum/copilot.lua' },
  },
  {
    'ray-x/go.nvim',
    config = function()
      require('go').setup()
    end,
  },
  { 'onsails/lspkind-nvim' },

  { 'jasonwoodland/vim-closer' },
  { 'michaeljsmith/vim-indent-object' },
  { 'AndrewRadev/splitjoin.vim' },
  { 'andymass/vim-matchup' },
  {
    'akinsho/git-conflict.nvim',
    config = function()
      require('git-conflict').setup({
        default_mappings = false,   -- disable buffer local mapping created by this plugin
        disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
        highlights = {
          -- They must have background color, otherwise the default color will be used
          incoming = 'DiffText',
          current = 'DiffAdd',
        }
      })

      vim.keymap.set('n', 'gco', '<Plug>(git-conflict-ours)')
      vim.keymap.set('n', 'gct', '<Plug>(git-conflict-theirs)')
      vim.keymap.set('n', 'gcb', '<Plug>(git-conflict-both)')
      vim.keymap.set('n', 'gc0', '<Plug>(git-conflict-none)')
      vim.keymap.set('n', '[g', '<Plug>(git-conflict-prev-conflict)')
      vim.keymap.set('n', ']g', '<Plug>(git-conflict-next-conflict)')
      vim.keymap.set('n', 'gcq', '<cmd>GitConflictListQf<cr>')
    end,
  },
  -- { 'eandrju/cellular-automaton.nvim' },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { "nvim-telescope/telescope-github.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim",   build = "make" },
  { "cljoly/telescope-repo.nvim" },
  -- {
  --   "akinsho/toggleterm.nvim",
  --   version = "*",
  --   opts = {
  --     open_mapping = [[<c-\>]],
  --     shade_terminals = false,
  --   }
  -- },

  { 'tpope/vim-sensible' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-abolish' },
  { 'tpope/vim-unimpaired' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-sleuth' },
  { 'tpope/vim-rsi' },
  { 'tpope/vim-eunuch' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
  { 'tpope/vim-vinegar' },
  { 'tpope/vim-dispatch' },
  { 'tpope/vim-obsession' },
  { 'tpope/vim-endwise' },
  { 'tpope/vim-commentary' },
  { 'tpope/vim-characterize' },
  { 'tpope/vim-capslock' },

  { "morhetz/gruvbox" },
  -- { "sainnhe/everforest" },

  { "nvim-treesitter/nvim-treesitter" },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  { "Rawnly/gist.nvim" },
}

return plugins
