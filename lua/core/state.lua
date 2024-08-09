-- Runtime state holder
local M = {}

-- Hardtime.nvim is disabled by default
M.hardtime_enabled = false

-- Displays --INSERT--/--VISUAL-- etc. modes by default when switching modes
M.initial_showmode = vim.o.showmode

-- Color scheme auto toggle (light/dark) defaults
M.color_toggle_default = {
   ["light"] = "delek", -- default light color scheme
   ["dark"] = "default", -- default dark color scheme
   light_scheme_starts_at = { hour = 8, min = 0 }, -- light color scheme starts (24h format)
   light_scheme_ends_at = { hour = 17, min = 0 }, -- light color scheme ends (24h format)
}

-- Current status of color toggle
M.color_toggle_current = M.color_toggle_default
M.color_toggle_current.light_scheme_set = false
M.color_toggle_current.dark_scheme_set = false
M.color_toggle_current.manual_set = false

return M
