-- Runtime state holder

---@class TimeOfDay
---@field hour integer -- 0-23
---@field min  integer -- 0-59

---@class ColorToggleDefaults
---@field light string
---@field dark string
---@field light_scheme_starts_at TimeOfDay
---@field light_scheme_ends_at   TimeOfDay

---@class ColorToggleState: ColorToggleDefaults
---@field light_scheme_set boolean
---@field dark_scheme_set  boolean
---@field manual_set       boolean

---@class CoreState
---@field color_toggle_default ColorToggleDefaults
---@field color_toggle_current ColorToggleState
local M = {}

-- LSP format buffer on save is enabled by default at startup
M.lsp_format_on_save_enabled_at_startup = true

-- Hardtime.nvim hardtime mode is disabled by default at startup
-- NOTE: If enabled, you may want to set `showmode = false` in
-- `lua/core/options.lua` so the status mode does not overwrite Hardtime
-- messages while in Insert mode
M.hardtime_enabled_at_startup = false

-- Background transparency is disabled by default at startup
M.background_transparency_enabled_at_startup = false

-- Color scheme auto toggle (light/dark) defaults
M.color_toggle_default = {
   ["light"] = "default", -- default light color scheme
   ["dark"] = "default", -- default dark color scheme
   light_scheme_starts_at = { hour = 08, min = 00 }, -- 24h format
   light_scheme_ends_at = { hour = 17, min = 00 }, -- 24h format
}

-- Current status of color toggle
M.color_toggle_current =
   vim.tbl_extend("force", vim.deepcopy(M.color_toggle_default), {
      light_scheme_set = false,
      dark_scheme_set = false,
      manual_set = false,
   })

return M
