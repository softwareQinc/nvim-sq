--[[ 
Core functionality: 
    Auto commands 
    Vim options 
    key bindings 
    Lua functions 
    Neovide
--]]

local bindings = require("core.bindings")
local options = require("core.options")
local util = require("core.util")

------------------------------------------------------------------------------
-- Vim auto commands
require("core.autocmds")

------------------------------------------------------------------------------
-- Key bindings
util.map_all_keys(bindings)

------------------------------------------------------------------------------
-- Vim options
util.set_options(options)
