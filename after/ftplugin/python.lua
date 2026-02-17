-- Keymaps to execute the current Python buffer in Normal mode
local util = require("core.util")
local keymaps = require("core.keymaps")
util.map_keys(keymaps.run_current_python, { buffer = true })
