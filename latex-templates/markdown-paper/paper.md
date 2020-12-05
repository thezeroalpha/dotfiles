---
title: |
    This is a multiline title...
    ...and here's the second line!
subtitle: 'I''ve got a subtitle too.'
author:
- First author
- Second author

fontsize: 12pt

csl: https://raw.githubusercontent.com/citation-style-language/styles/master/apa.csl
bibliography:
- references.bib

link-citations: true

geometry:
- a4paper
- left=1in
- right=1in
- top=1in
- bottom=1in

header-includes:
    \usepackage{fancyhdr}
    \pagestyle{fancyplain}
    \rhead{\textit{Subject}}
---
\maketitle

I can also cite stuff, like this sample 'article' [@author2001].

# References
::: {#refs}
:::
