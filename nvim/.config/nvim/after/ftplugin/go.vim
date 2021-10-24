setlocal formatprg=gofmt tabstop=4
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
