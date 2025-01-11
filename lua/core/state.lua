-- Runtime state holder

local M = {}

-- LSP format buffer on save is enabled by default at startup
M.format_on_save = true

-- Hardtime.nvim hardtime mode is disabled by default at startup
M.hardtime_enabled = false

-- Displays --INSERT--/--VISUAL-- etc. modes by default when switching modes
M.initial_showmode = vim.o.showmode

-- Color scheme auto toggle (light/dark) defaults
M.color_toggle_default = {
   ["light"] = "default", -- default light color scheme
   ["dark"] = "default", -- default dark color scheme
   light_scheme_starts_at = { hour = 08, min = 00 }, -- 24h format
   light_scheme_ends_at = { hour = 17, min = 00 }, -- 24h format
}

-- Current status of color toggle
M.color_toggle_current = M.color_toggle_default
M.color_toggle_current.light_scheme_set = false
M.color_toggle_current.dark_scheme_set = false
M.color_toggle_current.manual_set = false

return M
