-- Enable running the current Python buffer in Normal mode, keymaps
local util = require("core.util")
local keymaps = require("core.keymaps")
util.map_keys(keymaps.run_current_python, { buffer = true })
