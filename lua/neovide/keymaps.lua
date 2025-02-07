-- Neovide keymaps

local M = {}

------------------------------------------------------------------------------
-- Scale fonts up and down with <Command>= and <Command>-, respectively
local increment = 0.1
local decrement = -increment
local cmd_font_increase = ":lua require('neovide.util').neovide_scale("
   .. increment
   .. ")<CR>"
local cmd_font_decrease = ":lua require('neovide.util').neovide_scale("
   .. decrement
   .. ")<CR>"
M.scale = {
   n = {
      ["<D-=>"] = {
         cmd_font_increase,
         { desc = "Increase font size" },
      },
      ["<D-->"] = {
         cmd_font_decrease,
         { desc = "Decrease font size" },
      },
   },
   i = {
      ["<D-=>"] = {
         "<C-o>" .. cmd_font_increase,
         { desc = "Increase font size" },
      },
      ["<D-->"] = {
         "<C-o>" .. cmd_font_decrease,
         { desc = "Decrease font size" },
      },
   },
   v = {
      ["<D-=>"] = {
         "<ESC>" .. cmd_font_increase .. "gv",
         { desc = "Increase font size" },
      },
      ["<D-->"] = {
         "<ESC>" .. cmd_font_decrease .. "gv",
         { desc = "Decrease font size" },
      },
   },
}

return M
