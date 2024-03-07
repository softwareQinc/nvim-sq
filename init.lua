------------------------------------------------------------------------------
-- Start-up
-- Disable Neovim welcome message
vim.cmd("set shortmess+=I")
-- Set terminal GUI colors
vim.cmd("set termguicolors")
-- Set leader key mapping
-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "

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
-- Sets color theme using a protected call; in case it isn't available, loads
-- the default color scheme
local color_scheme = "gruvbox"
local status, _ = pcall(vim.cmd.colorscheme, color_scheme)
if not status then
   print("Color scheme '" .. color_scheme .. "'" .. " not found, switching to 'default'!")
end

------------------------------------------------------------------------------
-- Neovide initialization, executed only by a Neovide session
if vim.g.neovide then
   require("neovide")
end
