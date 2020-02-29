syn match markdownError "\w\@<=\w\@="
syn region markdownMathInline start="\(\\\)\@<!\$\(\$\)\@!" end="\$"
syn region markdownMathBlock start="\$\$" end="\$\$"
hi def link markdownMathInline Special
hi def link markdownMathBlock Special
