local lspkind = require("lspkind")
local cmp = require("cmp")
local cmp_buffer = require("cmp_buffer")
local mapping = require("cmp.config.mapping")
local types = require("cmp.types")
local luasnip = require("luasnip")

lspkind.init({
	symbol_map = {
		Copilot = "",
	},
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

require("copilot").setup()
require("copilot_cmp").setup({
	-- method = "getPanelCompletions",
	formatters = {
		preview = require("copilot_cmp.format").deindent,
	}
})

local press = function(key)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
	-- Always preselect first option
	preselect = cmp.PreselectMode.Item,
	completion = {
		completeopt = "menu,menuone,noselect",
	},

	mapping = {
		["<C-n>"] = mapping(mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }), { "i", "c" }),
		["<C-p>"] = mapping(mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }), { "i", "c" }),
		["<C-y>"] = mapping.confirm({ select = false }),
		["<C-e>"] = mapping.abort(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm { select = false },
		["<Right>"] = cmp.mapping.confirm { select = true },

		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif cmp.visible() then
				cmp.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				})
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "copilot", group_index = 1 },
		{ name = "nvim_lsp", group_index = 1 },
		{ name = "nvim_lua", group_index = 1 },
		{ name = "cmp_git", group_index = 1 },
		{ name = "path", group_index = 1 },
		{ name = "luasnip", group_index = 1 },
		{
			name = "buffer",
			group_index = 2,
			option = {
				keyword_length = 3,
				get_bufnrs = function()
					local bufs = {}
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						bufs[vim.api.nvim_win_get_buf(win)] = true
					end
					return vim.tbl_keys(bufs)
				end,
			},
		},
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		-- compltion = cmp.config.window.bordered({
		-- 	winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
		-- }),
		-- documentation = cmp.config.window.bordered({
		-- 	winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None'
		-- }),
	},
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			menu = {
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				ultisnips = "[UltiSnips]",
				luasnip = "[LuaSnip]",
				vsnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
				gh_issues = "[Issue]",
				copilot = "[Copilot]",
			},
		}),
	},
	experimental = {
		ghost_text = true,
	},
	view = {
		-- entries = "native",
	},
})
-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
	sorting = {
		comparators = {
			function(...) return cmp_buffer:compare_locality(...) end,
			-- The rest of your comparators...
		}
	}
})
