local M = {}

function M.dotfiles()
  require('telescope.builtin').find_files {
    cwd = '~/ghq/github.com/jasonwoodland/dotfiles',
    hidden = true,
    prompt_title = "Dotfiles"
  }
end

return M
