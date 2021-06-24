syn match markdownError "\w\@<=\w\@="
syn match markdownCite "\[@\w\+\]" contains=@NoSpell
syn match markdownCiteInline "@\w\+\( \[[^\]]\+\]\)*" contains=@NoSpell
syn match markdownLatex "\\[a-z0-9]\+{\?.*}\?" contains=@NoSpell
syn region markdownMathInline start="\(\\\)\@<!\$\(\$\)\@!" end="\$" contains=@NoSpell
syn region markdownMathBlock start="\$\$" end="\$\$" contains=@NoSpell
syn region markdownComment start="<!--" end="-->" contains=@NoSpell,Todo
syn region markdownAbbrev start="\*\[" end="$"
syn keyword Todo FIXME TODO contained

unlet! b:current_syntax
syntax include @YAML syntax/yaml.vim
" Deciding to only keep yaml blocks at start of buffer, otherwise <hr> would be counted as start of yaml
" syn region markdownYaml matchgroup=SpecialComment keepend start="\(\%^\|^\s*\)---$" end="^\(-\|\.\)\{3\}$" contains=@YAML
syn region markdownYaml matchgroup=SpecialComment keepend start="\%^---$" end="^\(-\|\.\)\{3\}$" contains=@YAML
unlet! b:current_syntax
syntax include @Conf syntax/conf.vim
syn region markdownRust matchgroup=SpecialComment keepend start="\%^+++$" end="^+++$" contains=@Conf
let b:current_syntax = 'markdown'

hi def link markdownMathInline Special
hi def link markdownMathBlock Special
hi def link markdownComment Comment
hi def link markdownYaml SpecialComment
hi def link markdownAbbrev Define
hi def link markdownCite Comment
hi def link markdownCiteInline Comment
hi def link markdownLatex Identifier

if has('conceal')
  setl conceallevel=2 " Use concealchar and highlight with Conceal group
  syn match concealOperator "<=" conceal cchar=≤
  syn match concealOperator ">=" conceal cchar=≥
  syn keyword concealKeyword lambda conceal cchar=λ
  hi! link concealOperator Conceal
  hi! link concealKeyword Conceal
endif
