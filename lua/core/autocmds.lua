-- Auto commands

-- Generic
local generic_grp = vim.api.nvim_create_augroup("Generic", { clear = true })
-- Highlights yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
   group = generic_grp,
   pattern = { "*" },
   desc = "Highlights yanked text",
   callback = function()
      vim.highlight.on_yank({ timeout = 200 })
   end,
})
-- Set SignColumn color to background color, aesthetically nicer
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
   group = generic_grp,
   pattern = { "*" },
   desc = "Set SignColumn color to background color",
   command = "hi! link SignColumn Normal",
})
-- Cursor line in active buffer
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
   group = generic_grp,
   pattern = { "*" },
   desc = "Set cursorline/cursorlineopt in active buffer",
   callback = function()
      vim.opt_local.cursorlineopt = "both"
   end,
})
-- Cursor line in inactive buffers
vim.api.nvim_create_autocmd("WinLeave", {
   group = generic_grp,
   pattern = { "*" },
   desc = "Set cursorline/cursorlineopt in inactive buffer",
   callback = function()
      vim.opt_local.cursorlineopt = "line"
   end,
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
-- Disable spell checking
vim.api.nvim_create_autocmd("TermOpen", {
   group = terminal_grp,
   pattern = { "*" },
   desc = "Disable spell checking in terminal windows",
   callback = function()
      vim.opt_local.spell = false
   end,
})
-- Enter terminal windows in Insert mode
vim.api.nvim_create_autocmd("TermOpen", {
   group = terminal_grp,
   pattern = { "*" },
   desc = "Enter terminal windows in Insert mode",
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
})
-- Exit terminal windows without pressing any key
-- vim.api.nvim_create_autocmd("TermClose", {
--    group = terminal_grp,
--    pattern = { "*" },
--    desc = "Exit terminal windows without pressing any key",
--    command = "call feedkeys('q')",
-- })

-- Quickfix lists
local quickfix_grp = vim.api.nvim_create_augroup("Quickfix", { clear = true })
-- Disable spell checking
vim.api.nvim_create_autocmd("FileType", {
   group = quickfix_grp,
   pattern = { "qf" },
   desc = "Disable spell checking in quickfix lists",
   callback = function()
      vim.opt_local.spell = false
   end,
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
   desc = "Set auto color scheme",
   callback = require("core.ui").set_color_scheme_callback,
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
   desc = "Do not write to ~/.viminfo while editing GnuPG-encrypted files",
   callback = function()
      vim.opt.viminfo = ""
   end,
})
-- We don't want a swap file, as it writes unencrypted data to disk
vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
   group = gnupg_grp,
   pattern = { "*.gpg", "*.asc" },
   desc = "Disable swap and shada files while editing GnuPG-encrypted files",
   callback = function()
      vim.opt_local.swapfile = false
      vim.opt.shada = ""
   end,
})
-- Set binary mode to read the encrypted file
vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
   group = gnupg_grp,
   pattern = { "*.gpg" },
   desc = "Set binary mode when reading GnuPG-encrpyted files",
   callback = function()
      vim.opt_local.binary = true
   end,
})
vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
   group = gnupg_grp,
   pattern = { "*.gpg", "*.asc" },
   desc = "Set binary mode when reading GnuPG-encrypted files",
   command = "let ch_save = &ch|set ch=2",
})
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
   group = gnupg_grp,
   pattern = { "*.gpg", "*.asc" },
   desc = "Set binary mode when reading GnuPG-encrypted files",
   command = "%!sh -c 'gpg --decrypt 2>/dev/null'",
})
-- Set Normal mode for editing
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
   group = gnupg_grp,
   pattern = { "*.gpg" },
   desc = "Set Normal mode for editing GnuPG-encrypted files",
   callback = function()
      vim.opt_local.binary = false
   end,
})
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
   group = gnupg_grp,
   pattern = { "*.gpg", "*.asc" },
   desc = "Set Normal mode for editing GnuPG-encrypted files",
   command = "let &ch = ch_save|unlet ch_save",
})
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
   group = gnupg_grp,
   pattern = { "*.gpg", "*.asc" },
   desc = "Set Normal mode for editing GnuPG-encrypted files",
   command = 'execute ":doautocmd BufReadPost " . expand("%:r")',
})
-- Convert all text to encrypted text before writing
vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
   group = gnupg_grp,
   pattern = { "*.gpg" },
   desc = "Convert all text to encrypted text before writing GnuPG-encrypted files",
   callback = function()
      vim.opt_local.binary = false
   end,
})
vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
   group = gnupg_grp,
   pattern = { "*.gpg" },
   desc = "Convert all text to encrypted text before writing GnuPG-encrypted files",
   command = "%!sh -c 'gpg --default-recipient-self -e 2>/dev/null'",
})
vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
   group = gnupg_grp,
   pattern = { "*.asc" },
   desc = "Convert all text to encrypted text before writing GnuPG-encrypted files",
   command = "%!sh -c 'gpg --default-recipient-self -e -a 2>/dev/null'",
})
-- Undo the encryption so we are back in the normal text, directly after the
-- file has been written
vim.api.nvim_create_autocmd({ "BufWritePost", "FileWritePost" }, {
   group = gnupg_grp,
   pattern = { "*.gpg", "*.asc" },
   desc = "Undo encryption for GnuPG-encrypted files",
   command = "u",
})
