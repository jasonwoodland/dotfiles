local M = {}

local global_snippets = {}

local js_snippets = {
	{ trigger = "l",  body = "console.log($0);" },
	{ trigger = "ll", body = "console.log(\"${1}\", $1);" },
	{ trigger = "e",  body = "console.error($0);" },
	{ trigger = "t",  body = "try {\n  $1\n} catch (err) {\n  console.error(err);\n}" }
}

local snippets_by_filetype = {
	lua = {
		{ trigger = 'fn', body = 'function ${1:name}(${2:args}) $0 end' }
	},
	javascript = js_snippets,
	typescript = js_snippets,
	javascriptreact = js_snippets,
	typescriptreact = js_snippets,
}

local function get_buf_snips()
	local ft = vim.bo.filetype
	local snips = vim.list_slice(global_snippets)

	if ft and snippets_by_filetype[ft] then
		vim.list_extend(snips, snippets_by_filetype[ft])
	end

	return snips
end

-- cmp source for snippets to show up in completion menu
function M.register_cmp_source()
	local cmp_source = {}
	local cache = {}
	function cmp_source.complete(_, _, callback)
		local bufnr = vim.api.nvim_get_current_buf()
		if not cache[bufnr] then
			local completion_items = vim.tbl_map(function(s)
				---@type lsp.CompletionItem
				local item = {
					word = s.trigger,
					label = s.trigger,
					kind = vim.lsp.protocol.CompletionItemKind.Snippet,
					insertText = s.fn and s.fn() or s.body,
					insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
				}
				return item
			end, get_buf_snips())

			cache[bufnr] = completion_items
		end

		callback(cache[bufnr])
	end

	require('cmp').register_source('snp', cmp_source)
end

return M
