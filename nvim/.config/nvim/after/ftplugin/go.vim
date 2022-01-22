setlocal formatprg=goimports tabstop=4
autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
