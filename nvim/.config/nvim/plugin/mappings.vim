nnoremap <space>f  <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <space>g  <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <space>r  <cmd>lua require('telescope.builtin').resume()<cr>
nnoremap <space>o  <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <space>m  <cmd>lua require('telescope').extensions.frecency.frecency()<cr>
nnoremap <space>ic <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <space>ib <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <space>is <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <space>ih <cmd>lua require('telescope.builtin').git_stash()<cr>
nnoremap <space>ii <cmd>lua require('telescope').extensions.gh.issues()<cr>
nnoremap <space>ia <cmd>lua require('telescope').extensions.gh.issues({ assignee="jasonwoodland" })<cr>
nnoremap <space>ip <cmd>lua require('telescope').extensions.gh.pull_request()<cr>
nnoremap <space>df <cmd>lua require('ktx.telescope').dotfiles()<cr>

nnoremap <space>e <cmd>NvimTreeToggle<cr>

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>
