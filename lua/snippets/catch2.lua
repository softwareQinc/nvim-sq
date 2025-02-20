-- Catch2 templates

local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Catch2 unit test source file template
ls.add_snippets("cpp", {
   s({
      trig = "catch2_template_src",
      name = "Catch2 unit test source file template",
      dscr = "Catch2 unit test source file template, where TEST_CASE() {...} blocks must be located",
   }, {
      t({ "// #include <system_headers>", "", "" }),
      t({ "#include <catch2/catch_all.hpp>", "", "" }),
      t({ '// #include "other_headers"', "", "" }),
      t({ 'TEST_CASE("' }),
      i(1, "Test name"),
      t({ '", "[' }),
      i(2, "tag"),
      t({ ']") {', "" }),
      t({ "    // testing code here", "" }),
      t({ "    REQUIRE(42 == 42);", "" }),
      t("}"),
   }),
})
