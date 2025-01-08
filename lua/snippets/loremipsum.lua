-- Lorem Ipsum templates

local ls = require("luasnip")

local s = ls.snippet
local f = ls.function_node

local function wrap_text(text)
   local lines = {}
   local textwidth = vim.api.nvim_get_option("textwidth")

   if textwidth == 0 then
      textwidth = 80 -- default fallback text width
   end

   local current_line = ""
   for word in text:gmatch("%S+") do
      if #current_line + #word + 1 > textwidth then
         table.insert(lines, current_line)
         current_line = word
      else
         current_line = current_line
            .. (current_line == "" and "" or " ")
            .. word
      end
   end
   if current_line ~= "" then
      table.insert(lines, current_line)
   end

   return lines
end

local sentence_text =
   "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
local paragraph_text =
   "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

-- Lorem Ipsum sentence
ls.add_snippets("all", {
   s({
      trig = "lorem",
      name = "Lorem Ipsum sentence",
      dscr = "Insert Lorem Ipsum sentence",
   }, {
      f(function()
         return wrap_text(sentence_text)
      end),
   }),
})

-- Lorem Ipsum paragraph
ls.add_snippets("all", {
   s({
      trig = "loremp",
      name = "Lorem Ipsum paragraph",
      dscr = "Insert Lorem Ipsum paragraph",
   }, {
      f(function()
         return wrap_text(paragraph_text)
      end),
   }),
})
