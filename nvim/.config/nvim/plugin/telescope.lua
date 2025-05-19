local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    file_ignore_patterns = { "%.git/", "node_modules/", "__generated__/", "\\.npm" },
    winblend = 0,
    mappings = {
      i = {
        ["<C-a>"] = false,
        ["<C-h>"] = "which_key",
        ["<esc>"] = "close",
        ["<C-i>"] = actions.cycle_previewers_next,
        ["<C-o>"] = actions.cycle_previewers_prev,
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
      -- hidden = true,
      additional_args = function(opts)
        return {
          "--hidden",
          "--pcre2",
          "--max-filesize=5M",
          -- "--glob '!*.json",
        }
      end,
    },
    colorscheme = {
      enable_preview = true,
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("gh")
require("telescope").load_extension("repo")
-- require("telescope").load_extension('harpoon')
