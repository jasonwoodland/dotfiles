nnoremap <space>f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <space>gg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <space>b <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap <space>r <cmd>lua require('telescope.builtin').resume()<cr>
nnoremap <space>gc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <space>gb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <space>gs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <space>gh <cmd>lua require('telescope.builtin').git_stash()<cr>
nnoremap <space>m <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <space>df <cmd>lua require('ktx.telescope').dotfiles()<cr>
inoremap <c-s> <cmd>lua vim.lsp.buf.signature_help()<cr>
nnoremap <space>e <cmd>NvimTreeToggle<cr>
