local M = {}

function M.dotfiles()
  require('telescope.builtin').find_files {
    cwd = '~/github.com/jasonwoodland/dotfiles',
    hidden = true,
  }
end

return M
