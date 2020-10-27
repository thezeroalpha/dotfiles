let s:fo_table = {
      \ 't': "Auto-wrap using textwidth",
      \ 'c': "Auto-wrap comments using textwidth (insert comment automatically)",
      \ 'r': "Automatically insert comment leader on <enter> (insert mode)",
      \ 'o': "Automatically insert comment leader on 'o' or 'O' (normal mode)",
      \ 'q': "Allow 'gq'",
      \ 'w': "Trailing white space indicates a paragraph continues in the next line.",
      \ 'a': "Automatically format paragraphs while typing (with 'c' only comments)",
      \ 'n': "Recognise text with 'formatlistpat' when formatting (e.g. list)",
      \ '2': "When formatting text, use the indent of the second line of a paragraph for the rest of the paragraph",
      \ 'v': "Only break a line at a blank that you have entered during the current insert command.",
      \ 'b': "Like 'v', but only auto-wrap if you enter a blank at or before the wrap margin.",
      \ 'l': "Don't auto-break lines over 'textwidth' in insert mode",
      \ 'm': "Also break at a multibyte character above 255",
      \ 'M': "When joining lines, don't insert a space before or after a multibyte character.  Overrules the 'B' flag.",
      \ 'B': "When joining lines, don't insert a space between two multibyte characters.  Overruled by the 'M' flag.",
      \ '1': "Don't break a line after a one-letter word.",
      \ ']': "Respect textwidth rigorously.",
      \ 'j': "Remove comment leader when joining lines.",
      \ 'p': "Don't break lines at single spaces that follow periods."
      \ }

function! explain_fopt#ExplainFopt()
  echohl Function | echo '= Current options: =' | echohl None
  let current_opts = split(&l:formatoptions, '\zs')
  for an_opt in current_opts
    echo '- '.an_opt.': '.s:fo_table[an_opt]
  endfor
endfunction
