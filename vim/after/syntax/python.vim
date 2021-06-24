if has('conceal')
  setl conceallevel=2 " Use concealchar and highlight with Conceal group
  syn match concealOperator "<=" conceal cchar=≤
  syn match concealOperator ">=" conceal cchar=≥
  syn keyword concealKeyword lambda conceal cchar=λ
  hi! link concealOperator Conceal
  hi! link concealKeyword Conceal
endif
