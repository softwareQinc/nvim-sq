--[[
Initializing core functionality:
    Generic Lua functions
    Options
    Keymaps
    Auto commands
]]

------------------------------------------------------------------------------
-- Generic Lua functions
local util = require("core.util")

------------------------------------------------------------------------------
-- Options
local options = require("core.options")
util.set_options(options)

------------------------------------------------------------------------------
-- Keymaps
local keymaps = require("core.keymaps")
util.map_all_keys(keymaps)

------------------------------------------------------------------------------
-- Auto commands
require("core.autocmds")
