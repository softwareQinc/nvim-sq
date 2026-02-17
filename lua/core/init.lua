--[[
Initializing core functionality:
    Generic Lua functions
    Options
    Keymaps
    Auto commands
    Miscellaneous
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
-- Miscellaneous
local state = require("core.state")

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

-- Sets the keymap for enabling a transparent background. This is enabled if
-- the `state.background_transparency_enabled_at_startup` flag is true.
-- This keymap is not enabled in Neovide sessions.
-- To modify the `state.background_transparency_enabled_at_startup` flag, edit
-- its table entry in `lua/core/state.lua`.
-- See the `M.background_transparency` table in `lua/core/keymaps.lua` for
-- keymaps/settings.
if not vim.g.neovide then
   util.map_keys(keymaps.background_transparency)
   -- Hack to make the `nvim-colorizer` plugin attach to buffer when opening a
   -- file from the command line
   vim.defer_fn(function()
      vim.cmd.colorscheme(vim.g.colors_name)
   end, 1)
end
