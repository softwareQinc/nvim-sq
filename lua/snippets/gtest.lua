-- GoogleTest templates

local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- GoogleTest main entry point template
ls.add_snippets("cpp", {
   s({
      trig = "gtest_template_main",
      name = "GoogleTest main entry point template",
      dscr = "GoogleTest main entry point template, where int main() {...} must be located",
   }, {
      t({ "// GoogleTest main entry point", "", "" }),
      t({ '#include "gtest/gtest.h"', "", "" }),
      t({ "int main(int argc, char** argv) {", "" }),
      t({ "    ::testing::InitGoogleTest(&argc, argv);", "" }),
      t({ "    return RUN_ALL_TESTS();", "}" }),
   }),
})

-- GoogleTest unit test source file template
ls.add_snippets("cpp", {
   s({
      trig = "gtest_template_src",
      name = "GoogleTest unit test source file template",
      dscr = "GoogleTest unit test source file template, where TEST() {...} blocks must be located",
   }, {
      t({ "// #include <system_headers>", "", "" }),
      t({ '#include "gtest/gtest.h"', "", "" }),
      t({ '// #include "other_headers"', "", "" }),
      t({ "TEST(" }),
      i(1, "TestName"),
      t({ ", " }),
      i(2, "SubtestName"),
      t({ ") {", "" }),
      t({ "    // testing code here", "" }),
      t({ "    EXPECT_EQ(42, 42);", "}" }),
   }),
})
