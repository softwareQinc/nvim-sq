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
