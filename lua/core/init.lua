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
util.map_all_keys(keymaps, { silent = true })

------------------------------------------------------------------------------
-- Auto commands
require("core.autocmds")

------------------------------------------------------------------------------
-- Miscellaneous
local state = require("core.state")

-- Enable native Undotree
vim.cmd.packadd("nvim.undotree")

-- Enable new experimental UI2
-- require("vim._core.ui2").enable({
--    enable = true,
--    msg = {
--       -- This redirect messages to the new system
--       targets = {
--          confirm = "cmd", -- Confirm prompts (e.g., :quit with unsaved changes)
--          [""] = "msg", -- General messages (echo)
--          bufwrite = "msg", -- Buffer write messages
--          echo = "msg", -- :echo output
--          echoerr = "msg", -- :echoerr output
--          echomsg = "msg", -- :echomsg output
--          emsg = "msg", -- Error messages (goes to the new pager buffer)
--       },
--    },
-- })

-- Enable Hardtime.nvim hardtime mode at startup if
-- `state.hardtime_enabled_at_startup` is true
-- To modify the `state.hardtime_enabled_at_startup` flag, edit its table
-- entry in `lua/core/state.lua`
-- See the `M.hardtime` table in `lua/core/keymaps.lua` for keymaps/settings
-- TODO: Eliminate defer_fn() once it is no longer necessary
if state.hardtime_enabled_at_startup then
   vim.defer_fn(function()
      vim.cmd.Hardtime("enable")
   end, 1000)
else
   vim.defer_fn(function()
      vim.cmd.Hardtime("disable")
   end, 1000)
end

-- Define the keymap to toggle transparent background. This is enabled if the
-- `state.background_transparency_enabled_at_startup` flag is true.
-- This keymap is not enabled in Neovide sessions.
-- To modify the `state.background_transparency_enabled_at_startup` flag, edit
-- its table entry in `lua/core/state.lua`.
-- See the `M.background_transparency` table in `lua/core/keymaps.lua` for
-- keymaps/settings.
if not vim.g.neovide then
   util.map_keys(keymaps.background_transparency)
end
