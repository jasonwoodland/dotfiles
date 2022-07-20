local lspkind = require("lspkind")
local cmp = require("cmp")
local mapping = require("cmp.config.mapping")
local types = require("cmp.types")
local luasnip = require("luasnip")

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
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-Space>"] = cmp.mapping.complete(),

		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif cmp.visible() then
				cmp.confirm({
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
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "cmp_git" },
		{ name = "path" },
		{
			name = "buffer",
			option = {
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
			},
		}),
	},
	experimental = {
		-- native_menu = true,
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
})

-- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' }
--   }
-- })

-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })
