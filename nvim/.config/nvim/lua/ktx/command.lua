vim.api.nvim_create_user_command("CloseAllFloatingWindows", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative ~= "" then
			vim.api.nvim_win_close(win, true)
		end
	end
end, {})
