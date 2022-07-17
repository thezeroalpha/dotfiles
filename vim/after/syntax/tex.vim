syn region texString start="``" end="''"
syn region texString start="`" end="'"
syn match texHttpUrl "http[[:fname:]:]*\ze[^[:fname:]]" contains=@NoSpell keepend
