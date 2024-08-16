------------------------------------------------------------------------------
-- Start-up
-- Set leader/localleader keymaps
-- Ensure `mapleader` is set before lazy so that your keymaps are correct
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

------------------------------------------------------------------------------
-- Setup Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
   })
end
vim.opt.rtp:prepend(lazypath)
local plugins = "plugins"
local opts = {
   change_detection = {
      enabled = true,
      notify = false,
   },
}
require("lazy").setup(plugins, opts)

------------------------------------------------------------------------------
-- Core functionality setup
require("core")

------------------------------------------------------------------------------
-- Enable hardtime.nvim at startup, disabled by default
-- See the M.hardtime table in "lua/core/keymaps.lua" for keymaps and settings
-- To modify the state.hardtime_enabled flag, edit the table in
-- "lua/core/state.lua"
local state = require("core.state")
if state.hardtime_enabled then
   vim.o.showmode = false
   vim.cmd("Hardtime enable")
end

------------------------------------------------------------------------------
-- Set color scheme to light between 8:00AM and 5:00PM, dark otherwise
-- Color scheme plugins are loaded from "lua/plugins/colors.lua"
-- For defaults, see "lua/core/state.lua"
local ui = require("core.ui")
ui.set_auto_scheme({
   light_scheme_name = "vscode", -- default light color scheme
   dark_scheme_name = "kanagawa", -- default dark color scheme
   light_scheme_starts_at = { hour = 8, min = 00 }, -- 24h format
   light_scheme_ends_at = { hour = 17, min = 00 }, -- 24h format
})

------------------------------------------------------------------------------
-- Neovide initialization, executed only by a Neovide session
if vim.g.neovide then
   pcall(require, "neovide")
end
