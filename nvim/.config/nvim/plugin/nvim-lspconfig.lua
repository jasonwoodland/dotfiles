local nvim_lsp = require("lspconfig")
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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(server)
	return function(client, bufnr)
		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end

		local function buf_set_option(...)
			vim.api.nvim_buf_set_option(bufnr, ...)
		end

		-- Enable completion triggered by <c-x><c-o>
		buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

		-- Mappings.
		local opts = { noremap = true, silent = true }

		-- See `:help vim.lsp.*` for documentation on any of the below functions
		buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
		buf_set_keymap("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
		buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
		buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
		buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
		buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
		buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
		buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
		buf_set_keymap("n", "<leader>rf", "<cmd>lua LspRenameFile()<CR>", opts)
		buf_set_keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
		-- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
		buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
		buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
		buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts)
		buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
		buf_set_keymap("v", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)

		-- if client.supports_method("textDocument/formatting") then
		-- print(vim.inspect(client))
		client.server_capabilities.documentFormattingProvider = false
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			-- on 0.8, you should use vim.lsp.buf.format instead
			callback = function()
				vim.lsp.buf.format({
					-- sync = true,
					-- filter = function(clients)
					-- 	return vim.tbl_filter(function(c)
					-- 		print(c.name)
					-- 		return client.name == "null-ls"
					-- 		-- return client.name ~= "tsserver" and client.name ~= "html" and client.name ~= "null-ls"
					-- 		-- and client.name ~= "volar"
					-- 	end, clients)
					-- end,
				})
			end,
		})
		-- end
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = on_attach(server),
		capabilities = capabilities,
		settings = {
			documentFormatting = true,
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	}

	server:setup(opts)
	vim.cmd([[ do User LspAttachBuffers ]])
end)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
	-- virtual_text = {
	-- 	prefix = "▪", -- Could be '●', '▎', 'x'
	-- 	spacing = 1,
	-- },
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
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.fixjson,
		null_ls.builtins.formatting.prettierd, -- all projects use prettier eslint plugin, so it's unused, but we need it for css/less!
		null_ls.builtins.formatting.eslint_d,
	},
})
