local M = {}

function M.dotfiles()
  require('telescope.builtin').find_files {
    cwd = '~/.dotfiles',
    hidden = true,
  }
end

return M
