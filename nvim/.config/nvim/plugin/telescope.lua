local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    winblend = 20,
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<esc>"] = "close"
      }
    },
    layout_config = {
      vertical = { width = 0.5 }
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
require('telescope').load_extension('fzf')
