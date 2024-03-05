------------------------------------------------------------------------------
-- Neovide-only config

-- Increase/decrease font size
local keymap_font_increase = "<D-=>" -- <D> is the Apple key on Apple keyboards
local keymap_font_decrease = "<D-->"
local increment = 0.1
local decrement = -increment
local modes = { "n", "i", "v" }
for _, mode in ipairs(modes) do
   local pre = ""
   local post = ""
   local cmd_font_increase = ":lua require('neovide.util').neovide_scale(" .. increment .. ")<CR>"
   local cmd_font_decrease = ":lua require('neovide.util').neovide_scale(" .. decrement .. ")<CR>"
   if mode == "i" then
      pre = "<C-o>"
   elseif mode == "v" then
      pre = "<ESC>"
      post = "gv"
   end
   cmd_font_increase = pre .. cmd_font_increase .. post
   cmd_font_decrease = pre .. cmd_font_decrease .. post
   vim.api.nvim_set_keymap(mode, keymap_font_increase, cmd_font_increase, { noremap = true, silent = true })
   vim.api.nvim_set_keymap(mode, keymap_font_decrease, cmd_font_decrease, { noremap = true, silent = true })
end

-- Disable cursor trailing
-- vim.g.neovide_cursor_trail_length = 0
-- Disable cursor animation
-- vim.g.neovide_cursor_animation_length = 0

-- Set the current working directory to the home folder
vim.cmd("cd $HOME")

-- Set the custom font in Neovide
vim.cmd("set guifont=JetBrainsMono\\ Nerd\\ Font:h16")
