return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local function noremap(mode, lhs, rhs, opts)
        opts = vim.tbl_extend("force", { noremap = true }, opts or {})
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      local pickers = require "telescope.pickers"
      local previewers = require "telescope.previewers"
      local finders = require "telescope.finders"
      local conf = require("telescope.config").values
      local action_state = require "telescope.actions.state"

      function dotfiles()
        require('telescope.builtin').find_files {
          cwd = '~/ghq/github.com/jasonwoodland/dotfiles',
          hidden = true,
          prompt_title = "Dotfiles"
        }
      end

      local actions = require "telescope.actions"

      local function project_files(cwd)
        require('telescope.builtin').find_files {
          cwd = cwd,
          attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local path = action_state.get_selected_entry()[1]
              vim.api.nvim_command("lcd " .. cwd)
              vim.api.nvim_command("edit " .. path)
            end)
            actions.select_horizontal:replace(function()
              actions.close(prompt_bufnr)
              local path = action_state.get_selected_entry()[1]
              vim.api.nvim_command("lcd " .. cwd)
              vim.api.nvim_command("split " .. path)
            end)
            actions.select_vertical:replace(function()
              actions.close(prompt_bufnr)
              local path = action_state.get_selected_entry()[1]
              vim.api.nvim_command("lcd " .. cwd)
              vim.api.nvim_command("vertical split " .. path)
            end)
            return true
          end,
        }
      end

      local function projects(opts)
        opts = opts or {}
        local command = "ls -1d ~/ghq/*/*/*/{,server,client} ~/ghq/*/jasonwoodland/dotfiles/*/"
        local handle = io.popen(command)

        if (handle == nil) then
          print('could not run specified command:' .. command)
          return
        end

        local result = handle:read("a")

        handle:close()

        local files = {}

        for token in string.gmatch(result, "[^%c]+") do
          table.insert(files, token)
        end
        pickers.new({
          prompt_title = "Projects",
          finder = finders.new_table {
            results = files,
          },
          attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local path = action_state.get_selected_entry()[1]
              vim.api.nvim_command("silent! lcd " .. path)
              vim.api.nvim_command("edit .")
            end)
            actions.select_horizontal:replace(function()
              actions.close(prompt_bufnr)
              local path = action_state.get_selected_entry()[1]
              vim.api.nvim_command("split " .. path)
              vim.api.nvim_command("lcd " .. path)
            end)
            actions.select_vertical:replace(function()
              actions.close(prompt_bufnr)
              local path = action_state.get_selected_entry()[1]
              vim.api.nvim_command("vertical split " .. path)
              vim.api.nvim_command("lcd " .. path)
            end)
            actions.select_tab:replace(function()
              actions.close(prompt_bufnr)
              local path = action_state.get_selected_entry()[1]
              vim.api.nvim_command("tabnew")
              vim.api.nvim_command("lcd " .. path)
              vim.api.nvim_command("edit .")
            end)
            map("i", "<tab>", function()
              actions.close(prompt_bufnr)
              local path = action_state.get_selected_entry()[1]
              project_files(path)
            end)
            return true
          end,
          -- previewer = previewers.vim_buffer_cat.new(opts),
          sorter = conf.generic_sorter(opts),
        }):find()
      end

      function terminal_buffers()
        -- Load builtin and configure it
        local builtin = require('telescope.builtin')
        local opts = {
          sort_lastused = true,
          theme = 'dropdown',
          previewer = true,
          -- your other desired options here
        }

        -- builtin.buffers(opts)
        local pickers = require('telescope.pickers')
        local finders = require('telescope.finders')
        local sorters = require('telescope.sorters')
        local actions = require('telescope.actions')


        local terminal_buffers = vim.tbl_filter(
          function(val)
            return vim.fn.getbufvar(val.bufnr, "&buftype") == "terminal"
          end,
          vim.fn.getbufinfo({ buflisted = 1 })
        )

        local function entry_maker(entry)
          return {
            value = entry.bufnr,
            ordinal = entry.name,
            display = entry.name,
          }
        end



        require("telescope.builtin").buffers({
          prompt_title = 'Terminal Buffers',
          previewer = true,
          results = terminal_buffers,
        })
      end

      noremap("n", "<space>f", require("telescope.builtin").find_files)
      noremap("n", "<space>g", require("telescope.builtin").live_grep)
      noremap("n", "<space>r", require("telescope.builtin").resume)
      noremap("n", "<space>o", require("telescope.builtin").oldfiles)
      noremap("n", "<space>b", require("telescope.builtin").buffers)
      noremap("n", "<space>c", require("telescope.builtin").colorscheme)
      noremap("n", "<space>ic", require("telescope.builtin").git_commits)
      noremap("n", "<space>ib", require("telescope.builtin").git_branches)
      noremap("n", "<space>is", require("telescope.builtin").git_status)
      noremap("n", "<space>ih", require("telescope.builtin").git_stash)
      noremap("n", "<space>ii", require("telescope").extensions.gh.issues)
      noremap("n", "<space>ia", function() require("telescope").extensions.gh.issues({ assignee = "jasonwoodland" }) end)
      noremap("n", "<space>ip", require("telescope").extensions.gh.pull_request)
      noremap("n", "<space>d", dotfiles)
      noremap("n", "<space>p", projects)
      noremap("n", "<space>t", terminal_buffers)
      noremap("n", "<space>lr", require("telescope.builtin").lsp_references)
      noremap("n", "<space>ld", require("telescope.builtin").lsp_definitions)
      noremap("n", "<space>li", require("telescope.builtin").lsp_implementations)
      noremap("n", "<space>ls", require("telescope.builtin").lsp_document_symbols)
      noremap("n", "<space>lt", require("telescope.builtin").lsp_type_definitions)
      noremap("n", "<space>lw", require("telescope.builtin").lsp_dynamic_workspace_symbols)
    end
  },
  { "nvim-telescope/telescope-github.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "cljoly/telescope-repo.nvim" },
}
