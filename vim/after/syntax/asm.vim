" Redefine asm comment highlighting, want <bar> to be interpreted as binop
syn clear asmComment
syn match asmComment "[#;!].*" contains=asmTodo

