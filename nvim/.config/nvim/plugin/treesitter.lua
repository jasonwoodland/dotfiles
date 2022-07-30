require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "c",
    "comment",
    "css",
    "dockerfile",
    "go",
    "graphql",
    "html",
    "http",
    "javascript",
    "json",
    "json5",
    "jsonc",
    "lua",
    "make",
    "python",
    "regex",
    "scss",
    "tsx",
    "typescript",
    "vue",
    "yaml",
  },
  ignore_installing = {
    "vim",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
  context_commentstring = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.comment = {
  used_by = { "js", "ts", "jsx", "tsx", "c", "go", "vue" } -- additional filetypes that use this parser
}
