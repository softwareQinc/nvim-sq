-- 80/120 column markers
vim.cmd.setlocal("colorcolumn=80,120")

-- Split text at 80 columns
vim.cmd.setlocal("textwidth=80")

-- Required by obsidian.nvim
local home = vim.fn.expand("$HOME")
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
   group = vim.api.nvim_create_augroup("Markdown", { clear = true }),
   pattern = home .. "/vaults/**.md",
   command = "setlocal conceallevel=2",
})
