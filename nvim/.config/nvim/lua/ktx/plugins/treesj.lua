return {
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      use_default_keymaps = false,
    },
    config = function(_, opts)
      require('treesj').setup(opts)
      vim.keymap.set('n', 'gM', require('treesj').toggle)
      vim.keymap.set('n', 'gS', require('treesj').split)
      vim.keymap.set('n', 'gJ', require('treesj').join)
    end,
  },
}
