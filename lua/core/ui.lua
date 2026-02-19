-- UI-related functions

---@class CoreUI
local M = {}

local state = require("core.state")

--- Apply a light colorscheme and switch Neovim to light background
---@param color_scheme string Name of the colorscheme to load
function M.set_light_scheme(color_scheme)
   pcall(require, color_scheme)
   local status, _ = pcall(vim.cmd.colorscheme, color_scheme)
   if not status then
      vim.notify(
         "Color scheme '"
            .. color_scheme
            .. "' not found, switching to core.ui.color_toggle_default['light']: "
            .. state.color_toggle_default["light"],
         vim.log.levels.WARN,
         { title = "core.ui.set_light_scheme" }
      )

      pcall(vim.cmd.colorscheme, state.color_toggle_default["light"])
      state.color_toggle_current["light"] = state.color_toggle_default["light"]
   else -- update the color_toggle_current table
      state.color_toggle_current["light"] = color_scheme
   end

   -- We invoked set_light_scheme() manually, disable autocmd
   if state.color_toggle_current.manual_set then
      pcall(vim.api.nvim_clear_autocmds, { group = "AutoColorScheme" })
   end

   state.color_toggle_current.light_scheme_set = true
   state.color_toggle_current.dark_scheme_set = false

   vim.opt.background = "light"
   vim.api.nvim_set_hl(0, "SignColumn", { link = "Normal", default = false })
end

--- Apply a dark colorscheme and switch Neovim to dark background
---@param color_scheme string Name of the colorscheme to load
function M.set_dark_scheme(color_scheme)
   pcall(require, color_scheme)
   local status, _ = pcall(vim.cmd.colorscheme, color_scheme)
   if not status then
      vim.notify(
         "Color scheme '"
            .. color_scheme
            .. "' not found, switching to core.ui.color_toggle_default['dark']: "
            .. state.color_toggle_default["dark"],
         vim.log.levels.WARN,
         { title = "core.ui.set_dark_scheme" }
      )

      pcall(vim.cmd.colorscheme, state.color_toggle_default["dark"])
      state.color_toggle_current["dark"] = state.color_toggle_default["dark"]
   else -- update the color_toggle_current table
      state.color_toggle_current["dark"] = color_scheme
   end

   -- We invoked set_dark_scheme() manually, disable autocmd
   if state.color_toggle_current.manual_set then
      pcall(vim.api.nvim_clear_autocmds, { group = "AutoColorScheme" })
   end

   state.color_toggle_current.light_scheme_set = false
   state.color_toggle_current.dark_scheme_set = true

   vim.opt.background = "dark"
   vim.api.nvim_set_hl(0, "SignColumn", { link = "Normal", default = false })
end

--- Callback for automatic color scheme switching.
--- Used by the `AutoColorScheme` augroup in `lua/core/autocmds.lua`.
function M.set_color_scheme_callback()
   local util = require("core.util")
   local current_time = util.get_time()
   if
      util.time_is_less_than_or_equal(
         state.color_toggle_current.light_scheme_starts_at,
         current_time
      )
      and util.time_is_greater_than(
         state.color_toggle_current.light_scheme_ends_at,
         current_time
      )
   then
      -- Set light color scheme during daytime (if not already set)
      if not state.color_toggle_current.light_scheme_set then
         M.set_light_scheme(state.color_toggle_current["light"])
      end
   else
      -- Set dark color scheme during nighttime (if not already set)
      if not state.color_toggle_current.dark_scheme_set then
         M.set_dark_scheme(state.color_toggle_current["dark"])
      end
   end
end

---@class AutoSchemeOpts
---@field light_scheme_starts_at TimeOfDay
---@field light_scheme_ends_at   TimeOfDay
---@field light_scheme_name      string
---@field dark_scheme_name       string

--- Automatically set light or dark colorscheme based on current time
---@param opts AutoSchemeOpts Options controlling light/dark schemes and time ranges
function M.set_auto_scheme(opts)
   if opts.light_scheme_starts_at == nil then
      state.color_toggle_current.light_scheme_starts_at =
         state.color_toggle_default.light_scheme_starts_at
   else
      state.color_toggle_current.light_scheme_starts_at =
         opts.light_scheme_starts_at
   end

   if opts.light_scheme_ends_at == nil then
      state.color_toggle_current.light_scheme_ends_at =
         state.color_toggle_default.light_scheme_ends_at
   else
      state.color_toggle_current.light_scheme_ends_at =
         opts.light_scheme_ends_at
   end

   if opts.light_scheme_name == nil then
      state.color_toggle_current["light"] = state.color_toggle_default["light"]
   else
      state.color_toggle_current["light"] = opts.light_scheme_name
   end

   if opts.dark_scheme_name == nil then
      state.color_toggle_current["dark"] = state.color_toggle_default["dark"]
   else
      state.color_toggle_current["dark"] = opts.dark_scheme_name
   end

   -- Call it once, so we don't end up with defaults for a brief time before
   -- the auto command from the "AutoColorScheme" group in
   -- "lua/core/autocmds.lua" kicks in
   M.set_color_scheme_callback()
end

--- Apply or remove background transparency
---@param transparent boolean Whether transparency should be enabled
function M.set_background_transparency(transparent)
   if transparent == true then
      -- Set background to transparent while preserving other attributes
      for _, group in ipairs({
         "EndOfBuffer",
         "Normal",
         "NormalFloat",
         "NormalNC",
         "SignColumn",
         "WinBar",
         "WinBarNC",
      }) do
         local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
         hl.bg = nil
         hl.ctermbg = nil
         -- FIXME: When gruvbox fixes NormalFloat handling
         if not (vim.g.colors_name == "gruvbox" and group == "NormalFloat") then
            vim.api.nvim_set_hl(0, group, hl --[[@as vim.api.keyset.highlight]])
         end
      end
   else
      -- Restore scheme safely
      vim.cmd.colorscheme(vim.g.colors_name)
   end
end

return M
