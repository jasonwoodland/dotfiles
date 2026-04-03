local view_group = vim.api.nvim_create_augroup("AutoView", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "BufWinEnter" }, {
	group = view_group,
	pattern = "*",
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	group = view_group,
	pattern = "*",
	callback = function()
		vim.cmd("silent! loadview")
	end,
})

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
	group = view_group,
	pattern = "*",
	callback = function()
		vim.cmd("silent! mkview")
	end,
})
