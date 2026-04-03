return {
	{ "nvim-treesitter/nvim-treesitter" },
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter" },
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{
		"TXPGhost/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				multiline_threshold = 1,
				update_debounce = 100,
			})
			vim.keymap.set("n", "gJ", function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end, { silent = true })
		end,
	},
}
