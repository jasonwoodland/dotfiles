local lspconfig = require("lspconfig")
local rt = require("rust-tools")

lspconfig.sourcekit.setup {}

local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

function LspRenameFile()
	local curName = vim.fn.expand("%")
	local newName = vim.fn.input("New Filename: ", curName)
	if newName == "" then
		return
	end
	vim.lsp.util.rename(curName, newName)
end

local on_attach = function(server_name)
	return function(client, bufnr)
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
		vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
		vim.keymap.set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
		vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
		vim.keymap.set('n', '<leader>A', rt.hover_actions.hover_actions, bufopts)
		vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)
		vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)

		vim.keymap.set('n', '<leader>rf', LspRenameFile, bufopts)
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
		vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, bufopts)

		-- client.server_capabilities.documentFormattingProvider = false
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format()
			end,
		})
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			on_attach = on_attach(server_name),
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" }
					}
				},
			}
		})
	end,
	["html"] = function()
		-- TODO: won't preserveNewLines
		-- lspconfig.html.setup({
		-- 	-- on_attach = on_attach(server_name),
		-- 	-- capabilities = capabilities,
		-- 	settings = {
		-- 		html = {
		-- 			format = {
		-- 				enable = false
		-- 			}
		-- 		}
		-- 	}
		-- })
	end
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	underline = true,
	virtual_text = false,
	-- virtual_text = {
	-- 	prefix = "▪", -- Could be '●', '▎', 'x'
	-- 	spacing = 1,
	-- },
	signs = true,
	update_in_insert = false,
})

local log = require("vim.lsp.log")
local util = require("vim.lsp.util")

-- override builtin location_handler and don't open the quickfix list
-- https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/handlers.lua#L273
local function location_handler(_, result, ctx, config)
	if result == nil or vim.tbl_isempty(result) then
		local _ = log.info() and log.info(ctx.method, "No location found")
		return nil
	end
	local client = vim.lsp.get_client_by_id(ctx.client_id)

	config = config or {}

	-- textDocument/definition can return Location or Location[]
	-- https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_definition

	if vim.tbl_islist(result) then
		util.jump_to_location(result[1], client.offset_encoding, config.reuse_win)

		if #result > 1 then
			vim.fn.setqflist({}, " ", {
				title = "LSP locations",
				items = util.locations_to_items(result, client.offset_encoding),
			})
			-- api.nvim_command('botright copen')
		end
	else
		util.jump_to_location(result, client.offset_encoding, config.reuse_win)
	end
end

vim.lsp.handlers["textDocument/declaration"] = location_handler
vim.lsp.handlers["textDocument/definition"] = location_handler
vim.lsp.handlers["textDocument/typeDefinition"] = location_handler
vim.lsp.handlers["textDocument/implementation"] = location_handler
vim.lsp.handlers["textDocument/references"] = location_handler

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.fixjson,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.rustfmt,
	},
	on_attach = on_attach,
	capabilities = capabilities
})

rt.setup({
	server = {
		on_attach = on_attach,
		capabilities = capabilities
	}
})
