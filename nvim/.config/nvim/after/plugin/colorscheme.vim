set termguicolors

let g:nvcode_termcolors=256
colorscheme onedark

set pumblend=10
set winblend=10

" Fix yellow underline in vue templates
function! ClearTSStrike(timer)
  hi clear TSStrike
endfunction
call timer_start(500, "ClearTSStrike")

hi clear Error
hi link Error ErrorMsg

hi clear MoreMsg " Used by coc-list prompt
hi clear EndOfBuffer
hi link EndOfBuffer NonText

hi clear Search
hi link Search Visual
hi clear IncSearch
hi link IncSearch lCursor

hi Comment guifg=#7A859B gui=italic
hi clear Folded
hi Folded guifg=#7A859B
hi clear FoldColumn
hi link FoldColumn Folded
hi clear MatchParen
hi link MatchParen Visual

hi clear CocMenuSel
hi link CocMenuSel CursorLine
hi clear QuickFixLine
hi link QuickFixLine CursorLine

hi clear CocListMode
hi clear CocListPath
hi link CocListMode StatusLine
hi link CocListPath StatusLine

" slightly darker blue background
hi NvimTreeNormal guibg=#212530
hi NvimTreeEndOfBuffer guifg=#212530 guibg=#212530
hi NvimTreeVertSplit guifg=bg guibg=bg
hi Normal guibg=#272b38
hi PanelNormal guibg=#21252e
" autocmd FileType list,qf set winhighlight=Normal:PanelNormal
autocmd FileType list,qf,help set signcolumn=auto

hi clear Cursor
hi link Cursor lCursor

hi clear VertSplit
hi VertSplit guifg=#22262d

hi SignColumn guibg=none
hi clear DiffChange
hi link DiffChange LineNr
hi DiffAdd cterm=none gui=none guifg=none guibg=#2d3828
hi DiffDelete cterm=none gui=none guifg=#bf383a guibg=none

hi CocGitAddedSign guifg=#98c379
hi CocGitRemovedSign guifg=#be5046
hi link CocGitTopRemovedSign CocGitRemovedSign

hi Pmenu guibg=#212530
hi clear PmenuSel
hi link PmenuSel Visual
hi clear PmenuSbar
hi PmenuSbar guibg=#212530
hi PmenuThumb guibg=#3B4154

hi StatusLine guibg=#212530
hi StatusLineNC guifg=#7A859B guibg=#212530
hi TabLineFill guibg=#212530
hi TabLine guibg=#212530
hi TabLineNC guibg=#212530
hi TabLineSel guibg=none

hi clear SpecialKey " fixed unreadable diggraphs output
hi Special gui=none
hi link SpecialKey Special

hi link TermCursorNC Visual
hi TermCursor guifg=#828aa8
hi link netrwTreeBar LineNr

hi link Space Search
match Space /\s\+$/

hi clear TelescopeBorder
hi TelescopeBorder guifg=#7A859B guibg=#212530
hi TelescopeNormal guibg=#212530
hi TelescopePreviewNormal guibg=#212530

hi link CmpItemAbbrMatch Special
hi link CmpItemAbbrMatchFuzzy Special
hi link CmpItemKind Question
hi link CmpItemMenu LineNr
hi link CmpItemMenuSbar PmenuSbar
hi link CmpItemMenuThumb PmenuThumb

hi clear DiagnosticError
hi link DiagnosticError Error

hi DiagnosticUnderlineError gui=undercurl guisp=#be5046
hi DiagnosticUnderlineWarn gui=undercurl
hi DiagnosticUnderlineInfo gui=undercurl
hi DiagnosticUnderlineHint gui=undercurl

hi link netrwTreeBar LineNr

hi link GitSignsCurrentLineBlame LineNr

" nvcode-color-schemes remove ugly magenta
hi clear TSNamespace
