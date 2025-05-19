vim.keymap.set("n", "Q", "<nop>")

-- Mappings for when we're rolling on a mac keyboard
-- We usually use <C-PageUp>/<C-PageDown> on hhkb but it't not ergonomic on the mac
vim.keymap.set("n", "<C-S-L>", "<C-PageUp>")
vim.keymap.set("n", "<C-S-.>", "<C-PageDown>")
vim.keymap.set("n", "<C-S->>", "<C-PageDown>")
vim.keymap.set("t", "<C-S-L>", "<C-\\><C-n><C-PageUp>") -- Quick tab switching when in terminal mode
vim.keymap.set("t", "<C-S-.>", "<C-\\><C-n><C-PageDown>")
vim.keymap.set("t", "<C-S->>", "<C-\\><C-n><C-PageDown>")

vim.keymap.set("n", "<C-S-PageUp>", "<Cmd>-1tabmove<CR>")
vim.keymap.set("n", "<C-S-PageDown>", "<Cmd>+1tabmove<CR>")
vim.keymap.set("t", "<C-S-PageUp>", "<Cmd>-1tabmove<CR>")
vim.keymap.set("t", "<C-S-PageDown>", "<Cmd>+1tabmove<CR>")

vim.keymap.set("o", "i/", "<cmd>normal! T/vt/<CR>", { silent = true })
vim.keymap.set("o", "a/", "<cmd>normal! F/vf/<CR>", { silent = true })
vim.keymap.set("x", "i/", "<cmd>normal! T/vt/<CR>", { silent = true })
vim.keymap.set("x", "a/", "<cmd>normal! F/vf/<CR>", { silent = true })

vim.keymap.set("n", "<leader>vv", '<cmd>exe "edit ".expand("%:h")."/*.vue"<cr>', { silent = true })
vim.keymap.set("n", "<leader>vc", '<cmd>exe "edit ".expand("%:h")."/*.css"<cr>', { silent = true })
vim.keymap.set("n", "<leader>vl", '<cmd>exe "edit ".expand("%:h")."/*.less"<cr>', { silent = true })
vim.keymap.set("n", "<leader>vs", '<cmd>exe "edit ".expand("%:h")."/*.scss"<cr>', { silent = true })
vim.keymap.set("n", "<leader>vh", '<cmd>exe "edit ".expand("%:h")."/*.html"<cr>', { silent = true })

vim.keymap.set("n", "<leader>df", function()
	vim.ui.input({
		prompt = "New Filename: ",
		default = vim.fn.expand("%:h") .. "/",
		completion = "file",
	}, function(fname)
		if fname == nil then
			return
		end
		local reg = vim.fn.getreg('"')
		vim.cmd("%y")
		vim.cmd("edit " .. fname)
		vim.cmd('normal! gg"0dGVp')
		vim.fn.setreg('"', reg)
	end)
end, { silent = true })

vim.keymap.set("n", "<c-cr>", function()
	require("graphql").gql_execute("http://localhost:4000/graphql")
end)
vim.keymap.set("n", "<c-.>", function()
	require("graphql").gql_debug("http://localhost:4000/graphql")
end)
vim.keymap.set("n", "gG", function()
	require("graphql").gql_execute("https://api.cindirect.rcsc.com.au/graphql")
end)

vim.keymap.set("n", "g ", ":Git ")

vim.keymap.set("n", "<leader>co", function()
	if vim.wo.conceallevel == 0 then
		vim.wo.conceallevel = 2
		vim.wo.concealcursor = "nv"
	else
		vim.wo.conceallevel = 0
		vim.wo.concealcursor = ""
	end
end, { silent = true })
vim.keymap.set("n", "yoe", function()
	if vim.wo.linebreak then
		vim.wo.linebreak = false
		print(":setlocal nolinebreak")
	else
		vim.wo.linebreak = true
		print(":setlocal linebreak")
	end
end, { silent = true })

vim.keymap.set("n", "<leader>yf", function()
	local filename = vim.fn.expand("%")
	vim.fn.setreg("*", filename)
	print(filename)
end, { desc = "Yank current file name to system clipboard" })
