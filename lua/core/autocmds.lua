-- Auto commands

local api = vim.api

-- Generic
api.nvim_create_augroup("Generic", { clear = true })
-- Auto resize panes when resizing Neovim window
api.nvim_create_autocmd("VimResized", {
   group = "Generic",
   pattern = "*",
   command = "tabdo wincmd =",
})
-- Highlights yanked text
api.nvim_create_autocmd("TextYankPost", {
   group = "Generic",
   pattern = "*",
   callback = function()
      vim.highlight.on_yank({ timeout = 200 })
   end,
})
-- SignColumn always on, and of length 1, so new events in the SignColumn do
-- not "push" the text to the right
api.nvim_create_autocmd("VimEnter", {
   group = "Generic",
   pattern = "*",
   command = "set scl=yes numberwidth=1",
})
-- Set SignColumn color to background color, aesthetically nicer
api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
   group = "Generic",
   pattern = "*",
   command = "hi! link SignColumn Normal",
})

-- CPP
api.nvim_create_augroup("CPP", { clear = true })
-- 80/120 column markers
api.nvim_create_autocmd("FileType", {
   group = "CPP",
   pattern = { "c", "cpp" },
   command = "setlocal colorcolumn=80,120",
})
-- Enable compiling and running of current C/C++ buffer in Normal mode
api.nvim_create_autocmd("FileType", {
   pattern = { "c", "cpp" },
   callback = function()
      local util = require("core.util")
      local bindings = require("core.bindings")
      util.map_keys(bindings.compile_and_run_current_cpp, { buffer = true })
   end,
})

-- Markdown
api.nvim_create_augroup("Markdown", { clear = true })
-- 80/120 column markers
api.nvim_create_autocmd("FileType", {
   group = "Markdown",
   pattern = "markdown",
   command = "setlocal colorcolumn=80,120",
})
-- Required by obsidian.nvim
local home = vim.fn.expand("$HOME")
api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
   group = "Markdown",
   pattern = home .. "/vaults/**.md",
   command = "setlocal conceallevel=1",
})

-- LaTeX
api.nvim_create_augroup("Latex", { clear = true })
-- Split text at 80 columns
api.nvim_create_autocmd("FileType", {
   group = "Latex",
   pattern = { "tex", "plaintex" },
   command = "setlocal textwidth=80",
})

-- Lua
api.nvim_create_augroup("Lua", { clear = true })
api.nvim_create_autocmd("FileType", {
   group = "Lua",
   pattern = "lua",
   command = "setlocal shiftwidth=3 tabstop=3",
})

-- CMake
api.nvim_create_augroup("CMake", { clear = true })
api.nvim_create_autocmd("FileType", {
   group = "CMake",
   pattern = "cmake",
   command = "setlocal shiftwidth=2 tabstop=2",
})

-- Neorg
api.nvim_create_augroup("Neorg", { clear = true })
api.nvim_create_autocmd("FileType", {
   group = "Neorg",
   pattern = "norg",
   command = "setlocal shiftwidth=2 tabstop=2",
})

-- Terminal
api.nvim_create_augroup("Terminal", { clear = true })
-- Disable spelling and line numbers
api.nvim_create_autocmd("TermOpen", {
   group = "Terminal",
   pattern = "*",
   command = "setlocal nospell nonumber norelativenumber",
})
-- Enter insert mode
api.nvim_create_autocmd("TermOpen", {
   group = "Terminal",
   pattern = "*",
   command = "startinsert",
})
-- Exit without pressing any other key
api.nvim_create_autocmd("TermClose", {
   group = "Terminal",
   pattern = "*",
   command = "call feedkeys('q')",
})
