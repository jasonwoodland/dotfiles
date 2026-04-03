local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local previewers = require("telescope.previewers")

local show_hidden = false
local show_ignore = true

local new_maker = function(filepath, bufnr, opts)
	opts = opts or {}
	filepath = vim.fn.expand(filepath)

	-- Skip previewing files larger than 100 KB
	vim.loop.fs_stat(filepath, function(err, stat)
		if not err and stat and stat.size > 100 * 1024 then
			-- Do not preview the file
			return
		else
			previewers.buffer_previewer_maker(filepath, bufnr, opts)
		end
	end)
end

require("telescope").setup({
	defaults = {
		buffer_previewer_maker = new_maker,
		winblend = 0,
		mappings = {
			i = {
				["<C-a>"] = false,
				["<C-h>"] = "which_key",
				["<esc>"] = "close",
				["<M-p>"] = require("telescope.actions.layout").toggle_preview,
				["<C-.>"] = function(prompt_bufnr)
					show_hidden = not show_hidden
					local prompt = require("telescope.actions.state").get_current_line()
					local picker = action_state.get_current_picker(prompt_bufnr).prompt_title
					require("telescope.actions").close(prompt_bufnr)
					if picker:lower():match("find files") then
						builtin.find_files({ default_text = prompt })
					elseif picker:lower():match("live grep") then
						builtin.live_grep({ default_text = prompt })
					end
				end,
				["<C-,>"] = function(prompt_bufnr)
					show_ignore = not show_ignore
					local prompt = require("telescope.actions.state").get_current_line()
					local picker = action_state.get_current_picker(prompt_bufnr).prompt_title
					require("telescope.actions").close(prompt_bufnr)
					if picker:lower():match("find files") then
						builtin.find_files({ default_text = prompt })
					elseif picker:lower():match("live grep") then
						builtin.live_grep({ default_text = prompt })
					end
				end,
			},
		},
		layout_config = {
			vertical = { width = 0.5 },
		},
	},
	pickers = {
		find_files = {
			find_command = function()
				local args = {
					"rg",
					"--files",
					"--pcre2",
				}
				if show_hidden then
					table.insert(args, "--hidden")
				end
				if show_ignore then
					table.insert(args, "--no-ignore")
					table.insert(args, "--no-ignore-parent")
					table.insert(args, "--ignore-file=.gitignore")
				else
				end
				return args
			end,
		},
		live_grep = {
			additional_args = function()
				local args = {
					"--pcre2",
					"--max-filesize=1M",
				}
				if show_hidden then
					table.insert(args, "--hidden")
				end
				if show_ignore then
					table.insert(args, "--no-ignore")
					table.insert(args, "--no-ignore-parent")
					table.insert(args, "--ignore-file=.gitignore")
				else
				end
				return args
			end,
		},
		colorscheme = {
			enable_preview = true,
		},
	},
})

-- require("telescope").load_extension("fzf")
require("telescope").load_extension("gh")
require("telescope").load_extension("repo")
-- require("telescope").load_extension('harpoon')
