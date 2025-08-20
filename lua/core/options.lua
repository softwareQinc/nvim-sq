-- Options

local M = {}

M = {
   opt = {
      expandtab = true,
      tabstop = 4,
      softtabstop = 4,
      shiftwidth = 4,

      number = true,
      relativenumber = true,
      cursorline = true,

      hlsearch = true,
      showmode = true,
      spell = true,

      splitbelow = true,
      splitright = true,

      inccommand = "split",
      virtualedit = "block",
      scrolloff = 8,

      foldlevelstart = 99,
      -- foldmethod is set in "lua/core/autocmds.lua" (see Folding)

      termguicolors = true,
      undofile = true,

      listchars = { -- special characters
         -- eol = "⏎",
         -- space = "␣",
         tab = ">-",
      },
      list = true, -- show special characters

      -- ignorecase = true,
      -- textwidth = 80,
      -- colorcolumn = "80,120",
   },
   g = {
      -- OpenQASM falls back to version 2.0
      openqasm_version_fallback = 2.0,
      -- openqasm_version_override = 2.0
   },
}

return M
