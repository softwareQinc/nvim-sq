-- 80/120 column markers
---@diagnostic disable-next-line: missing-fields
vim.opt_local.colorcolumn = { "80", "120" }

-- Enable compiling and running the current C buffer in Normal modes, keymaps
local util = require("core.util")
local keymaps = require("core.keymaps")
util.map_keys(keymaps.compile_and_run_current_cpp, { buffer = true })
