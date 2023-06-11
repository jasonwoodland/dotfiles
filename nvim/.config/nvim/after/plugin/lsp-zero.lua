local ok, lsp = pcall(require, "lsp-zero")
if not ok then
  return
end

lsp.preset({
  name = "minimal",
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true,
  sign_icons = {
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
  },
})

-- -- (Optional) Configure lua language server for neovim
-- lsp.nvim_workspace()

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
    insert_text = require("copilot_cmp.format").remove_existing,
  },
})

lsp.setup_nvim_cmp({
  preselect = cmp.PreselectMode.Item,
  completion = {
    completeopt = "menu,menuone,noinsert,noselect",
  },
  mapping = {
    ["<C-n>"] = mapping(mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }), { "i", "c" }),
    ["<C-p>"] = mapping(mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }), { "i", "c" }),
    ["<C-y>"] = mapping.confirm({ select = false }),
    ["<C-e>"] = mapping.abort(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ["<Right>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
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
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "copilot",  group_index = 2 },
    { name = "nvim_lsp", group_index = 2 },
    { name = "nvim_lua", group_index = 2 },
    { name = "cmp_git",  group_index = 2 },
    { name = "path",     group_index = 2 },
    { name = "luasnip",  group_index = 2 },
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

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
  -- this filter doesnt seem to work, so lets get null-ls to handle formatting on save for all lsps
  -- lsp.buffer_autoformat(
  --   client,
  --   bufnr,
  --   {
  --     filter = function(c) return c.name ~= "tsserver" end
  --   }
  -- )
end)

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

lsp.setup()

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    -- null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.prettierd
    -- null_ls.builtins.formatting.fixjson,
    -- null_ls.builtins.formatting.prettier_d_slim,
    -- null_ls.builtins.diagnostics.eslint_d,
    -- null_ls.builtins.formatting.eslint_d,
    -- null_ls.builtins.formatting.prettier,
    -- null_ls.builtins.formatting.rustfmt,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(c)
              return c.name ~= "tsserver"
            end
          })
        end,
      })
    end
  end,
})

-- require("mason-null-ls").setup({
--   automatic_setup = true,
-- })
