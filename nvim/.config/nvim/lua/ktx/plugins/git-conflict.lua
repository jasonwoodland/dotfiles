return {
  {
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup({
        default_mappings = true,
        disable_diagnostics = true,
        highlights = {
          incoming = "DiffText",
          current = "DiffAdd",
        },
      })
      vim.keymap.set("n", "coo", "<Plug>(git-conflict-ours)")
      vim.keymap.set("n", "cot", "<Plug>(git-conflict-theirs)")
      vim.keymap.set("n", "cob", "<Plug>(git-conflict-both)")
      vim.keymap.set("n", "co0", "<Plug>(git-conflict-none)")
      vim.keymap.set("n", "cop", "<Plug>(git-conflict-prev-conflict)")
      vim.keymap.set("n", "con", "<Plug>(git-conflict-next-conflict)")
      vim.keymap.set("n", "coq", "<cmd>GitConflictListQf<cr>")
    end,
  },
}
