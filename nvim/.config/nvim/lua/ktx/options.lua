vim.g.user = "Jason Woodland"
vim.g.email = "me@jasonwoodland.com"

vim.opt.timeoutlen = 0

vim.opt.breakindent = true
vim.opt.virtualedit = "block"

vim.opt.number = true
vim.opt.signcolumn = "yes"

vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wildignore = { ".DS_Store" }
vim.opt.wildignorecase = true

vim.opt.completeopt:append({ "menu", "menuone", "noselect" })

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

vim.opt.mousescroll = "ver:1,hor:0"

vim.opt.jumpoptions:append({ "view" })

vim.opt.inccommand = "split"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.fillchars:append({ vert = "│" })

vim.opt.wrap = false

vim.opt.modeline = true
vim.opt.exrc = true

-- vim.opt.shortmess:append({'I'})

vim.opt.backup = true
vim.opt.backupdir:remove(".")
vim.opt.undofile = true

vim.opt.shada:append({ "/1000", ":1000" })

vim.opt.clipboard = { "unnamed" }

vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"

vim.opt.title = true
-- vim.opt.titlestring = '%f'

-- vim.cmd("autocmd BufEnter * set formatoptions-=o")

vim.api.nvim_create_augroup("FormatOptions", {})
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  group = "FormatOptions",
  callback = function()
    vim.opt.formatoptions:remove({ "o" })
  end,
})

vim.api.nvim_create_augroup("AutoFormatting", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  group = "AutoFormatting",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
