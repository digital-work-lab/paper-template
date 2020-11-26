---
title: Manuscript template
author:
  - Gerit Wagner:
      institute:
        - hec
institute:
  - hec:
      name: HEC Montréal
csl: styles/mis-quarterly.csl
link-citations: false
project:
  title: Pandoc Scholar Example
figureTitle: |
  Fig.
figPrefix: "Fig."
bibliography: references.bib
header-includes: |
  \makeatletter
  \def\fps@figure{h}
  \makeatother
---

# Abstract

This is an example article.  There is not much to see but filler text.

[@Webster2002; @Wagner2020]

# Further reading

See the [pandoc manual](http://pandoc.org/MANUAL.html) for more information on
pandoc.

Authors struggling to fill this document with content are referred to
@Webster2002.

![Figure Caption](figure.jpg){#fig:distribution}

[@fig:distribution] illustrates this.

Describe newline best-practice

$$ P_i(x) = \sum_i a_i x^i $$ {#eq:eqn1}

| T1   | T2   | T3   |
| ---- | ---- | ---- |
| C11  | C12  | C13  |
| C21  | C22  | C23  |
| C31  | C32  | C33  |

: Table example {#tbl:table1}

[comment]: # (This actually is the most platform independent comment)

# Section

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.


# References
