------------------------------------------------------------------------------
-- Neovide additional initialization, executed only by a Neovide session,
-- after all other initializations are performed

local util = require("core.util")

local keymaps = require("neovide.keymaps")
local options = require("neovide.options")

------------------------------------------------------------------------------
-- Neovide additional options
util.set_options(options)

------------------------------------------------------------------------------
-- Scale fonts up/down with <Command>= and <Command>-, respectively
util.map_keys(keymaps.scale, { noremap = true, silent = true })

------------------------------------------------------------------------------
-- Set custom font
vim.cmd("set guifont=JetBrainsMono\\ Nerd\\ Font:h16")

------------------------------------------------------------------------------
-- Set the current working directory to home directory
local home_dir = os.getenv("HOME") or os.getenv("USERPROFILE")
if home_dir then
   vim.cmd("cd " .. home_dir)
end
