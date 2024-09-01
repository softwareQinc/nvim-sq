-- LaTeX templates

local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- LaTeX template, article
ls.add_snippets("tex", {
   s({
      trig = "latex_template_article",
      name = "LaTeX minimal template, article",
      dscr = "LaTeX minimal template, article",
   }, {
      t({ "\\documentclass[" }),
      i(1, "12pt"),
      t({ "]{article}", "", "" }),
      t({ "\\usepackage{amsthm}", "" }),
      t({ "\\usepackage{amsmath}", "" }),
      t({ "\\usepackage{amssymb}", "" }),
      t({ "\\usepackage{authblk}", "" }),
      t({ "\\usepackage{graphicx}", "" }),
      t({ "\\usepackage{hyperref}", "" }),
      t({ "\\usepackage{xcolor}", "", "" }),
      t({ "\\newtheorem{theorem}{Theorem}", "", "" }),
      t({ "\\begin{document}", "", "" }),
      t({ "\\date{Date: " }),
      i(2, "\\today"),
      t({ "}", "", "" }),
      t({ "\\author[1]{" }),
      i(3, "Author One"),
      t({ "}", "" }),
      t({ "\\affil[1]{" }),
      i(4, "softwareQ Inc."),
      t({ "}", "", "" }),
      t({ "\\title{" }),
      i(5, "Title"),
      t({ "}", "" }),
      t({ "\\maketitle", "", "" }),
      t({ "\\abstract{Abstract}", "", "" }),
      t({ "\\section{Introduction\\label{sct::intro}}", "" }),
      t({ "Introduction", "", "" }),
      t({ "\\appendix", "", "" }),
      t({ "\\section{First Appendix\\label{apdx::A}}", "" }),
      t({ "Appendix A", "", "" }),
      t({ "\\bibliographystyle{" }),
      i(6, "unsrt"),
      t({ "}", "" }),
      t({ "\\bibliography{" }),
      i(7, "path_to_bibtex_file"),
      t({ "}", "", "" }),
      t({ "\\end{document}" }),
   }),
})
