return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		vim.opt.termguicolors = true
		require("colorizer").setup({
			-- empty disabled by default
		})
		vim.keymap.set("n", "<leader>cz", function()
			vim.cmd("ColorizerToggle")
			print(":ColorizerToggle")
		end, { desc = "Toggle colorizer" })
	end,
}
