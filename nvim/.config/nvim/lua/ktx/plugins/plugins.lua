return {
  {
    "jasonwoodland/terminal.nvim",
    config = function()
      require("terminal").setup({
        cycle_normal_mode = false,
        cycle_terminal_mode = false,
        height = 24,
      })
    end,
  },
  {
    "jasonwoodland/graphql.nvim",
    config = true,
  },
  { "jasonwoodland/base64.nvim" },
  { "jasonwoodland/vim-closer" },

  { "tpope/vim-sensible" },
  { "tpope/vim-surround" },
  { "tpope/vim-abolish" },
  { "tpope/vim-unimpaired" },
  { "tpope/vim-repeat" },
  { "tpope/vim-sleuth" },
  { "tpope/vim-rsi" },
  { "tpope/vim-eunuch" },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-vinegar" },
  { "tpope/vim-dispatch" },
  { "tpope/vim-obsession" },
  { "tpope/vim-endwise" },
  { "tpope/vim-commentary" },
  { "tpope/vim-characterize" },
  { "tpope/vim-capslock" },

  { "andymass/vim-matchup" },
  { "michaeljsmith/vim-indent-object" },
  { "Rawnly/gist.nvim" },

  { "romainl/vim-qf" },
}
