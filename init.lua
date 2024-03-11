------------------------------------------------------------------------------
-- Start-up
-- Disable Neovim welcome message
vim.cmd("set shortmess+=I")
-- Set terminal GUI colors
vim.cmd("set termguicolors")
-- Set leader key mapping
-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "
vim.g.maplocalleader = ","

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
local opts = {}
require("lazy").setup(plugins, opts)

------------------------------------------------------------------------------
-- Core functionality setup
require("core")

------------------------------------------------------------------------------
-- Sets color theme to light between 8AM and 7PM, dark otherwise
-- Colors scheme plugins are loaded from "./lua/plugins/colors.lua"
local ui = require("core.ui")
ui.set_auto_theme({
   light_scheme_name = "vscode", -- default light theme
   dark_scheme_name = "catppuccin", -- default dark theme
   light_scheme_starts_at = 8, -- light theme starts at this time (24h format)
   light_scheme_ends_at = 17, -- light theme ends at this time (24h format)
})

------------------------------------------------------------------------------
-- Neovide initialization, executed only by a Neovide session
if vim.g.neovide then
   require("neovide")
end
