set termguicolors
set pumblend=10
set winblend=10

" lua require('colorbuddy').colorscheme('onejson')

let g:gruvbox_contrast_dark='medium'
let g:gruvbox_contrast_light='soft'
let g:gruvbox_sign_column='bg0'
let g:gruvbox_invert_selection=0

function! GruvboxHighlights() abort
  hi link TermCursorNC multiple_cursors_visual

  hi clear Tabline
  hi clear TablineSel
  hi link Tabline StatusLineNC
  hi link TablineSel StatusLine
  hi clear Title " fix tabline buffer count

  hi clear ModeMsg
  hi clear MoreMsg
  hi clear WarningMsg
  hi clear Question

  hi link TelescopeBorder GruvboxBg4

  hi clear TelescopeResultsDiffAdd
  hi clear TelescopeResultsDiffChange
  hi clear TelescopeResultsDiffDelete
  hi link TelescopeResultsDiffAdd GruvboxGreen
  hi link TelescopeResultsDiffChange GruvboxBg2
  hi link TelescopeResultsDiffDelete GruvboxRed

  hi DiagnosticUnderlineError gui=undercurl
  hi DiagnosticUnderlineWarn gui=undercurl
  hi DiagnosticUnderlineInfo gui=undercurl
  hi DiagnosticUnderlineHint gui=undercurl

  hi clear DiagnosticError
  hi clear DiagnosticWarn
  hi clear DiagnosticInfo
  hi clear DiagnosticHint
  hi link DiagnosticError GruvboxRed
  hi link DiagnosticWarn GruvboxOrange
  hi link DiagnosticInfo GruvboxBlue
  hi link DiagnosticHint GruvboxFg1

  hi clear Search
  hi clear IncSearch
  hi link Search multiple_cursors_visual
  hi link IncSearch Visual

  hi clear GitGutterChange
  hi clear GitGutterChangeDelete
  hi link GitGutterChange GruvboxBg2
  hi link GitGutterChangeDelete GruvboxBg2

  " if &background == 'light'
  "   call system("kitty @ set-colors /Users/jason/.config/kitty/Gruvbox\ Light.conf")
  " else
  "   call system("kitty @ set-colors /Users/jason/.config/kitty/Gruvbox\ Dark.conf")
  " endif

endfunction

augroup MyColors
  autocmd!
  autocmd ColorScheme gruvbox call GruvboxHighlights()
augroup END

colorscheme gruvbox
