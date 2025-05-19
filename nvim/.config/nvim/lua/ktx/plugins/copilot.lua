return {
  {
    'zbirenbaum/copilot.lua',
    config = function()
      require("copilot").setup({
        suggestion = {
          enable = true,
          keymap = {
            accept = "<C-M-y>",
            next = "<C-M-n>",
            prev = "<C-M-p>",
            dismiss = "<C-M-e>",
          }
        }
      })
    end
  }
}
