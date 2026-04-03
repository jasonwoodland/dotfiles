return {
	{
		"stevearc/oil.nvim",
		config = function()
			local all_columns = false
			local signcolumn = true
			require("oil").setup({
				default_file_explorer = true,
				buf_options = {
					-- number = false,
				},
				columns = {
					"icon",
				},
				keymaps = {
					["gd"] = {
						"<cmd>edit ~/Developer/github.com/jasonwoodland/dotfiles/<CR>",
						desc = "Jump to dotfiles",
					},
					["gf"] = {
						function()
							require("telescope.builtin").find_files({
								cwd = require("oil").get_current_dir(),
							})
						end,
						mode = "n",
						nowait = true,
						desc = "Find files in the current directory",
					},
					["gx"] = {
						function()
							os.execute('open "' .. require("oil").get_current_dir() .. '"')
						end,
						mode = "n",
						nowait = true,
						desc = "Reveal current directory in Finder",
					},
					["gh"] = { "<cmd>edit $HOME<CR>", desc = "Jump to home" },
					["gl"] = {
						function()
							all_columns = not all_columns
							require("oil").set_columns(
								all_columns and
								{ "icon", "permissions", "size", "mtime" } or { "icon" }
							)
						end,
						desc = "Toggle long format",
					},
					["gS"] = {
						function()
							signcolumn = not signcolumn
							vim.wo.signcolumn = signcolumn and "yes:2" or "no"
						end,
						desc = "Toggle signcolumn",
					},
					["gy"] = {
						function()
							local oil = require("oil")
							local entry = oil.get_cursor_entry()
							local dir = oil.get_current_dir()
							if not entry or not dir then
								return
							end
							local path = vim.fn.fnamemodify(dir .. entry.name, ":.")
							local reg = vim.v.register
							vim.fn.setreg(reg, path)
						end,
						mode = "n",
						desc = "Yank pathname of entry under cursor",
					},
					["gY"] = {
						function()
							local oil = require("oil")
							local entry = oil.get_cursor_entry()
							local dir = oil.get_current_dir()
							if not entry or not dir then
								return
							end
							local path = vim.fn.fnamemodify(dir .. entry.name, ":p")
							local reg = vim.v.register
							vim.fn.setreg(reg, path)
						end,
						mode = "n",
						desc = "Yank absolute pathname of entry under cursor",
					},
				},
				delete_to_trash = true,
				skip_confirm_for_simple_edits = true,
				experimental_watch_for_changes = true,
				watch_for_changes = true,
				lsp_file_methods = {
					-- autosave_changes = "unmodified",
					autosave_changes = true,
				},
				constrain_cursor = "name",
				win_options = {
					signcolumn = "yes:2",
				},
			})

			vim.api.nvim_create_augroup("MyOil", {})
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				pattern = { "oil://*/", "oil-ssh://*/", "oil-trash://*/" },
				group = "MyOil",
				callback = function()
					vim.opt_local.number = false
				end,
			})
		end,
	},
	{
		"refractalize/oil-git-status.nvim",
		dependencies = {
			"stevearc/oil.nvim",
		},
		config = true,
	},
}
