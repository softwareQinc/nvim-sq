-- 80/120 column markers
---@diagnostic disable-next-line: missing-fields
vim.opt_local.colorcolumn = { "80", "120" }

-- Split text at 80 columns
vim.opt_local.textwidth = 80

-- Restore Markdown highlights when the color scheme changes
local grp = vim.api.nvim_create_augroup("MarkdownHighlights", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
   group = grp,
   callback = function()
      if vim.bo.filetype == "markdown" then
         vim.opt_local.filetype = "markdown"
      end
   end,
   desc = "Restore Markdown highlights when the color scheme changes",
})
