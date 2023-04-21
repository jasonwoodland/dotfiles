local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true,
  sign_icons = {
    error = "",
    warn = "",
    hint = "",
    info = "",
  }
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

local cmp = require("cmp")
local mapping = require("cmp.config.mapping")
local types = require("cmp.types")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})
require("copilot_cmp").setup({
  -- method = "getPanelCompletions",
  formatters = {
    preview = require("copilot_cmp.format").deindent,
  }
})

lsp.setup_nvim_cmp({
  preselect = cmp.PreselectMode.Item,
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect'
  },
  mapping = {
    ["<C-n>"] = mapping(mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }), { "i", "c" }),
    ["<C-p>"] = mapping(mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }), { "i", "c" }),
    ["<C-y>"] = mapping.confirm({ select = false }),
    ["<C-e>"] = mapping.abort(),
    ["<C-b>"] = cmp.mapping.scroll_docs( -4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ["<Right>"] = cmp.mapping.confirm { select = true },

    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      -- local copilot_keys = vim.fn["copilot#Accept"]()
      -- if copilot_keys ~= "" then
      --   vim.api.nvim_feedkeys(copilot_keys, "i", true)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif cmp.visible() then
        cmp.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        })
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable( -1) then
        luasnip.jump( -1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "copilot",  group_index = 2 },
    { name = "nvim_lsp", group_index = 1 },
    { name = "nvim_lua", group_index = 1 },
    { name = "cmp_git",  group_index = 1 },
    { name = "path",     group_index = 1 },
    { name = "luasnip",  group_index = 1 },
    {
      name = "buffer",
      group_index = 2,
      option = {
        keyword_length = 3,
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
    },
  },
  formatting = {
    format = lspkind.cmp_format({
      menu = {
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        ultisnips = "[UltiSnips]",
        luasnip = "[LuaSnip]",
        vsnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
        gh_issues = "[Issue]",
        copilot = "[Copilot]",
      },
    }),
  },
  experimental = {
    ghost_text = true,
  },
})

lsp.setup()
