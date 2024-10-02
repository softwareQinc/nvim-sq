-- Options

local M = {}

M = {
   opt = {
      shortmess = vim.opt.shortmess + "I", -- disable Neovim welcome message
      shell = "bash --login",
      spell = true,
      termguicolors = true,
      expandtab = true,
      tabstop = 4,
      softtabstop = 4,
      shiftwidth = 4,
      cursorline = true,
      number = true,
      relativenumber = true,
      splitbelow = true,
      splitright = true,
      inccommand = "split",
      virtualedit = "block",
      scrolloff = 8,
      undofile = true,
      hlsearch = true,
      showmode = true,
      foldlevelstart = 99,
      -- foldmethod is set in "lua/core/autocmds.lua" (see Folding)
      timeoutlen = 400,
      listchars = { -- special characters
         -- eol = "⏎",
         -- space = "␣",
         tab = ">-",
      },
      list = true, -- show special characters
      -- colorcolumn = "80,120",
      -- ignorecase = true,
      -- textwidth = 80,
   },
   g = {
      -- OpenQASM falls back to version 2.0
      openqasm_version_fallback = 2.0,
      -- openqasm_version_override = 2.0
   },
}

return M
