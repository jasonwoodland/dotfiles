vim.g.user = vim.env.FULL_NAME
vim.g.email = vim.env.EMAIL

-- timeout
vim.opt.timeout = false

-- linebreak
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.wrap = false

-- visual
vim.opt.virtualedit = "block"

-- number
vim.opt.number = true
vim.opt.signcolumn = "yes"

-- indent
vim.opt.shiftwidth = 2

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- wildignore
vim.opt.wildignore = { ".DS_Store" }
vim.opt.wildignorecase = true

-- complete
vim.opt.completeopt = { "menuone", "noinsert", "popup", "fuzzy" }
vim.opt.wildoptions:append({ "fuzzy" })

-- scroll
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

-- mouse
vim.opt.mousescroll = "ver:1,hor:0"
vim.cmd([[aunmenu PopUp.How-to\ disable\ mouse]])
vim.cmd([[aunmenu PopUp.-2-]])

-- view
vim.opt.jumpoptions:append({ "view" })
vim.opt.viewoptions:remove("curdir")

-- window
vim.opt.splitbelow = true
vim.opt.splitright = true

-- modeline
vim.opt.modeline = true
vim.opt.exrc = true

-- backup
vim.opt.backup = true
vim.opt.backupdir:remove(".")
vim.opt.undofile = true

-- shada
vim.opt.shada:append({ "/1000", ":1000" })

-- grep
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"

-- conceal
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""

-- cursor
vim.opt.guicursor:append({ "a:blinkoff530-blinkon530" })

-- title
vim.opt.title = true

-- fold
vim.opt.foldlevel = 99
vim.g.markdown_folding = 1
