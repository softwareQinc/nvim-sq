--[[
Initializing core functionality:
    Auto commands
    Vim options
    Keymaps
    Lua functions
    Neovide
]]

local util = require("core.util")

------------------------------------------------------------------------------
-- Vim options
local options = require("core.options")
util.set_options(options)

------------------------------------------------------------------------------
-- Keymaps
local keymaps = require("core.keymaps")
util.map_all_keys(keymaps)

------------------------------------------------------------------------------
-- Vim auto commands
require("core.autocmds")
