return {
	{
		"f-person/auto-dark-mode.nvim",
		opts = {
			{
				update_interval = 2000,
				set_dark_mode = function()
					vim.api.nvim_set_option_value("background", "dark", {})
					vim.cmd("colorscheme gruvbox")
				end,
				set_light_mode = function()
					vim.api.nvim_set_option_value("background", "light", {})
					vim.cmd("colorscheme gruvbox")
				end,
			},
		},
	},
	{ "lunacookies/vim-colors-xcode" },
	{
		"jackplus-xyz/binary.nvim",
		opts = {
			colors = {
				fg = "#000000",
				bg = "#ffffff",
			},
			reversed_group = {
				StatusLine = true,
			},
		},
	},
	{
		"jasonwoodland/gruvbox",
		config = function()
			-- Set options
			-- vim.opt.termguicolors = true
			vim.opt.pumblend = 10
			vim.opt.winblend = 10

			-- Execute Vimscript command
			-- vim.api.nvim_exec("colorscheme gruvbox", false)

			-- Set global variables
			vim.g.gruvbox_contrast_dark = "medium"
			vim.g.gruvbox_contrast_light = "hard"
			vim.g.gruvbox_sign_column = "bg0"
			vim.g.gruvbox_invert_selection = 0

			local function GruvboxHighlights()
				-- Execute Vimscript commands inside Lua function
				vim.cmd([[
				  hi clear QuickFixLine
				  hi link QuickFixLine CursorLine
				  hi clear NormalFloat
				  " hi link NormalFloat Pmenu
				  hi link NormalFloat Normal
				  hi link FloatBorder GruvboxBg4

				  hi! link @variable Identifier
				  hi! link Delimiter GruvboxOrange

				  hi link TermCursorNC multiple_cursors_visual

				  hi clear Tabline
				  hi clear TablineSel
				  hi link Tabline StatusLineNC
				  hi link TablineSel StatusLine
				  hi clear Title

				  hi clear WinBar
				  hi clear WinBarNC
				  hi link WinBar Tabline
				  hi link WinBarNC Tabline
				  hi link WinBarActive TablineSel


				  hi clear ModeMsg
				  hi clear MoreMsg
				  hi clear WarningMsg
				  hi clear Question

				  hi link TelescopeBorder FloatBorder

				  hi clear TelescopeResultsDiffAdd
				  hi clear TelescopeResultsDiffChange
				  hi clear TelescopeResultsDiffDelete
				  hi link TelescopeResultsDiffAdd GruvboxGreen
				  hi link TelescopeResultsDiffChange GruvboxBg2
				  hi link TelescopeResultsDiffDelete GruvboxRed

				  hi DiagnosticUnderlineError gui=undercurl
				  hi DiagnosticUnderlineWarn gui=undercurl
				  hi DiagnosticUnderlineInfo gui=undercurl
				  hi DiagnosticUnderlineHint gui=undercurl

				  hi clear DiagnosticError
				  hi clear DiagnosticWarn
				  hi clear DiagnosticInfo
				  hi clear DiagnosticHint
				  hi link DiagnosticError GruvboxRed
				  hi link DiagnosticWarn GruvboxOrange
				  hi link DiagnosticInfo GruvboxBlue
				  hi link DiagnosticHint GruvboxFg1

				  hi clear Search
				  hi clear IncSearch
				  hi clear CurSearch
				  hi link Search multiple_cursors_visual
				  hi link IncSearch Visual
				  hi link CurSearch Visual

				  hi clear CursorLineNr
				  hi link CursorLineNr StatusLineNC

				  hi clear WinSeparator
				  hi link WinSeparator VertSplit

				  " hi DiffAdd gui=none
				  " hi DiffChange gui=none
				  " hi DiffDelete gui=none
				  " hi DiffText gui=none
				  hi clear DiffAdd
				  hi clear DiffChange
				  hi clear DiffText
				  hi clear DiffDelete
				  hi DiffAdd guibg=#313228
				  hi DiffChange guibg=#313228
				  hi DiffText guibg=#515227
				  hi DiffDelete guibg=#362a29 guifg=#362a29

				  hi Comment gui=italic

				  hi clear GitSignsAdd
				  hi clear GitSignChange
				  hi clear GitSignsDelete
				  hi link GitSignsAdd GruvboxGreenSign
				  hi link GitSignsChange GruvboxGray
				  hi link GitSignsDelete GruvboxRedSign
				]])

				if vim.o.background == "light" then
					vim.cmd([[
					  hi Normal guibg=#ffffff
					  hi SignColumn guibg=#ffffff
					  hi GruvboxGreenSign guibg=#ffffff
					  hi GruvboxRedSign guibg=#ffffff
					  hi clear WinSeparator
					  hi link WinSeparator NonText
					  hi StatusLine guifg=#d3d3d3
					  hi StatusLineNC guifg=#bebebe guibg=#000000
					  hi WinSeparator guifg=#d3d3d3
					  hi NonText guifg=#d3d3d3
					  hi SpecialKey guifg=#d3d3d3
					  hi LineNr guifg=#d3d3d3
					  hi CursorLine guibg=#bebebe
					  hi CursorLineSign guibg=#bebebe
					  hi FloatBorder guifg=#bebebe
					  hi TablineFill guibg=#d3d3d3
					  hi Search guibg=#d3d3d3
					  hi Visual guibg=#bebebe
					]])
					-- Your light background settings
				else
					-- Your dark background settings
				end
			end

			vim.api.nvim_create_augroup("MyColors", { clear = true })
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = "MyColors",
				pattern = "gruvbox",
				callback = GruvboxHighlights,
			})

			-- set colorscheme
			vim.cmd([[
				colorscheme gruvbox
			]])

			GruvboxHighlights()
		end,
	},
}
