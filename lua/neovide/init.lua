------------------------------------------------------------------------------
-- Neovide-only config

-- Scale fonts up/down with <Command>= and <Command>-, respectively
local util = require("core.util")
local bindings = require("neovide.bindings")
util.map_keys(bindings.scale, { noremap = true, silent = true })

-- Disable cursor trailing
-- vim.g.neovide_cursor_trail_length = 0
-- Disable cursor animation
-- vim.g.neovide_cursor_animation_length = 0

-- Set the current working directory to the home folder
vim.cmd("cd $HOME")

-- Set the custom font in Neovide
vim.cmd("set guifont=JetBrainsMono\\ Nerd\\ Font:h16")
