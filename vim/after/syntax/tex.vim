syn region texString start="``" end="''"
syn region texString start="`" end="'"
syn match texHttpUrl "http[[:fname:]:]*\ze[^[:fname:]]" contains=@NoSpell keepend
syn match texCmdResult nextgroup=texFileArg skipwhite skipnl "\\result\(tab\)\?"
hi def link texCmdResult texCmd
