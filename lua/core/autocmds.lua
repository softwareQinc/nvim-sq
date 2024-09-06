-- Auto commands

local api = vim.api

-- Generic
api.nvim_create_augroup("Generic", { clear = true })
-- Highlights yanked text
api.nvim_create_autocmd("TextYankPost", {
   group = "Generic",
   pattern = { "*" },
   callback = function()
      vim.highlight.on_yank({ timeout = 200 })
   end,
   desc = "Highlights yanked text",
})
-- SignColumn always on, and of length 1, so new events in the SignColumn do
-- not push the text to the right
api.nvim_create_autocmd("VimEnter", {
   group = "Generic",
   pattern = { "*" },
   command = "set scl=yes numberwidth=1",
   desc = "SignColumn always on, length 1",
})
-- Set SignColumn color to background color, aesthetically nicer
api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
   group = "Generic",
   pattern = { "*" },
   command = "hi! link SignColumn Normal",
   desc = "Set SignColumn color to background color",
})
-- Fold method
vim.api.nvim_create_autocmd("FileType", {
   callback = function()
      if require("nvim-treesitter.parsers").has_parser() then
         vim.opt.foldmethod = "expr"
         vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      else
         vim.opt.foldmethod = "indent"
      end
   end,
   desc = "Set foldmethod",
})
-- Cursor line in active buffer
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
   group = "Generic",
   pattern = { "*" },
   command = "setlocal cursorlineopt=both",
   desc = "Set cursorline/cursorlineopt in active buffer",
})
-- Cursor line in inactive buffers
vim.api.nvim_create_autocmd("WinLeave", {
   group = "Generic",
   pattern = { "*" },
   command = "setlocal cursorlineopt=line",
   desc = "Set cursorline/cursorlineopt in inactive buffer",
})

-- Terminal
api.nvim_create_augroup("Terminal", { clear = true })
-- Disable spell checking and line numbering
api.nvim_create_autocmd("TermOpen", {
   group = "Terminal",
   pattern = { "*" },
   command = "setlocal nospell nonumber norelativenumber",
   desc = "Disable spell checking and line numbering in Term windows",
})
-- Enter Term windows in Insert mode
api.nvim_create_autocmd("TermOpen", {
   group = "Terminal",
   pattern = { "*" },
   callback = function(opts)
      -- https://github.com/mfussenegger/nvim-dap/issues/439#issuecomment-1380787919
      if opts.file:match("dap%-terminal") then
         return
      end
      vim.cmd("startinsert")
      vim.cmd("setlocal nonumber")
   end,
   desc = "Enter Term windows in Insert mode",
})
-- Exit Term windows without pressing any key
-- api.nvim_create_autocmd("TermClose", {
--    group = "Terminal",
--    pattern = { "*" },
--    command = "call feedkeys('q')",
--    desc = "Exit Term windows without pressing any key",
-- })

-- Quickfix lists
api.nvim_create_augroup("Quickfix", { clear = true })
-- Disable spell checking
api.nvim_create_autocmd("FileType", {
   group = "Quickfix",
   pattern = { "qf" },
   command = "setlocal nospell",
   desc = "Disable spell checking in Quickfix lists",
})

-- Change color scheme automatically based on time of the day
vim.api.nvim_create_augroup("AutoColorScheme", { clear = true })
vim.api.nvim_create_autocmd({
   "CursorHold",
   "CursorHoldI",
   "CursorMoved",
   "CursorMovedI",
   "FocusGained",
   "FocusLost",
   "InsertEnter",
   "TextChanged",
   "TextChangedI",
   "TextChangedT",
   "VimEnter",
}, {
   group = "AutoColorScheme",
   callback = require("core.ui").set_color_scheme_callback,
   desc = "Set auto color scheme",
})

-- Transparent editing of GnuPG-encrypted files
-- Written by Patrick R. McDonald at https://www.antagonism.org/privacy/gpg-vi.shtml
-- Based on a solution by Wouter Hanegraaff
vim.api.nvim_create_augroup("GnuPG", { clear = true })
-- First make sure nothing is written to ~/.viminfo while editing an encrypted
-- file
vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
   group = "GnuPG",
   pattern = { "*.gpg", "*.asc" },
   command = "set viminfo=",
   desc = "Do not write to ~/.viminfo while editing GnuPG-encrypted files",
})
-- We don't want a swap file, as it writes unencrypted data to disk
vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
   group = "GnuPG",
   pattern = { "*.gpg", "*.asc" },
   command = "set noswapfile shada=",
   desc = "Disable swap and shada files while editing GnuPG-encrypted files",
})
-- Switch to binary mode to read the encrypted file
vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
   group = "GnuPG",
   pattern = { "*.gpg" },
   command = "set bin",
   desc = "Switch to binary mode when reading GnuPG-encrpyted files",
})
vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
   group = "GnuPG",
   pattern = { "*.gpg", "*.asc" },
   command = "let ch_save = &ch|set ch=2",
   desc = "Switch to binary mode when reading GnuPG-encrypted files",
})
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
   group = "GnuPG",
   pattern = { "*.gpg", "*.asc" },
   command = "%!sh -c 'gpg --decrypt 2>/dev/null'",
   desc = "Switch to binary mode when reading GnuPG-encrypted files",
})
-- Switch to normal mode for editing
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
   group = "GnuPG",
   pattern = { "*.gpg" },
   command = "set nobin",
   desc = "Switch to normal mode for editing GnuPG-encrypted files",
})
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
   group = "GnuPG",
   pattern = { "*.gpg", "*.asc" },
   command = "let &ch = ch_save|unlet ch_save",
   desc = "Switch to normal mode for editing GnuPG-encrypted files",
})
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
   group = "GnuPG",
   pattern = { "*.gpg", "*.asc" },
   command = 'execute ":doautocmd BufReadPost " . expand("%:r")',
   desc = "Switch to normal mode for editing GnuPG-encrypted files",
})
-- Convert all text to encrypted text before writing
vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
   group = "GnuPG",
   pattern = { "*.gpg" },
   command = "set bin",
   desc = "Convert all text to encrypted text before writing GnuPG-encrypted files",
})
vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
   group = "GnuPG",
   pattern = { "*.gpg" },
   command = "%!sh -c 'gpg --default-recipient-self -e 2>/dev/null'",
   desc = "Convert all text to encrypted text before writing GnuPG-encrypted files",
})
vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
   group = "GnuPG",
   pattern = { "*.asc" },
   command = "%!sh -c 'gpg --default-recipient-self -e -a 2>/dev/null'",
   desc = "Convert all text to encrypted text before writing GnuPG-encrypted files",
})
-- Undo the encryption so we are back in the normal text, directly after the
-- file has been written
vim.api.nvim_create_autocmd({ "BufWritePost", "FileWritePost" }, {
   group = "GnuPG",
   pattern = { "*.gpg", "*.asc" },
   command = "u",
   desc = "Undo encryption for GnuPG-encrypted files",
})
