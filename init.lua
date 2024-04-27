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
-- Set color scheme to light between 8AM and 5PM, dark otherwise
-- Color scheme plugins are loaded from "lua/plugins/colors.lua"
local ui = require("core.ui")
ui.set_auto_scheme({
   light_scheme_name = "vscode", -- default light color scheme
   dark_scheme_name = "catppuccin", -- default dark color scheme
   light_scheme_starts_at = 08, -- light color scheme starts (24h format)
   light_scheme_ends_at = 17, -- light color scheme ends (24h format)
})

------------------------------------------------------------------------------
-- Neovide initialization, executed only by a Neovide session
if vim.g.neovide then
   pcall(require, "neovide")
end
