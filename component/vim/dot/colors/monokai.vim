
set background=dark
highlight clear

if exists("syntax_on")
    syntax reset
endif

set t_Co=256
let g:colors_name = "monokai"

hi Normal       ctermfg=none    ctermbg=none    cterm=none
hi LineNr       ctermfg=7       ctermbg=0       cterm=none
hi SignColumn   ctermfg=none    ctermbg=none    cterm=none
hi CursorLine   ctermfg=none    ctermbg=none    cterm=none
hi CursorLineNr ctermfg=208     ctermbg=none    cterm=none
hi Folded       ctermfg=7       ctermbg=none    cterm=none
hi FoldColumn   ctermfg=7       ctermbg=none    cterm=none
hi Visual       ctermfg=none    ctermbg=0       cterm=none
hi NonText      ctermfg=0       ctermbg=none    cterm=none
hi VertSplit    ctermfg=0       ctermbg=none    cterm=none

hi Pmenu        ctermfg=none    ctermbg=0       cterm=none
hi PmenuSel     ctermfg=none    ctermbg=none    cterm=none
hi PmenuSbar    ctermfg=none    ctermbg=none    cterm=none
hi PmenuThumb   ctermfg=none    ctermbg=none    cterm=none

hi MatchParen   ctermfg=1       ctermbg=none    cterm=underline
hi Search       ctermfg=none    ctermbg=0       cterm=none
hi IncSearch    ctermfg=16      ctermbg=3       cterm=none

hi ERROR        ctermfg=16      ctermbg=1       cterm=none
hi TODO         ctermfg=16      ctermbg=3       cterm=none
hi ErrorMsg     ctermfg=1       ctermbg=none    cterm=none

hi ColorRed     ctermfg=1       ctermbg=none    cterm=none
hi ColorGreen   ctermfg=2       ctermbg=none    cterm=none
hi ColorYellow  ctermfg=3       ctermbg=none    cterm=none
hi ColorBlue    ctermfg=4       ctermbg=none    cterm=none
hi ColorMagenta ctermfg=5       ctermbg=none    cterm=none
hi ColorCyan    ctermfg=6       ctermbg=none    cterm=none
hi ColorGrey    ctermfg=7       ctermbg=none    cterm=none
hi ColorOrange  ctermfg=208     ctermbg=none    cterm=none

hi! link    Comment     ColorGrey
hi! link    Constant    ColorMagenta
hi! link    String      ColorYellow
hi! link    Identifier  ColorGreen
hi! link    Statement   ColorRed
hi! link    PreProc     ColorRed
hi! link    Type        ColorCyan
hi! link    Special     ColorMagenta
