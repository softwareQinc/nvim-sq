-- 80/120 column markers
vim.cmd.setlocal("colorcolumn=80,120")

-- Split text at 80 columns
vim.cmd.setlocal("textwidth=80")

-- Restore Italic/Bold/Strikethrough/Underline highlights when the color scheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
   group = vim.api.nvim_create_augroup("Markdown", { clear = true }),
   pattern = { "*" },
   callback = function()
      vim.api.nvim_set_hl(0, "markdownBold", { bold = true })
      vim.api.nvim_set_hl(0, "markdownItalic", { italic = true })
      vim.api.nvim_set_hl(0, "markdownStrike", { strikethrough = true })
      vim.api.nvim_set_hl(0, "markdownUnderline", { underline = true })
   end,
   desc = "Restore Italic/Bold/Strikethrough/Underline highlights when the color scheme changes (Markdown)",
})
