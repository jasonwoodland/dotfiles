local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local action_state = require "telescope.actions.state"

local M = {}

function M.dotfiles()
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
        vim.api.nvim_command("edit " .. path)
        vim.api.nvim_command("cd " .. path)
      end)
      actions.select_horizontal:replace(function()
        actions.close(prompt_bufnr)
        local path = action_state.get_selected_entry()[1]
        vim.api.nvim_command("split " .. path)
        vim.api.nvim_command("cd " .. path)
      end)
      actions.select_vertical:replace(function()
        actions.close(prompt_bufnr)
        local path = action_state.get_selected_entry()[1]
        vim.api.nvim_command("vertical split " .. path)
        vim.api.nvim_command("cd " .. path)
      end)
      return true
    end,
  }
end

function M.projects(opts)
  opts = opts or {}
  vim.fn.jobstart("ls -1d ~/ghq/*/*/*/ ~/ghq/*/*/dotfiles/*/", {
    stdout_buffered = true,
    on_stdout = function(_, data)
      pickers.new(opts, {
        prompt_title = "Projects",
        finder = finders.new_table {
          results = data,
        },
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local path = action_state.get_selected_entry()[1]
            vim.api.nvim_command("edit " .. path)
            vim.api.nvim_command("cd " .. path)
          end)
          actions.select_horizontal:replace(function()
            actions.close(prompt_bufnr)
            local path = action_state.get_selected_entry()[1]
            vim.api.nvim_command("split " .. path)
            vim.api.nvim_command("cd " .. path)
          end)
          actions.select_vertical:replace(function()
            actions.close(prompt_bufnr)
            local path = action_state.get_selected_entry()[1]
            vim.api.nvim_command("vertical split " .. path)
            vim.api.nvim_command("cd " .. path)
          end)
          actions.select_tab:replace(function()
            actions.close(prompt_bufnr)
            local path = action_state.get_selected_entry()[1]
            vim.api.nvim_command("tabedit " .. path)
            vim.api.nvim_command("cd " .. path)
          end)
          map("i", "<tab>", function()
            actions.close(prompt_bufnr)
            local path = action_state.get_selected_entry()[1]
            project_files(path)
          end)
          return true
        end,
        previewer = previewers.vim_buffer_cat.new(opts),
        sorter = conf.generic_sorter(opts),
      }):find()
    end
  })
end

return M
