-- Auto commands

local api = vim.api

-- Generic
api.nvim_create_augroup("Generic", { clear = true })
-- Auto resize panes when resizing Neovim window
api.nvim_create_autocmd("VimResized", {
   group = "Generic",
   pattern = "*",
   command = "tabdo wincmd =",
   desc = "Auto resize panes when resizing Neovim window",
})
-- Highlights yanked text
api.nvim_create_autocmd("TextYankPost", {
   group = "Generic",
   pattern = "*",
   callback = function()
      vim.highlight.on_yank({ timeout = 200 })
   end,
   desc = "Highlights yanked text",
})
-- SignColumn always on, and of length 1, so new events in the SignColumn do
-- not push the text to the right
api.nvim_create_autocmd("VimEnter", {
   group = "Generic",
   pattern = "*",
   command = "set scl=yes numberwidth=1",
   desc = "SignColumn always on, length 1",
})
-- Set SignColumn color to background color, aesthetically nicer
api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
   group = "Generic",
   pattern = "*",
   command = "hi! link SignColumn Normal",
   desc = "Set SignColumn color to background color",
})
-- Folding
vim.api.nvim_create_autocmd("FileType", {
   callback = function()
      if require("nvim-treesitter.parsers").has_parser() then
         vim.opt.foldmethod = "expr"
         vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      else
         vim.opt.foldmethod = "syntax"
      end
   end,
})
-- Cursor line in current buffer
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
   group = "Generic",
   pattern = "*",
   command = "setlocal cursorline",
})
-- Disable cursor line in inactive buffers
vim.api.nvim_create_autocmd("WinLeave", {
   group = "Generic",
   pattern = "*",
   command = "setlocal nocursorline",
})

-- Terminal
api.nvim_create_augroup("Terminal", { clear = true })
-- Disable spelling and line numbers
api.nvim_create_autocmd("TermOpen", {
   group = "Terminal",
   pattern = "*",
   command = "setlocal nospell nonumber norelativenumber",
   desc = "Disable spelling and line numbers in term windows",
})
-- Enter term windows in Insert mode
api.nvim_create_autocmd("TermOpen", {
   group = "Terminal",
   pattern = "*",
   callback = function(opts)
      -- https://github.com/mfussenegger/nvim-dap/issues/439#issuecomment-1380787919
      if opts.file:match("dap%-terminal") then
         return
      end
      vim.cmd("startinsert")
      vim.cmd("setlocal nonu")
   end,
   desc = "Enter term windows in Insert mode",
})
-- Exit term windows without pressing any key
-- api.nvim_create_autocmd("TermClose", {
--    group = "Terminal",
--    pattern = "*",
--    command = "call feedkeys('q')",
--    desc = "Exit term windows without pressing any key",
-- })
