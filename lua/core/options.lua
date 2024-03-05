-- Vim options

local M = {}

M = {
   opt = {
      shell = "bash --login",
      spell = true,
      termguicolors = true,
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
      textwidth = 78,
      scrolloff = 8,
      cursorline = true,
      undofile = true,
      hlsearch = true,
      showmode = false, -- we have lualine
      mouse = "a",
      -- colorcolumn = "80,120",
      -- ignorecase = true,
   },
   g = {
      -- OpenQASM falls back to version 2.0
      openqasm_version_fallback = 2.0,
      -- openqasm_version_override = 2.0
   },
}

return M
