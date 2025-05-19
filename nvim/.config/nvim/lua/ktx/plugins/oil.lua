return {
  {
    "stevearc/oil.nvim",
    config = function()
      local all_columns = false
      local signcolumn = true
      require("oil").setup({
        default_file_explorer = true,
        buf_options = {
          -- number = false,
        },
        columns = {
          "icon",
        },
        keymaps = {
          ["gd"] = "<cmd>edit ~/ghq/github.com/jasonwoodland/dotfiles/<CR>",
          ["gf"] = {
            function()
              require("telescope.builtin").find_files({
                cwd = require("oil").get_current_dir(),
              })
            end,
            mode = "n",
            nowait = true,
            desc = "Find files in the current directory",
          },
          ["gh"] = "<cmd>edit $HOME<CR>",
          ["gl"] = function()
            all_columns = not all_columns
            require("oil").set_columns(
              all_columns and { "icon", "permissions", "size", "mtime" } or { "icon" }
            )
          end,
          ["gs"] = function()
            signcolumn = not signcolumn
            vim.wo.signcolumn = signcolumn and "yes:2" or "no"
          end,
        },
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        experimental_watch_for_changes = true,
        watch_for_changes = true,
        lsp_file_methods = {
          autosave_changes = "unmodified",
        },
        constrain_cursor = "name",
        win_options = {
          signcolumn = "yes:2",
        },
      })

      vim.api.nvim_create_augroup("MyOil", {})
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        pattern = { "oil://*/", "oil-ssh://*/", "oil-trash://*/" },
        group = "MyOil",
        callback = function()
          vim.opt_local.number = false
        end,
      })
    end,
  },
  {
    "refractalize/oil-git-status.nvim",
    dependencies = {
      "stevearc/oil.nvim",
    },
    config = true,
  },
  { -- we need gx cos oil.nvim disables netrw which provided gx
    "chrishrb/gx.nvim",
    event = { "BufEnter" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true, -- default settings
  },
}
