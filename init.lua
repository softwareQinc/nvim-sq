------------------------------------------------------------------------------
-- Entry point

------------------------------------------------------------------------------
-- Set leader/localleader keymaps
-- Make sure to setup `mapleader` and `maplocalleader` before loading
-- lazy.nvim so that mappings are correct
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

------------------------------------------------------------------------------
-- lazy.nvim plugin manager
require("config.lazy")

------------------------------------------------------------------------------
-- Core functionality
require("core")

------------------------------------------------------------------------------
-- Set color scheme to light between 8:00 AM and 5:00 PM, dark otherwise
-- Color scheme plugins are loaded from "lua/plugins/colorschemes.lua"
-- For defaults, see "lua/core/state.lua"
local ui = require("core.ui")
ui.set_auto_scheme({
   light_scheme_name = "vscode", -- default light color scheme
   dark_scheme_name = "kanagawa", -- default dark color scheme
   light_scheme_starts_at = { hour = 08, min = 00 }, -- 24h format
   light_scheme_ends_at = { hour = 17, min = 00 }, -- 24h format
})

------------------------------------------------------------------------------
-- Neovide initialization and configuration, executed only by Neovide sessions
if vim.g.neovide then
   pcall(require, "neovide")
end
