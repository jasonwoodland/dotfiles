vim.g.user = "Jason Woodland"
vim.g.email = "me@jasonwoodland.com"

vim.opt.ttimeout = false

vim.opt.breakindent = true
vim.opt.virtualedit = "block"

vim.opt.number = true
vim.opt.signcolumn = "yes"

vim.opt.shiftwidth = 2

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wildignore = { ".DS_Store" }
vim.opt.wildignorecase = true

-- vim.opt.completeopt:append({ "menu", "menuone", "noselect" })

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

-- vim.api.nvim_create_augroup("AutoFormatting", {})
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   group = "AutoFormatting",
--   callback = function()
--     vim.lsp.buf.format({ async = false })
--   end,
-- })

local function noremap(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", { noremap = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

noremap("n", "<space>f", require("telescope.builtin").find_files)
noremap("n", "<space>g", require("telescope.builtin").live_grep)
noremap("n", "<space>r", require("telescope.builtin").resume)
noremap("n", "<space>o", require("telescope.builtin").oldfiles)
noremap("n", "<space>b", require("telescope.builtin").buffers)
noremap("n", "<space>c", require("telescope.builtin").colorscheme)
noremap("n", "<space>ic", require("telescope.builtin").git_commits)
noremap("n", "<space>ib", require("telescope.builtin").git_branches)
noremap("n", "<space>is", require("telescope.builtin").git_status)
noremap("n", "<space>ih", require("telescope.builtin").git_stash)
noremap("n", "<space>ii", require("telescope").extensions.gh.issues)
noremap("n", "<space>ia", function() require("telescope").extensions.gh.issues({ assignee = "jasonwoodland" }) end)
noremap("n", "<space>ip", require("telescope").extensions.gh.pull_request)
noremap("n", "<space>d", require("ktx.telescope").dotfiles)
noremap("n", "<space>p", require("ktx.telescope").projects)
noremap("n", "<space>lr", require("telescope.builtin").lsp_references)
noremap("n", "<space>ld", require("telescope.builtin").lsp_definitions)
noremap("n", "<space>li", require("telescope.builtin").lsp_implementations)
noremap("n", "<space>ls", require("telescope.builtin").lsp_document_symbols)
noremap("n", "<space>lt", require("telescope.builtin").lsp_type_definitions)
noremap("n", "<space>lw", require("telescope.builtin").lsp_dynamic_workspace_symbols)

noremap("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
noremap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
noremap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
noremap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
noremap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")
noremap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>")

noremap("n", "Q", "<nop>")

noremap("o", "i/", "<cmd>normal! T/vt/<CR>", { silent = true })
noremap("o", "a/", "<cmd>normal! F/vf/<CR>", { silent = true })
noremap("x", "i/", "<cmd>normal! T/vt/<CR>", { silent = true })
noremap("x", "a/", "<cmd>normal! F/vf/<CR>", { silent = true })

noremap("n", "<leader>vv", '<cmd>exe "edit ".expand("%:h")."/*.vue"<cr>', { silent = true })
noremap("n", "<leader>vc", '<cmd>exe "edit ".expand("%:h")."/*.css"<cr>', { silent = true })
noremap("n", "<leader>vl", '<cmd>exe "edit ".expand("%:h")."/*.less"<cr>', { silent = true })
noremap("n", "<leader>vs", '<cmd>exe "edit ".expand("%:h")."/*.scss"<cr>', { silent = true })
noremap("n", "<leader>vh", '<cmd>exe "edit ".expand("%:h")."/*.html"<cr>', { silent = true })

noremap("n", "<c-/>", require("ktx.fugitive").toggle_git)

-- noremap('n', '<F3>', '<cmd>SynGroup<CR>')
