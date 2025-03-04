set background=light
if version > 580
  highlight clear
  if exists("syntax_on")
    syntax reset
  endif
endif
let g:colors_name = "jokull"
"ANSI colors for :terminal
let g:terminal_ansi_colors = ["#eff0f3", "#125394", "#145a9c", "#1562c0", "#2182e1", "#2377e1", "#3c68e6", "#0a0c0f", "#525963", "#125394", "#145a9c", "#1562c0", "#2182e1", "#2377e1", "#3c68e6", "#0a0c0f"]
" Highlight group definitions
hi Normal guifg=#2c2625 guibg=#e4e4e4 ctermfg=0 ctermbg=254 cterm=NONE gui=NONE
hi Keyword guifg=#6e032e guibg=NONE ctermfg=52 ctermbg=NONE cterm=NONE gui=NONE
hi Cursorline guifg=NONE guibg=#d0d0d0 ctermfg=NONE ctermbg=252 cterm=NONE gui=NONE
hi String guifg=#009051 guibg=NONE ctermfg=29 ctermbg=NONE cterm=italic gui=italic
hi Identifier guifg=#112d4e guibg=NONE ctermfg=17 ctermbg=NONE cterm=NONE gui=NONE
hi Function guifg=#0096ff guibg=NONE ctermfg=33 ctermbg=NONE cterm=bold gui=bold
hi Statement guifg=#0050a0 guibg=NONE ctermfg=25 ctermbg=NONE cterm=NONE gui=NONE
hi Include guifg=#005f87 guibg=NONE ctermfg=24 ctermbg=NONE cterm=bold gui=bold
hi Type guifg=#005f87 guibg=NONE ctermfg=24 ctermbg=NONE cterm=NONE gui=NONE
hi Search guifg=NONE guibg=#d7f1e0 ctermfg=NONE ctermbg=194 cterm=NONE gui=NONE
hi Incsearch guifg=NONE guibg=#a7c1a0 ctermfg=NONE ctermbg=145 cterm=bold,underline gui=bold,underline
hi Folded guifg=#0076ff guibg=#d0d0d0 ctermfg=33 ctermbg=252 cterm=NONE gui=NONE
hi Tablinefill guifg=NONE guibg=#d0d0d0 ctermfg=NONE ctermbg=252 cterm=NONE gui=NONE
hi Tablinesel guifg=NONE guibg=#e5e5e5 ctermfg=NONE ctermbg=7 cterm=NONE gui=NONE
hi Wildmenu guifg=#005f87 guibg=#e5e5e5 ctermfg=24 ctermbg=7 cterm=bold gui=bold
hi Linenr guifg=#9b9b4c guibg=NONE ctermfg=101 ctermbg=NONE cterm=NONE gui=NONE
hi Vertsplit guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE cterm=NONE gui=NONE
hi Todo guifg=#0000FF guibg=#FFFF00 ctermfg=21 ctermbg=11 cterm=NONE gui=NONE
hi Nontext guifg=#81A1C1 guibg=NONE ctermfg=109 ctermbg=NONE cterm=NONE gui=NONE
hi StatusLine guifg=#e5e5e5 guibg=#005f87 ctermfg=7 ctermbg=24 cterm=NONE gui=NONE
hi Statuslinenc guifg=#e5e5e5 guibg=#0087af ctermfg=7 ctermbg=31 cterm=NONE gui=NONE
hi StatusLineTermNC guifg=NONE guibg=#99FF77 ctermfg=NONE ctermbg=120 cterm=NONE gui=NONE
hi StatusLineTerm guifg=NONE guibg=#009051 ctermfg=NONE ctermbg=29 cterm=NONE gui=NONE
hi StatusLineFile guifg=#e5e5e5 guibg=#0087af ctermfg=7 ctermbg=31 cterm=NONE gui=NONE
hi StatusLineNormMode guifg=#0087af guibg=#d0d0d0 ctermfg=31 ctermbg=252 cterm=NONE gui=NONE
hi Visual guifg=NONE guibg=#a8caff ctermfg=NONE ctermbg=153 cterm=NONE gui=NONE
hi Title guifg=#225555 guibg=NONE ctermfg=23 ctermbg=NONE cterm=bold gui=bold
hi Matchparen guifg=#007822 guibg=#a8dbfd ctermfg=28 ctermbg=153 cterm=NONE gui=NONE
hi QfFileName guifg=#0076ff guibg=NONE ctermfg=33 ctermbg=NONE cterm=NONE gui=NONE
hi Delimiter guifg=#5f5f00 guibg=NONE ctermfg=58 ctermbg=NONE cterm=NONE gui=NONE
hi Comment guifg=#5f5f5f guibg=NONE ctermfg=59 ctermbg=NONE cterm=italic gui=italic
hi ErrorMsg guifg=#2c2625 guibg=#ffa5a5 ctermfg=0 ctermbg=217 cterm=bold gui=bold
hi Cursorlinenr guifg=#cc6d05 guibg=NONE ctermfg=166 ctermbg=NONE cterm=bold gui=bold
hi SpecialKey guifg=#0000FF guibg=NONE ctermfg=21 ctermbg=NONE cterm=bold gui=bold
hi Constant guifg=#cc6d05 guibg=NONE ctermfg=166 ctermbg=NONE cterm=NONE gui=NONE
hi Diffadd guifg=NONE guibg=#a5ffa5 ctermfg=NONE ctermbg=157 cterm=NONE gui=NONE
hi Diffdelete guifg=NONE guibg=#ffa5a5 ctermfg=NONE ctermbg=217 cterm=NONE gui=NONE
hi Diffchange guifg=#2c2625 guibg=#c0beff ctermfg=0 ctermbg=147 cterm=NONE gui=NONE
hi Difftext guifg=NONE guibg=#a0aeff ctermfg=NONE ctermbg=147 cterm=bold gui=bold
hi GitGutterAdd guifg=#007822 guibg=#e4e4e4 ctermfg=28 ctermbg=254 cterm=NONE gui=NONE
hi GitGutterChange guifg=#8e830e guibg=#e4e4e4 ctermfg=100 ctermbg=254 cterm=NONE gui=NONE
hi GitGutterDelete guifg=#6e032e guibg=#e4e4e4 ctermfg=52 ctermbg=254 cterm=NONE gui=NONE
hi GitGutterChangeDelete guifg=#80537e guibg=#e4e4e4 ctermfg=96 ctermbg=254 cterm=NONE gui=NONE
hi NormalFloat guifg=NONE guibg=#d0d0d0 ctermfg=NONE ctermbg=252 cterm=NONE gui=NONE
hi DapUIDecoration guifg=#a8caff guibg=NONE ctermfg=153 ctermbg=NONE cterm=NONE gui=NONE
hi DapUIScope guifg=#005f87 guibg=NONE ctermfg=24 ctermbg=NONE cterm=NONE gui=NONE
hi DapUIStoppedThread guifg=#005f87 guibg=NONE ctermfg=24 ctermbg=NONE cterm=NONE gui=NONE
hi DapUIBreakpointsPath guifg=#005f87 guibg=NONE ctermfg=24 ctermbg=NONE cterm=NONE gui=NONE
hi DapUIBreakpointsCurrentLine guifg=#009051 guibg=NONE ctermfg=29 ctermbg=NONE cterm=NONE gui=NONE
hi DapUIWatchesEmpty guifg=#6e032e guibg=NONE ctermfg=52 ctermbg=NONE cterm=NONE gui=NONE
hi DapUIModifiedValue guifg=#80537e guibg=NONE ctermfg=96 ctermbg=NONE cterm=NONE gui=NONE
" Link definitions
hi! link tag delimiter
hi! link gh_files_dir function
hi! link conditional statement
hi! link QuickFixLine Cursorline
hi! link netrwexe title
hi! link ALEWarningLine difftext
hi! link signcolumn linenr
hi! link netrwMarkFile incsearch
hi! link pmenusel statusline
hi! link DapUIWatchesValue darkgreen
hi! link ALEError errormsg
hi! link specialcomment delimiter
hi! link DapUIStepOut DapUIScope
hi! link precondit include
hi! link markdowncode type
hi! link DapUIWatchesError DapUIWatchesEmpty
hi! link tabline tablinefill
hi! link DapUIStepBack DapUIScope
hi! link mkdlink type
hi! link netrwdir function
hi! link DapUIStepInto DapUIScope
hi! link DapUIRestart darkgreen
hi! link number delimiter
hi! link typedef structure
hi! link ALEWarning diffchange
hi! link macro include
hi! link modemsg string
hi! link repeat statement
hi! link special delimiter
hi! link operator statement
hi! link specialchar delimiter
hi! link label structure
hi! link ALEErrorLine diffdelete
hi! link DapUIStop DapUIWatchesEmpty
hi! link DapUIPlayPause darkgreen
hi! link spellrare string
hi! link define include
hi! link LspInlayHint Comment
hi! link gitcommitOverflow errormsg
hi! link gitcommitSummary include
hi! link debug delimiter
hi! link MarkviewCode NormalFloat
hi! link structure type
hi! link pmenu statuslinenc
hi! link vimwikilink type
hi! link spelllocal string
hi! link spellcap string
hi! link markdownUrl string
hi! link error errormsg
hi! link preproc include
hi! link MarkviewInlineCode NormalFloat
hi! link storageclass structure
hi! link DapUIStepOver DapUIScope
hi! link spellbad todo
hi! link character constant
" Code to clear any groups that are not defined
let s:DefinedColors=['tag', 'gh_files_dir', 'conditional', 'quickfixline', 'netrwexe', 'alewarningline', 'signcolumn', 'netrwmarkfile', 'pmenusel', 'dapuiwatchesvalue', 'aleerror', 'specialcomment', 'dapuistepout', 'precondit', 'markdowncode', 'dapuiwatcheserror', 'tabline', 'dapuistepback', 'mkdlink', 'netrwdir', 'dapuistepinto', 'dapuirestart', 'number', 'typedef', 'alewarning', 'macro', 'modemsg', 'repeat', 'special', 'operator', 'specialchar', 'label', 'aleerrorline', 'dapuistop', 'dapuiplaypause', 'spellrare', 'define', 'lspinlayhint', 'gitcommitoverflow', 'gitcommitsummary', 'debug', 'markviewcode', 'structure', 'pmenu', 'vimwikilink', 'spelllocal', 'spellcap', 'markdownurl', 'error', 'preproc', 'markviewinlinecode', 'storageclass', 'dapuistepover', 'spellbad', 'character', 'normal', 'keyword', 'cursorline', 'string', 'identifier', 'function', 'statement', 'include', 'type', 'search', 'incsearch', 'folded', 'tablinefill', 'tablinesel', 'wildmenu', 'linenr', 'vertsplit', 'todo', 'nontext', 'statusline', 'statuslinenc', 'statuslinetermnc', 'statuslineterm', 'statuslinefile', 'statuslinenormmode', 'visual', 'title', 'matchparen', 'qffilename', 'delimiter', 'comment', 'errormsg', 'cursorlinenr', 'specialkey', 'constant', 'diffadd', 'diffdelete', 'diffchange', 'difftext', 'gitgutteradd', 'gitgutterchange', 'gitgutterdelete', 'gitgutterchangedelete', 'normalfloat', 'dapuidecoration', 'dapuiscope', 'dapuistoppedthread', 'dapuibreakpointspath', 'dapuibreakpointscurrentline', 'dapuiwatchesempty', 'dapuimodifiedvalue']
function! s:ClearUndefinedColors(colors)
  let undefined_groups = filter(a:colors->keys()->map('tolower(v:val)'), 'index(s:DefinedColors, tolower(v:val)) < 0')
  call map(undefined_groups, "execute('highlight' . ' ' . v:val . ' ' . 'NONE')")
endfunction
function! s:GetHighlights()
  let highlights  = execute('highlight')
  let highlights  = substitute(highlights, '\n\s\+', ' ', 'g')
  let highlights  = split(highlights, '\n')
  call map(highlights, "split(v:val, '\\s\\+xxx\\s\\+')")
  call map(highlights, "[copy(v:val)[0], split(copy(v:val)[1])]")
  return highlights
endfunction
function! s:GetColors()
  let colors = {}
  for [group, values] in <SID>GetHighlights()
    let attributes = {}
    if values[0] ==# 'links'
      let attributes['links'] = values[-1]
    elseif values[0] !=# 'cleared'
      call map(values, "split(v:val, '=')")
      call map(values, "len(v:val) == 2 ? {v:val[0]: v:val[1]} : {v:val[0] : v:val[0]}")
      call map(values, "extend(attributes, v:val)")
    endif
    let colors[group] = attributes
  endfor
  return colors
endfunction
call <SID>ClearUndefinedColors(<SID>GetColors())
