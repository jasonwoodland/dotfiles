return {
  "laytan/cloak.nvim",
  opts = {
    enabled = true,
    cloak_character = "*",
    highlight_group = "NonText",
    patterns = {
      {
        file_pattern = {
          ".env*",
          "*.env",
        },
        cloak_pattern = {
          "(ID=).+",
          "(KEY=).+",
          "(PASSWORD=).+",
          "(SECRET=).+",
          "(TOKEN=).+",
          "(id=).+",
          "(key=).+",
          "(password=).+",
          "(secret=).+",
          "(token=).+",
        },
        replace = "%1",
      },
      {
        file_pattern = {
          ".pgpass*",
        },
        cloak_pattern = {
          "(.*:.*:.*:.*:).+",
        },
        replace = "%1",
      },
    }
  },
  config = function(_, opts)
    require("cloak").setup(opts)
    vim.keymap.set("n", "<leader>cc", function()
      require("cloak").toggle()
    end)
  end,
}
