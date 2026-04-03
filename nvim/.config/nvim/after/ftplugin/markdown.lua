vim.keymap.set("i", "<CR>", function()
	return vim.fn.getline("."):match("^%s*-%s%[%s%]") and "<CR>[ ] " or "<CR>"
end, { buffer = true, expr = true })

vim.keymap.set("n", "cx", function()
	local line = vim.api.nvim_get_current_line()
	local new_line = line

	if line:match("^%s*-%s%[%s%]") then
		new_line = line:gsub("^(%s*-%s%[)%s(%])", "%1x%2", 1)
	elseif line:match("^%s*-%s%[x%]") then
		new_line = line:gsub("^(%s*-%s%[)x(%])", "%1 %2", 1)
	end

	if new_line ~= line then
		vim.api.nvim_set_current_line(new_line)
	end
end, { buffer = true, desc = "Toggle Checkbox" })

vim.cmd([[
	syntax enable

	syntax match markdownCheckboxDone /^\s*- \[x\] .*$/
	highlight markdownCheckboxDone gui=strikethrough cterm=strikethrough
]])
