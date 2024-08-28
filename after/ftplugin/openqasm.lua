-- Enable running the current OpenQASM buffer in Normal mode with qpp_qasm
-- Requires qpp_qasm from Quantum++, https://github.com/softwareqinc/qpp
local util = require("core.util")
local keymaps = require("core.keymaps")
util.map_keys(keymaps.run_current_qasm, { buffer = true })
