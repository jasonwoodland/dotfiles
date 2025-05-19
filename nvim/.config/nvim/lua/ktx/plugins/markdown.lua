return {
	"preservim/vim-markdown",
	dependencies = {
		"godlygeek/tabular",
	},
	config = function()
		vim.g.vim_markdown_no_default_key_mappings = true
	end,
}
