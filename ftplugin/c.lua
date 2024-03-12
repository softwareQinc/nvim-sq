-- 80/120 column markers
vim.cmd.setlocal("colorcolumn=80,120")

-- Enable compiling and running of current C buffer in Normal mode
local util = require("core.util")
local bindings = require("core.bindings")
util.map_keys(bindings.compile_and_run_current_cpp, { buffer = true })
