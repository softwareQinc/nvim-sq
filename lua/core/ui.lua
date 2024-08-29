-- UI-related functions

local M = {}

local state = require("core.state")

-- Set a light color scheme
function M.set_light_scheme(color_scheme)
   pcall(require, color_scheme)
   local status, _ = pcall(vim.cmd.colorscheme, color_scheme)
   if not status then
      print(
         "Color scheme '"
         .. color_scheme
         .. "' not found, switching to core.ui.color_toggle_default['light']: "
         .. state.color_toggle_default["light"]
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

   vim.o.background = "light"
   vim.cmd("hi! link SignColumn Normal")
   -- Update lualine (glitch when autocmd triggers)
   vim.defer_fn(function()
      require("lualine").setup({})
   end, 1)
end

-- Set a dark color scheme
function M.set_dark_scheme(color_scheme)
   pcall(require, color_scheme)
   local status, _ = pcall(vim.cmd.colorscheme, color_scheme)
   if not status then
      print(
         "Color scheme '"
         .. color_scheme
         .. "' not found, switching to core.ui.color_toggle_default['dark']: "
         .. state.color_toggle_default["dark"]
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

   vim.o.background = "dark"
   vim.cmd("hi! link SignColumn Normal")
   -- Update lualine (glitch when autocmd triggers)
   vim.defer_fn(function()
      require("lualine").setup({})
   end, 1)
end

-- Auto color scheme switch callback, used by AutoColorScheme group in
-- "lua/core/autocmds.lua"
function M.set_color_scheme_callback()
   local util = require("core.util")
   local current_time = util.get_time()
   if
       util.time_is_less_than_or_equal(state.color_toggle_current.light_scheme_starts_at, current_time)
       and util.time_is_greater_than(state.color_toggle_current.light_scheme_ends_at, current_time)
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

-- Set a light/dark color scheme automatically based on current time
-- Opts: {light_scheme_starts_at, light_scheme_ends_at, light_scheme_name, dark_scheme_name}
function M.set_auto_scheme(opts)
   if opts.light_scheme_starts_at == nil then
      state.color_toggle_current.light_scheme_starts_at = state.color_toggle_default.light_starts
   else
      state.color_toggle_current.light_scheme_starts_at = opts.light_scheme_starts_at
   end

   if opts.light_scheme_ends_at == nil then
      state.color_toggle_current.light_scheme_ends_at = state.color_toggle_default.light_scheme_ends_at
   else
      state.color_toggle_current.light_scheme_ends_at = opts.light_scheme_ends_at
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
   -- the AutoColorScheme ("lua/core/autocmds.lua") autocmd kicks in
   M.set_color_scheme_callback()
end

return M
