local plugins = {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        'williamboman/mason.nvim', -- Optional
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
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
    }
  },
  -- {
  --   "jay-babu/mason-null-ls.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --     "jose-elias-alvarez/null-ls.nvim",
  --   },
  --   -- config = function()
  --   --   require("your.null-ls.config") -- require your null-ls config here (example below)
  --   -- end,
  -- },
  { 'jose-elias-alvarez/null-ls.nvim' },
  { 'lewis6991/gitsigns.nvim' },
  {
    'zbirenbaum/copilot-cmp',
    dependencies = { 'zbirenbaum/copilot.lua' },
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  { 'onsails/lspkind-nvim' },

  { 'jasonwoodland/vim-closer' },
  { 'michaeljsmith/vim-indent-object' },
  -- { 'AndrewRadev/splitjoin.vim' },
  {
    'Wansmer/treesj',
    keys = { 'gm', 'gJ', 'gS' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({ use_default_keymaps = false })
      vim.keymap.set('n', 'gM', require('treesj').toggle)
      vim.keymap.set('n', 'gS', require('treesj').split)
      vim.keymap.set('n', 'gJ', require('treesj').join)
    end,
  },
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

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { "nvim-telescope/telescope-github.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "cljoly/telescope-repo.nvim" },

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
  { "glepnir/oceanic-material" },
  { "navarasu/onedark.nvim" },
  -- { "sainnhe/everforest" },

  { "nvim-treesitter/nvim-treesitter" },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter" },
  },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  { "Rawnly/gist.nvim" },
  {
    'glacambre/firenvim',

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    cond = not not vim.g.started_by_firenvim,
    build = function()
      require("lazy").load({ plugins = "firenvim", wait = true })
      vim.fn["firenvim#install"](0)
    end
  },
  {
    "weilbith/nvim-code-action-menu",
    config = function()
      vim.keymap.set('n', '<leader>a', '<cmd>CodeActionMenu<cr>')
    end
  },
}

return plugins
