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

function M.projects(opts)
  opts = opts or {}
  local command = "ls -1d ~/ghq/*/*/*/ ~/ghq/*/jasonwoodland/dotfiles/*/"
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
  print(vim.inspect(files))
  pickers.new({
    prompt_title = "Projects",
    finder = finders.new_table {
      results = files,
    },
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local path = action_state.get_selected_entry()[1]
        vim.api.nvim_command("edit " .. path)
        vim.api.nvim_command("lcd " .. path)
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
        vim.api.nvim_command("tabedit " .. path)
        vim.api.nvim_command("lcd " .. path)
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

return M
