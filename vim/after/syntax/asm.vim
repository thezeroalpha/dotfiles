" Redefine asm comment highlighting, want <bar> to be interpreted as binop
syn clear asmComment
syn region asmComment		start="/\*" end="\*/" contains=asmTodo
syn region asmComment		start="//" end="$" keepend contains=asmTodo
syn match asmInclude "#include"
syn region asmString start='"' end='"'
hi def link asmString String
