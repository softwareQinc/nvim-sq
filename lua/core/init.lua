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
-- TODO: Eventually get rid of defer_fn() if possible
if state.hardtime_enabled_at_startup then
   vim.defer_fn(function()
      vim.cmd("Hardtime enable")
   end, 1000)
else
   vim.defer_fn(function()
      vim.cmd("Hardtime disable")
   end, 1000)
end

-- Enable transparent background at startup if
-- `state.background_transparency_enabled_at_startup` is true
-- Not enabled in Neovide sessions
-- To modify the `state.background_transparency_enabled_at_startup` flag, edit
-- its table entry in "lua/core/state.lua"
-- See the `M.background_transparency` table in "lua/core/keymaps.lua" for
-- keymaps/settings
if not vim.g.neovide then
   util.map_keys(keymaps.background_transparency)
   if state.background_transparency_enabled_at_startup then
      vim.defer_fn(function()
         ui.set_background_transparency()
      end, 1)
   end
end
