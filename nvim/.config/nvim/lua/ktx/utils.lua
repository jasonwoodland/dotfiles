local M = {}

function M.alias(lhs, rhs)
	vim.keymap.set("c", lhs, function()
		if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == lhs then
			return rhs
		end
		return lhs
	end, { expr = true })
end

return M
