local api = vim.api
local keymap = vim.keymap

-- Generic
api.nvim_create_augroup("Generic", { clear = true })
-- Auto resize panes when resizing nvim window
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

-- CPP
api.nvim_create_augroup("CPP", { clear = true })
-- 80/120 column markers
api.nvim_create_autocmd("FileType", {
   group = "CPP",
   pattern = { "c", "cpp" },
   command = "setlocal colorcolumn=80,120",
})
-- Enable compiling and running of standalone C/C++ buffers in normal mode
local cc_run_map = "<leader>cx"
api.nvim_create_autocmd("FileType", {
   pattern = { "c", "cpp" },
   callback = function()
      keymap.set("n", cc_run_map, function()
         local current_file = vim.fn.expand("%:p")
         local output_file = current_file:gsub("%..-$", "")
         local terminal_cmd = '!bash -c "make ' .. output_file .. " && " .. output_file .. '"'
         api.nvim_command(terminal_cmd)
      end, { buffer = true, desc = "Compile and run standalone C/C++ file" })
   end,
})

-- Markdown
api.nvim_create_augroup("Markdown", { clear = true })
-- 80/120 column markers
api.nvim_create_autocmd("FileType", {
   group = "Markdown",
   pattern = "markdown",
   command = "setlocal colorcolumn=80,120",
})
-- Required by obsidian.nvim
local home = vim.fn.expand("$HOME")
api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
   group = "Markdown",
   pattern = home .. "/vaults/**.md",
   command = "setlocal conceallevel=1",
})

-- LaTeX
api.nvim_create_augroup("Latex", { clear = true })
-- LaTeX split at 80 columns
api.nvim_create_autocmd("FileType", {
   group = "Latex",
   pattern = { "tex", "plaintex" },
   command = "setlocal textwidth=80",
})

-- Lua
api.nvim_create_augroup("Lua", { clear = true })
api.nvim_create_autocmd("FileType", {
   group = "Lua",
   pattern = "lua",
   command = "setlocal shiftwidth=3 tabstop=3",
})

-- CMake
api.nvim_create_augroup("CMake", { clear = true })
api.nvim_create_autocmd("FileType", {
   group = "CMake",
   pattern = "cmake",
   command = "setlocal shiftwidth=2 tabstop=2",
})

-- Neorg
api.nvim_create_augroup("Neorg", { clear = true })
api.nvim_create_autocmd("FileType", {
   group = "Neorg",
   pattern = "norg",
   command = "setlocal shiftwidth=2 tabstop=2",
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
