local lspconfig_defaults = require("lspconfig").util.default_config
return {
	on_attach = lspconfig_defaults.on_attach,
	capabilities = lspconfig_defaults.capabilities,
	-- init_options = {
	-- 	plugins = { -- I think this was my breakthrough that made it work
	-- 		{
	-- 			name = "@vue/typescript-plugin",
	-- 			location = "/Users/jason/.nvm/versions/node/v22.11.0/lib/node_modules/@vue/language-server",
	-- 			languages = { "vue" },
	-- 		},
	-- 	},
	-- },
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}
