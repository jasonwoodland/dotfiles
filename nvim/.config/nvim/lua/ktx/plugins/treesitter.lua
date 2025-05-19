return {
  { "nvim-treesitter/nvim-treesitter" },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter" },
  },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  {
    "TXPGhost/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        multiline_threshold = 1,
        update_debounce = 100,
      })
    end,
  },
}
