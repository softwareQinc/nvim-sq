-- 80/120 column markers
vim.opt_local.colorcolumn = { 80, 120 }

-- Enable compiling and running the current C buffer in Normal mode
local util = require("core.util")
local keymaps = require("core.keymaps")
util.map_keys(keymaps.compile_and_run_current_cpp, { buffer = true })
