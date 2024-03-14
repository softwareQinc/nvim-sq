--[[
Initializing core functionality:
    Auto commands
    Vim options
    Keymaps
    Lua functions
    Neovide
--]]

local keymaps = require("core.keymaps")
local options = require("core.options")
local util = require("core.util")

------------------------------------------------------------------------------
-- Vim auto commands
require("core.autocmds")

------------------------------------------------------------------------------
-- Keymaps
util.map_all_keys(keymaps)

------------------------------------------------------------------------------
-- Vim options
util.set_options(options)
