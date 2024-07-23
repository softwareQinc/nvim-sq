--[[
Initializing core functionality:
    Lua functions
    Vim options
    Keymaps
    Auto commands
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
