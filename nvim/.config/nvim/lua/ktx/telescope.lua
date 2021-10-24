local M = {}

function M.dotfiles()
  require('telescope.builtin').git_files {
    cwd = '~/.dotfiles',
  }
end

return M
