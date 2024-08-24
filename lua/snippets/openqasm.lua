-- OpenQASM templates

local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Minimal OpenQASM 2.0
ls.add_snippets("openqasm", {
   s({
      trig = "qasm2_template",
      name = "OpenQASM 2 template",
      dscr = "OpenQASM 2 simple circuit",
   }, {
      t({ "OPENQASM 2.0;", "" }),
      t({ 'include "qelib1.inc";', "", "" }),
      t({ "qreg q[" }),
      i(1, "2"),
      t({ "];", "" }),
      t({ "creg c[" }),
      i(2, "2"),
      t({ "];", "", "" }),
      t({ "// gates below", "" }),
      t({ "h q[0];", "" }),
      t({ "cx q[0], q[1];", "", "" }),
      t({ "measure q->c;" }),
   }),
})
