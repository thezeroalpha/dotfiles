syn match markdownError "\w\@<=\w\@="
syn region markdownMathInline start="\(\\\)\@<!\$\(\$\)\@!" end="\$" contains=@NoSpell
syn region markdownMathBlock start="\$\$" end="\$\$" contains=@NoSpell
syn region markdownComment start="<!--" end="-->" contains=@NoSpell

unlet b:current_syntax
syntax include @YAML syntax/yaml.vim
syn region markdownYaml matchgroup=SpecialComment keepend start="\(\%^\|^\s*\)---$" end="^\(-\|\.\)\{3\}$" contains=@YAML
let b:current_syntax = 'markdown'

hi def link markdownMathInline Special
hi def link markdownMathBlock Special
hi def link markdownComment Comment
hi link markdownYaml SpecialComment
