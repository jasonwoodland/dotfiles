setlocal formatprg=gofmt tabstop=4
lua vim.lsp.buf.formatting_sync(nil, 1000)
