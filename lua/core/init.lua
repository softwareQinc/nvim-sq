--[[
Initializing core functionality:
    Generic Lua functions
    Options
    Keymaps
    Auto commands
    Misc.
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

------------------------------------------------------------------------------
-- Misc.

-- Enable Hardtime.nvim hardtime mode at startup if `state.hardtime_enabled`
-- is true
-- To modify the `state.hardtime_enabled` flag, edit its table entry in
-- "lua/core/state.lua"
-- See the `M.hardtime` table in "lua/core/keymaps.lua" for keymaps/settings
local state = require("core.state")
if state.hardtime_enabled then
   vim.o.showmode = false
   vim.cmd("Hardtime enable")
end
