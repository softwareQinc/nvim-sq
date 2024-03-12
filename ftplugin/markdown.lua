-- 80/120 column markers
vim.cmd.setlocal("colorcolumn=80,120")

-- Required by obsidian.nvim
vim.api.nvim_create_augroup("Markdown", { clear = true })
local home = vim.fn.expand("$HOME")
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
   group = "Markdown",
   pattern = home .. "/vaults/**.md",
   command = "setlocal conceallevel=1",
})
