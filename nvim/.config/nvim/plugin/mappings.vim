nnoremap <space>f  <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <space>g  <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <space>r  <cmd>lua require('telescope.builtin').resume()<cr>
nnoremap <space>o  <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <space>ic <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <space>ib <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <space>is <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <space>ih <cmd>lua require('telescope.builtin').git_stash()<cr>
nnoremap <space>ii <cmd>lua require('telescope').extensions.gh.issues()<cr>
nnoremap <space>ia <cmd>lua require('telescope').extensions.gh.issues({ assignee="jasonwoodland" })<cr>
nnoremap <space>ip <cmd>lua require('telescope').extensions.gh.pull_request()<cr>
nnoremap <space>d <cmd>lua require('ktx.telescope').dotfiles()<cr>
nnoremap <space>p <cmd>lua require('ktx.telescope').projects()<cr>

nnoremap <space>e <cmd>NvimTreeToggle<cr>

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

nnoremap Q <nop>

onoremap <silent> i/ <cmd>normal! T/vt/<CR>
onoremap <silent> a/ <cmd>normal! F/vf/<CR>
xnoremap <silent> i/ <cmd>normal! T/vt/<CR>
xnoremap <silent> a/ <cmd>normal! F/vf/<CR>

nnoremap <silent> <leader>vv <cmd>exe 'edit '.expand('%:r').'.vue'<cr>
nnoremap <silent> <leader>vc <cmd>exe 'edit '.expand('%:r').'.css'<cr>
nnoremap <silent> <leader>vl <cmd>exe 'edit '.expand('%:r').'.less'<cr>
nnoremap <silent> <leader>vs <cmd>exe 'edit '.expand('%:r').'.scss'<cr>
nnoremap <silent> <leader>vh <cmd>exe 'edit '.expand('%:r').'.html'<cr>

nnoremap <F3> <cmd>SynGroup<CR>
