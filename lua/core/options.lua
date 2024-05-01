-- Vim options

local M = {}

M = {
   opt = {
      shortmess = vim.opt.shortmess + "sI", -- disable Neovim welcome message
      shell = "bash --login",
      spell = true,
      termguicolors = true, -- true colors
      expandtab = true,
      tabstop = 4,
      softtabstop = 4,
      shiftwidth = 4,
      relativenumber = true,
      number = true,
      splitbelow = true,
      splitright = true,
      inccommand = "split",
      virtualedit = "block",
      scrolloff = 8,
      cursorline = true,
      undofile = true,
      hlsearch = true,
      showmode = false, -- we have lualine
      foldlevelstart = 20,
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
