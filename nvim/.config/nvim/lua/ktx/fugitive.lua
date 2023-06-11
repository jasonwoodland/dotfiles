local M = {}

function M.toggle_git()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    if string.match(name, "%.git//") then
      vim.api.nvim_buf_delete(buf, {force = true})
      return
    end
  end
  vim.cmd("Git")
end

return M
