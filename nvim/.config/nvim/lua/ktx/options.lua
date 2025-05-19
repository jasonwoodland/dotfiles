vim.g.user = "Jason Woodland"
vim.g.email = "me@jasonwoodland.com"

vim.opt.timeout = false

vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.virtualedit = "block"

vim.opt.number = true
vim.opt.signcolumn = "yes"

vim.opt.shiftwidth = 2

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wildignore = { ".DS_Store" }
vim.opt.wildignorecase = true

vim.opt.completeopt = { "menuone", "noinsert", "popup", "fuzzy" }
vim.opt.completefuzzycollect = { "keyword" }

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

vim.opt.mousescroll = "ver:1,hor:0"
vim.cmd([[aunmenu PopUp.How-to\ disable\ mouse]])
vim.cmd([[aunmenu PopUp.-1-]])

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

vim.opt.clipboard = "unnamed"

vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"

vim.opt.conceallevel = 0
vim.opt.concealcursor = ""

vim.opt.guicursor:append({ "a:blinkoff530-blinkon530" })

vim.opt.title = true

-- vim.cmd("autocmd BufEnter * set formatoptions-=o")

-- vim.api.nvim_create_augroup("FormatOptions", {})
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = "*",
-- 	group = "FormatOptions",
-- 	callback = function()
-- 		vim.opt.formatoptions:remove("o")
-- 	end,
-- })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = "*",
	callback = function()
		local buftype = vim.bo.buftype
		if buftype == "terminal" or buftype == "quickfix" then
			vim.opt_local.scrolloff = 0
		else
			vim.opt_local.scrolloff = tonumber(vim.opt.scrolloff)
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = "*",
	callback = function()
		vim.cmd("checktime")
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = "*",
	callback = function()
		local cwd = vim.fn.getcwd()
		vim.cmd("silent! loadview")
		vim.cmd("lcd " .. cwd)
	end,
})
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
	pattern = "*",
	callback = function()
		vim.cmd("silent! mkview")
	end,
})

-- enable markdown folding
vim.g.markdown_folding = 1

vim.opt.foldlevel = 99
