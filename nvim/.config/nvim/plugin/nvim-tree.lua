require 'nvim-tree'.setup {
  hijack_cursor = true,
  hijack_netrw = false,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  filters = {
    custom = { ".git", ".DS_Store" },
  },
}
