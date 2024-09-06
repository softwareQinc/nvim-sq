-- 80/120 column markers
vim.cmd.setlocal("colorcolumn=80,120")

-- Split text at 80 columns
vim.cmd.setlocal("textwidth=80")

-- Restore Markdown highlights when the color scheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
   group = vim.api.nvim_create_augroup("MarkdownHighlights", { clear = true }),
   callback = function()
      if vim.bo.filetype == "markdown" then
         vim.cmd.setlocal("filetype=markdown")
      end
   end,
   desc = "Restore Markdown highlights when the color scheme changes",
})
