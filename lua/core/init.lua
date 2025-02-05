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
local state = require("core.state")
local ui = require("core.ui")

-- Enable Hardtime.nvim hardtime mode at startup if
-- `state.hardtime_enabled_at_startup` is true
-- To modify the `state.hardtime_enabled_at_startup` flag, edit its table
-- entry in "lua/core/state.lua"
-- See the `M.hardtime` table in "lua/core/keymaps.lua" for keymaps/settings
if state.hardtime_enabled_at_startup then
   vim.opt.showmode = false
   vim.cmd("Hardtime enable")
end

-- Enable transparent background at startup if
-- `state.transparent_background_enabled_at_startup` is true
-- To modify the `state.transparent_background_enabled_at_startup` flag, edit
-- its table entry in "lua/core/state.lua"
-- See the `M.generic` table in "lua/core/keymaps.lua" for keymaps/settings
if state.transparent_background_enabled_at_startup then
   vim.defer_fn(function()
      ui.set_transparent_background()
   end, 1)
end
