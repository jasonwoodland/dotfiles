local M = {}

function M.alias(lhs, rhs)
  vim.cmd(
    string.format(
      'cnoreabbrev <expr> %s (getcmdtype() == ":" && getcmdline() =~ "^%s$") ? "%s" : "%s"',
      lhs,
      lhs,
      rhs,
      lhs
    )
  )
end

return M
