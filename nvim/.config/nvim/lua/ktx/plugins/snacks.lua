return {
	"folke/snacks.nvim",
	enabled = false,
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		picker = {
			enabled = true,
			previewers = {
				file = {
					max_size = 100 * 1024, -- skip previewing files > 100KB
				},
			},
			win = {
				input = {
					keys = {
						["<C-.>"] = { "toggle_hidden", mode = { "i", "n" } },
						["<C-,>"] = { "toggle_ignored", mode = { "i", "n" } },
					},
				},
			},
		},
	},
	keys = {
		-- Files & Search
		{
			"<space>f",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<space>g",
			function()
				Snacks.picker.grep()
			end,
			desc = "Live Grep",
		},
		{
			"<space>r",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<space>o",
			function()
				Snacks.picker.recent()
			end,
			desc = "Old Files",
		},
		{
			"<space>b",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<space>c",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Colorschemes",
		},
		{
			"<space>n",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},

		-- Git
		{
			"<space>ic",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Commits",
		},
		{
			"<space>ib",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<space>is",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<space>ih",
			function()
				Snacks.picker.git_stash()
			end,
			desc = "Git Stash",
		},

		-- GitHub
		{
			"<space>ii",
			function()
				Snacks.picker.pick("gh_issue")
			end,
			desc = "GitHub Issues",
		},
		{
			"<space>ia",
			function()
				Snacks.picker.pick("gh_issue", { args = { "--assignee", "jasonwoodland" } })
			end,
			desc = "GitHub Issues (Assigned)",
		},
		{
			"<space>ip",
			function()
				Snacks.picker.pick("gh_pr")
			end,
			desc = "GitHub PRs",
		},

		-- Dotfiles
		{
			"<space>d",
			function()
				Snacks.picker.files({
					cwd = "~/Developer/github.com/jasonwoodland/dotfiles",
					hidden = true,
					title = "Dotfiles",
				})
			end,
			desc = "Dotfiles",
		},

		-- Projects
		{
			"<space>p",
			function()
				local handle = io.popen(
				"ls -1d ~/Developer/*/*/*/ ~/Developer/*/jasonwoodland/dotfiles/*/ 2>/dev/null")
				if not handle then
					return
				end
				local result = handle:read("a")
				handle:close()

				local items = {}
				for i, path in ipairs(vim.split(result, "\n", { trimempty = true })) do
					table.insert(items, { idx = i, text = path, file = path })
				end

				Snacks.picker.pick({
					title = "Projects",
					items = items,
					confirm = function(picker, item)
						picker:close()
						if item then
							vim.cmd("silent! lcd " .. item.text)
							vim.cmd("edit .")
						end
					end,
					actions = {
						project_split = function(picker)
							local item = picker:current()
							if item then
								picker:close()
								vim.cmd("split " .. item.text)
								vim.cmd("lcd " .. item.text)
							end
						end,
						project_vsplit = function(picker)
							local item = picker:current()
							if item then
								picker:close()
								vim.cmd("vertical split " .. item.text)
								vim.cmd("lcd " .. item.text)
							end
						end,
						project_tab = function(picker)
							local item = picker:current()
							if item then
								picker:close()
								vim.cmd("tabnew")
								vim.cmd("lcd " .. item.text)
								vim.cmd("edit .")
							end
						end,
						browse_files = function(picker)
							local item = picker:current()
							if item then
								picker:close()
								Snacks.picker.files({ cwd = item.text })
							end
						end,
					},
					win = {
						input = {
							keys = {
								["<C-s>"] = { "project_split", mode = { "i", "n" }, desc = "Open in split" },
								["<C-v>"] = { "project_vsplit", mode = { "i", "n" }, desc = "Open in vsplit" },
								["<C-t>"] = { "project_tab", mode = { "i", "n" }, desc = "Open in tab" },
								["<Tab>"] = { "browse_files", mode = { "i", "n" }, desc = "Browse files" },
							},
						},
					},
				})
			end,
			desc = "Projects",
		},

		-- Terminal Buffers
		{
			"<space>t",
			function()
				Snacks.picker.buffers({
					title = "Terminal Buffers",
					transform = function(item)
						if not item.buf or vim.bo[item.buf].buftype ~= "terminal" then
							return false
						end
					end,
				})
			end,
			desc = "Terminal Buffers",
		},

		-- LSP
		{
			"<space>lr",
			function()
				Snacks.picker.lsp_references()
			end,
			desc = "LSP References",
		},
		{
			"<space>ld",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "LSP Definitions",
		},
		{
			"<space>li",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "LSP Implementations",
		},
		{
			"<space>ls",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "Document Symbols",
		},
		{
			"<space>lt",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Type Definitions",
		},
		{
			"<space>lw",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "Workspace Symbols",
		},
	},
}
