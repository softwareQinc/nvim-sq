-- OpenQASM templates

local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- OpenQASM 2.0 minimal template
ls.add_snippets("openqasm", {
   s({
      trig = "qasm2_template",
      name = "OpenQASM 2 template",
      dscr = "OpenQASM 2 mock circuit",
   }, {
      t({ "OPENQASM 2.0;", "" }),
      t({ 'include "qelib1.inc";', "", "" }),
      t({ "// registers", "" }),
      t({ "qreg q[" }),
      i(1, "2"),
      t({ "];", "" }),
      t({ "creg c[" }),
      i(2, "2"),
      t({ "];", "", "" }),
      t({ "// gates", "" }),
      t({ "h q[0];", "" }),
      t({ "cx q[0], q[1];", "", "" }),
      t({ "// measurements", "" }),
      t({ "measure q->c;" }),
   }),
})
