-- Options

local M = {}

M = {
   opt = {
      expandtab = true,
      shiftwidth = 4,
      softtabstop = 4,
      tabstop = 4,

      cursorline = true,
      number = true,
      relativenumber = true,

      signcolumn = "yes:1",

      hlsearch = true,
      showmode = true,
      spell = true,
      spelllang = "en_ca",

      splitbelow = true,
      splitright = true,

      inccommand = "split",
      scrolloff = 8,
      virtualedit = "block",

      foldlevel = 99,
      foldlevelstart = 99,
      foldnestmax = 10,

      -- Tree-sitter folding is set up in `lua/plugins/treesitter.lua`
      foldmethod = "indent",

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

      winborder = "rounded",
   },
   g = {
      -- OpenQASM falls back to version 2.0
      openqasm_version_fallback = 2.0,
      -- openqasm_version_override = 2.0
   },
}

return M
