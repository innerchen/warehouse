
set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "Monokai"

hi Normal       ctermfg=none    ctermbg=none

hi CursorLine   ctermfg=none    ctermbg=none    cterm=none
hi ColorColumn  ctermfg=none    ctermbg=8       cterm=none
hi SignColumn   ctermfg=none    ctermbg=none    cterm=none
hi Directory    ctermfg=6       ctermbg=none    cterm=none
hi DiffAdd      ctermfg=2       ctermbg=none    cterm=none
hi DiffChange   ctermfg=3       ctermbg=none    cterm=none
hi DiffDelete   ctermfg=1       ctermbg=none    cterm=none
hi DiffText     ctermfg=3       ctermbg=none    cterm=none
hi ErrorMsg     ctermfg=1       ctermbg=none    cterm=none
hi VertSplit    ctermfg=8       ctermbg=none    cterm=none
hi Folded       ctermfg=7       ctermbg=none    cterm=none
hi FoldColumn   ctermfg=7       ctermbg=8       cterm=none
hi IncSearch    ctermfg=15      ctermbg=3       cterm=none
hi LineNr       ctermfg=7       ctermbg=8       cterm=none
hi MatchParen   ctermfg=none    ctermbg=none    cterm=underline
hi ModeMsg      ctermfg=none    ctermbg=none    cterm=none
hi MoreMsg      ctermfg=4       ctermbg=none    cterm=none
hi NonText      ctermfg=8       ctermbg=none    cterm=none
hi Pmenu        ctermfg=none    ctermbg=8       cterm=none
hi PmenuSel     ctermfg=none    ctermbg=none    cterm=none
hi PmenuSbar    ctermfg=none    ctermbg=none    cterm=none
hi PmenuThumb   ctermfg=none    ctermbg=none    cterm=none
hi Question     ctermfg=2       ctermbg=none    cterm=none
hi Search       ctermfg=none    ctermbg=3       cterm=none
hi SpecialKey   ctermfg=8       ctermbg=none    cterm=none
hi StatusLine   ctermfg=none    ctermbg=8       cterm=none
hi StatusLineNC ctermfg=7       ctermbg=8       cterm=none
hi TabLine      ctermfg=7       ctermbg=8       cterm=none
hi TabLineFill  ctermfg=none    ctermbg=8       cterm=none
hi TabLineSel   ctermfg=none    ctermbg=8       cterm=none
hi Title        ctermfg=12      ctermbg=none    cterm=none
hi Visual       ctermfg=none    ctermbg=8       cterm=none
hi WarningMsg   ctermfg=1       ctermbg=none    cterm=none
hi SpellCap     ctermfg=11      ctermbg=none    cterm=none
hi SpellBad     ctermfg=1       ctermbg=none    cterm=none


" Plugin specific highlight groups
hi MyTagListFileName ctermfg=11 ctermbg=none cterm=none

hi Foreground ctermfg=none cterm=none

" Color groups
hi Red     ctermfg=1    cterm=none
hi Green   ctermfg=2    cterm=none
hi Yellow  ctermfg=3    cterm=none
hi Purple  ctermfg=5    cterm=none
hi Blue    ctermfg=6    cterm=none
hi BlueU   ctermfg=6    cterm=underline
hi Grey    ctermfg=7    cterm=none
hi Orange  ctermfg=11   cterm=none

" Syntax highligh groups
hi! link Comment 		Grey
hi! link Constant		Purple
hi! link Special        Purple
hi! link Function 		Blue
hi! link String			Yellow
hi! link Character		Yellow
hi! link Identifier		Green
hi! link Statement		Red
hi! link Operator		Green
hi! link PreProc		Orange
hi! link Include		Red
hi! link Define 		Red
hi! link Macro 			Red
hi! link PreCondit		Red

hi! link Type         Blue
hi! link StorageClass Red

hi! link Tag          Green
hi! link Delimiter    Red

hi! link Underlined   BlueU
hi! link Error        Red
hi! link Todo         Orange

" Language specific highligh groups
" C
hi link cStatement              Green
" C++
hi link cppStatement            Green
" Java
hi link javaStatement           Green

" CSS
hi link cssBraces               Foreground
hi link cssFontProp             Foreground
hi link cssColorProp            Foreground
hi link cssTextProp             Foreground
hi link cssBoxProp              Foreground
hi link cssRenderProp           Foreground
hi link cssAuralProp            Foreground
hi link cssRenderProp           Foreground
hi link cssGeneratedContentProp Foreground
hi link cssPagingProp           Foreground
hi link cssTableProp            Foreground
hi link cssUIProp               Foreground
hi link cssFontDescriptorProp   Foreground
" HTML
hi link htmlTag         Comment
hi link htmlTagName     Conditional
hi link htmlEndTag      Comment
hi link htmlLink        Normal
hi link htmlArg         Green
" CSS/SASS
hi link cssTagName                  Yellow
hi link sassVariable                Green
hi link sassFunction                Red
hi link sassMixing                  Red
hi link sassMixin                   Red
hi link sassExtend                  Red
hi link sassFor                     Red
hi link sassInterpolationDelimiter  Magenta
hi link sassAmpersand               Character
hi link sassId                      Identifier
hi link sassClass                   Type
hi link sassIdChar                  sassId
hi link sassClassChar               sassClass
