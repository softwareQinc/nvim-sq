-- Auto commands

-- Generic
local generic_grp = vim.api.nvim_create_augroup("Generic", { clear = true })
-- Highlights yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
   group = generic_grp,
   pattern = { "*" },
   callback = function()
      vim.highlight.on_yank({ timeout = 200 })
   end,
   desc = "Highlights yanked text",
})
-- SignColumn always on, and of length 1, so new events in the SignColumn do
-- not push the text to the right
vim.api.nvim_create_autocmd("VimEnter", {
   group = generic_grp,
   pattern = { "*" },
   callback = function()
      vim.opt.signcolumn = "yes"
      vim.opt.numberwidth = 1
   end,
   desc = "SignColumn always on, length 1",
})
-- Set SignColumn color to background color, aesthetically nicer
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
   group = generic_grp,
   pattern = { "*" },
   command = "hi! link SignColumn Normal",
   desc = "Set SignColumn color to background color",
})
-- Fold method
vim.api.nvim_create_autocmd("FileType", {
   group = generic_grp,
   callback = function()
      if require("nvim-treesitter.parsers").has_parser() then
         vim.opt.foldmethod = "expr"
         vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end
   end,
   desc = "Set foldmethod",
})
-- Cursor line in active buffer
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
   group = generic_grp,
   pattern = { "*" },
   callback = function()
      vim.opt_local.cursorlineopt = "both"
   end,
   desc = "Set cursorline/cursorlineopt in active buffer",
})
-- Cursor line in inactive buffers
vim.api.nvim_create_autocmd("WinLeave", {
   group = generic_grp,
   pattern = { "*" },
   callback = function()
      vim.opt_local.cursorlineopt = "line"
   end,
   desc = "Set cursorline/cursorlineopt in inactive buffer",
})

-- Restore last cursor position and centre the screen when reopening a file
local restore_cursor_grp =
   vim.api.nvim_create_augroup("RestoreCursor", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
   group = restore_cursor_grp,
   desc = "Jump to last edit position in file",
   callback = function()
      local last_line = vim.fn.line([['"]])
      local total_lines = vim.fn.line("$")
      if last_line >= 1 and last_line <= total_lines then
         vim.cmd('normal! g`"zz')
      end
   end,
})

-- Terminal
local terminal_grp = vim.api.nvim_create_augroup("Terminal", { clear = true })
-- Disable spell checking and line numbering
vim.api.nvim_create_autocmd("TermOpen", {
   group = terminal_grp,
   pattern = { "*" },
   callback = function()
      vim.opt_local.spell = false
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
   end,
   desc = "Disable spell checking and line numbering in terminal windows",
})
-- Enter terminal windows in Insert mode
vim.api.nvim_create_autocmd("TermOpen", {
   group = terminal_grp,
   pattern = { "*" },
   callback = function()
      -- Prevent nvim-dap-ui from switching to Insert mode, see
      -- https://github.com/mfussenegger/nvim-dap/issues/439#issuecomment-1380787919
      -- opts.file:match('dap%-terminal') doesn't work anymore
      local buf_no = vim.api.nvim_get_current_buf()
      local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = buf_no })
      if buf_ft == "dapui_console" then
         return
      end
      vim.cmd("startinsert")
      vim.opt_local.number = false
   end,
   desc = "Enter terminal windows in Insert mode",
})
-- Exit terminal windows without pressing any key
-- vim.api.nvim_create_autocmd("TermClose", {
--    group = terminal_grp,
--    pattern = { "*" },
--    command = "call feedkeys('q')",
--    desc = "Exit terminal windows without pressing any key",
-- })

-- Quickfix lists
local quickfix_grp = vim.api.nvim_create_augroup("Quickfix", { clear = true })
-- Disable spell checking
vim.api.nvim_create_autocmd("FileType", {
   group = quickfix_grp,
   pattern = { "qf" },
   callback = function()
      vim.opt_local.spell = false
   end,
   desc = "Disable spell checking in quickfix lists",
})

-- Change color scheme automatically based on time of the day
local auto_color_scheme_grp =
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
   group = auto_color_scheme_grp,
   callback = require("core.ui").set_color_scheme_callback,
   desc = "Set auto color scheme",
})

-- Restore the state of transparent background on ColorScheme event
-- This auto command is not enabled in Neovide sessions
if not vim.g.neovide then
   local transparent_background_grp =
      vim.api.nvim_create_augroup("TransparentBackground", { clear = true })
   vim.api.nvim_create_autocmd("ColorScheme", {
      group = transparent_background_grp,
      callback = function()
         local state = require("core.state")
         local ui = require("core.ui")
         if state.background_transparency_enabled_at_startup then
            ui.set_background_transparency(true)
         end
      end,
   })
end

-- Transparent editing of GnuPG-encrypted files
-- Written by Patrick R. McDonald at
-- https://www.antagonism.org/privacy/gpg-vi.shtml
-- Based on a solution by Wouter Hanegraaff
local gnupg_grp = vim.api.nvim_create_augroup("GnuPG", { clear = true })
-- First make sure nothing is written to ~/.viminfo while editing an encrypted
-- file
vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
   group = gnupg_grp,
   pattern = { "*.gpg", "*.asc" },
   callback = function()
      vim.opt.viminfo = ""
   end,
   desc = "Do not write to ~/.viminfo while editing GnuPG-encrypted files",
})
-- We don't want a swap file, as it writes unencrypted data to disk
vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
   group = gnupg_grp,
   pattern = { "*.gpg", "*.asc" },
   callback = function()
      vim.opt_local.swapfile = false
      vim.opt.shada = ""
   end,
   desc = "Disable swap and shada files while editing GnuPG-encrypted files",
})
-- Set binary mode to read the encrypted file
vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
   group = gnupg_grp,
   pattern = { "*.gpg" },
   callback = function()
      vim.opt_local.binary = true
   end,
   desc = "Set binary mode when reading GnuPG-encrpyted files",
})
vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
   group = gnupg_grp,
   pattern = { "*.gpg", "*.asc" },
   command = "let ch_save = &ch|set ch=2",
   desc = "Set binary mode when reading GnuPG-encrypted files",
})
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
   group = gnupg_grp,
   pattern = { "*.gpg", "*.asc" },
   command = "%!sh -c 'gpg --decrypt 2>/dev/null'",
   desc = "Set binary mode when reading GnuPG-encrypted files",
})
-- Set Normal mode for editing
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
   group = gnupg_grp,
   pattern = { "*.gpg" },
   callback = function()
      vim.opt_local.binary = false
   end,
   desc = "Set Normal mode for editing GnuPG-encrypted files",
})
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
   group = gnupg_grp,
   pattern = { "*.gpg", "*.asc" },
   command = "let &ch = ch_save|unlet ch_save",
   desc = "Set Normal mode for editing GnuPG-encrypted files",
})
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
   group = gnupg_grp,
   pattern = { "*.gpg", "*.asc" },
   command = 'execute ":doautocmd BufReadPost " . expand("%:r")',
   desc = "Set Normal mode for editing GnuPG-encrypted files",
})
-- Convert all text to encrypted text before writing
vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
   group = gnupg_grp,
   pattern = { "*.gpg" },
   callback = function()
      vim.opt_local.binary = false
   end,
   desc = "Convert all text to encrypted text before writing GnuPG-encrypted files",
})
vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
   group = gnupg_grp,
   pattern = { "*.gpg" },
   command = "%!sh -c 'gpg --default-recipient-self -e 2>/dev/null'",
   desc = "Convert all text to encrypted text before writing GnuPG-encrypted files",
})
vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
   group = gnupg_grp,
   pattern = { "*.asc" },
   command = "%!sh -c 'gpg --default-recipient-self -e -a 2>/dev/null'",
   desc = "Convert all text to encrypted text before writing GnuPG-encrypted files",
})
-- Undo the encryption so we are back in the normal text, directly after the
-- file has been written
vim.api.nvim_create_autocmd({ "BufWritePost", "FileWritePost" }, {
   group = gnupg_grp,
   pattern = { "*.gpg", "*.asc" },
   command = "u",
   desc = "Undo encryption for GnuPG-encrypted files",
})
