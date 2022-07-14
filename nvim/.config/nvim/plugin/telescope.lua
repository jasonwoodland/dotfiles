local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    file_ignore_patterns = { "%.git/", "node_modules/", "__generated__/", ".npm", ".next" },
    winblend = 20,
    mappings = {
      i = {
        ["<C-a>"] = function()
          vim.api.nvim_win_set_cursor(0, { 1, 1 })
        end,
        ["<C-h>"] = "which_key",
        ["<esc>"] = "close",
      },
    },
    layout_config = {
      vertical = { width = 0.5 },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    live_grep = {
      hidden = true,
    },
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("gh")
require("telescope").load_extension("repo")
