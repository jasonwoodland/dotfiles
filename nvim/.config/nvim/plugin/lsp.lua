local lsp_zero = require("lsp-zero")

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {},
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
		lua_ls = function()
			require("lspconfig").lua_ls.setup(lsp_zero.nvim_lua_ls())
		end,
	},
})

local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities =
    vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

local function configure_diagnostics()
	vim.diagnostic.config({
		underline = true,
		severity_sort = true,
		virtual_text = {
			prefix = "",
			virt_text_pos = "eol_right_align",
			spacing = 0,
			format = function(diag)
				local signs = {
					"",
					"",
					"",
					"󰌵",
				}
				return string.format("%s %s ", signs[diag.severity], diag.message)
			end,
		},
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.INFO] = "",
				[vim.diagnostic.severity.HINT] = "󰌵",
			},
		},
		update_in_insert = false,
	})

	local namespace = vim.api.nvim_create_namespace("FullLineDiagnostics")

	vim.api.nvim_create_autocmd("DiagnosticChanged", {
		callback = function(args)
			local bufnr = args.buf
			vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)

			for _, diagnostic in ipairs(vim.diagnostic.get(bufnr)) do
				local hl_group = ({
					[vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
					[vim.diagnostic.severity.WARN] = "DiagnosticLineWarn",
					[vim.diagnostic.severity.INFO] = "DiagnosticLineInfo",
					[vim.diagnostic.severity.HINT] = "DiagnosticLineHint",
				})[diagnostic.severity]

				-- Highlights the *entire* screen line, like cursorline
				vim.api.nvim_buf_add_highlight(bufnr, namespace, hl_group, diagnostic.lnum, 0, -1)
			end
		end,
	})
end

local lspconfig = require("lspconfig")

lspconfig.ts_ls.setup({
	on_attach = lspconfig_defaults.on_attach,
	capabilities = lspconfig_defaults.capabilities,
	init_options = {
		plugins = { -- I think this was my breakthrough that made it work
			{
				name = "@vue/typescript-plugin",
				location =
				"/Users/jason/.nvm/versions/node/v22.11.0/lib/node_modules/@vue/language-server",
				languages = { "vue" },
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

lspconfig.volar.setup({})

vim.lsp.config["kotlin_language_server"] = {
	-- Command and arguments to start the server.
	cmd = { "kotlin-language-server -jvm-target 17" },
}

lspconfig.kotlin_language_server.setup({
	on_attach = lspconfig_defaults.on_attach,
	capabilities = lspconfig_defaults.capabilities,
})

vim.api.nvim_create_autocmd({ "LspAttach" }, {
	callback = function(args)
		local opts = { buffer = args.buf }
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end

		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)

		vim.keymap.set("i", "<C-s>", function()
			vim.lsp.buf.signature_help({
				-- border = "single",
			})
		end, opts)

		vim.keymap.set("n", "gs", function()
			vim.lsp.buf.signature_help({
				-- border = "single",
			})
		end, opts)

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({
				-- border = "single",
			})
		end, opts)

		vim.keymap.set({ "n", "x" }, "grq", function()
			vim.lsp.buf.format({ async = true })
		end, opts)

		vim.keymap.set("n", "gx", "<cmd>Browse<CR>", { noremap = true })

		configure_diagnostics()

		if client:supports_method("textDocument/completion") then
			local chars = {}
			for i = 32, 126 do
				table.insert(chars, string.char(i))
			end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end

		if client:supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({
						bufnr = args.buf,
						id = client.id,
						filter = function(c)
							return c.name ~= "ts_ls"
						end,
						timeout_ms = 2000,
					})
				end,
			})
		end
	end,
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		-- clang
		null_ls.builtins.formatting.clang_format,
		-- lua
		null_ls.builtins.formatting.stylua,
		-- kotlin
		-- null_ls.builtins.diagnostics.ktlint,
		-- null_ls.builtins.formatting.ktlint,
		-- go
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.golines,
		-- typescript
		null_ls.builtins.formatting.prettierd,
		require("none-ls.code_actions.eslint_d"),
		require("none-ls.diagnostics.eslint_d"),
		require("none-ls.formatting.eslint_d"),
		-- python
		null_ls.builtins.diagnostics.pylint,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.blackd,
	},
})

-- local cmp = require("cmp")

-- require("ktx.snippet").register_cmp_source()

-- local confirm = function(entry)
-- 	local behavior = cmp.ConfirmBehavior.Replace
-- 	if entry then
-- 		local completion_item = entry.completion_item
-- 		local newText = ""
-- 		if completion_item.textEdit then
-- 			newText = completion_item.textEdit.newText
-- 		elseif type(completion_item.insertText) == "string" and completion_item.insertText ~= "" then
-- 			newText = completion_item.insertText
-- 		else
-- 			newText = completion_item.word or completion_item.label or ""
-- 		end

-- 		-- How many characters will be different after the cursor position if we
-- 		-- replace?
-- 		local diff_after = math.max(0, entry.replace_range["end"].character + 1) - entry.context.cursor.col

-- 		-- Does the text that will be replaced after the cursor match the suffix
-- 		-- of the `newText` to be inserted? If not, we should `Insert` instead.
-- 		if entry.context.cursor_after_line:sub(1, diff_after) ~= newText:sub(-diff_after) then
-- 			behavior = cmp.ConfirmBehavior.Insert
-- 		end
-- 	end
-- 	cmp.confirm({ select = true, behavior = behavior })
-- end

-- cmp.setup({
-- 	sources = {
-- 		{ name = "nvim_lsp" },
-- 		{ name = "snp" },
-- 	},
-- 	snippet = {
-- 		expand = function(args)
-- 			vim.snippet.expand(args.body)
-- 		end,
-- 	},
-- 	mapping = cmp.mapping.preset.insert({
-- 		["<C-u>"] = cmp.mapping.scroll_docs(-4),
-- 		["<C-d>"] = cmp.mapping.scroll_docs(4),

-- 		["<C-y>"] = cmp.mapping(function(fallback)
-- 			if cmp.visible() then
-- 				local entry = cmp.get_selected_entry()
-- 				confirm(entry)
-- 			else
-- 				fallback()
-- 			end
-- 		end, { "i", "s" }),
-- 	}),
-- 	completion = {
-- 		-- completeopt = "menu,menuone,preview",

-- 		completeopt = "menu,menuone,noinsert",
-- 	},
-- })

local function get_hl(name)
	local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
	return {
		fg = hl.fg and string.format("#%06x", hl.fg) or nil,
		bg = hl.bg and string.format("#%06x", hl.bg) or nil,
	}
end

local function blend_colors(color1, color2, alpha)
	local blend_channel = function(c1, c2)
		return math.floor(c1 * (1 - alpha) + c2 * alpha)
	end

	return {
		blend_channel(color1[1], color2[1]),
		blend_channel(color1[2], color2[2]),
		blend_channel(color1[3], color2[3]),
	}
end

local function hex_to_rgb(hex)
	return { tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16) }
end

local function rgb_to_hex(rgb)
	return string.format("#%02x%02x%02x", rgb[1], rgb[2], rgb[3])
end

local function setup_virtual_text()
	local normal = get_hl("Normal")
	local normalBgRgb = hex_to_rgb(normal.bg)

	local function shade_virtual_text(severity)
		local hl = get_hl("Diagnostic" .. severity)
		local fgRgb = hex_to_rgb(hl.fg)
		local blendedRgb = blend_colors(fgRgb, normalBgRgb, 0.9)
		local blendedHex = rgb_to_hex(blendedRgb)
		vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. severity, {})
		vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. severity, { fg = hl.fg, bg = blendedHex })
		vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. severity, { undercurl = true, sp = hl.fg })
		blendedRgb = blend_colors(fgRgb, normalBgRgb, 0.95)
		blendedHex = rgb_to_hex(blendedRgb)
		-- vim.api.nvim_set_hl(0, "DiagnosticLine" .. severity, { bg = blendedHex })
	end

	shade_virtual_text("Error")
	shade_virtual_text("Warn")
	shade_virtual_text("Info")
	shade_virtual_text("Hint")
	shade_virtual_text("Ok")
end

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		configure_diagnostics()
		setup_virtual_text()
	end,
})

setup_virtual_text()
