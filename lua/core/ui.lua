local M = {}

-- Color scheme auto toggle (light/dark) defaults, do not
M.color_toggle_default = {
   ["light"] = "delek", -- default light color scheme
   ["dark"] = "default", -- default dark color scheme
   light_scheme_starts_at = 8, -- light color scheme starts at this time (24h format)
   light_scheme_ends_at = 17, -- light color scheme ends at this time (24h format)
}

-- Current status of color toggle
M.color_toggle_current = {
   is_light_scheme = true,
   light_scheme_starts_at = M.color_toggle_default.light_starts,
   light_scheme_ends_at = M.color_toggle_default.light_scheme_ends_at,
   ["light"] = M.color_toggle_default["light"],
   ["dark"] = M.color_toggle_default["dark"],
}

-- Set a light color scheme
function M.set_light_scheme(color_scheme)
   vim.cmd.set("background=light")
   local status, _ = pcall(vim.cmd.colorscheme, color_scheme)
   if not status then
      print(
         "Color scheme '"
            .. color_scheme
            .. "' not found, switching to core.ui.color_toggle_default['light']: "
            .. M.color_toggle_default["light"]
      )
      pcall(vim.cmd.colorscheme, M.color_toggle_default["light"])
      M.color_toggle_current["light"] = M.color_toggle_default["light"]
   else -- update the color_toggle_current table
      M.color_toggle_current["light"] = color_scheme
   end
   M.color_toggle_current.is_light_scheme = true
end

-- Set a dark color scheme
function M.set_dark_scheme(color_scheme)
   vim.cmd.set("background=dark")
   local status, _ = pcall(vim.cmd.colorscheme, color_scheme)
   if not status then
      print(
         "Color scheme '"
            .. color_scheme
            .. "' not found, switching to core.ui.color_toggle_default['dark']: "
            .. M.color_toggle_default["dark"]
      )
      pcall(vim.cmd.colorscheme, M.color_toggle_default["dark"])
      M.color_toggle_current["dark"] = M.color_toggle_default["dark"]
   else -- update the color_toggle_current table
      M.color_toggle_current["dark"] = color_scheme
   end
   M.color_toggle_current.is_light_scheme = false
end

-- Set a light/dark color scheme automatically based on current time
-- Opts: {light_scheme_starts_at, light_scheme_ends_at, light_scheme_name, dark_scheme_name}
function M.set_auto_scheme(opts)
   if opts.light_scheme_starts_at == nil then
      M.color_toggle_current.light_scheme_starts_at = M.color_toggle_default.light_starts
   else
      M.color_toggle_current.light_scheme_starts_at = opts.light_starts
   end

   if opts.light_scheme_ends_at == nil then
      M.color_toggle_current.light_scheme_ends_at = M.color_toggle_default.light_scheme_ends_at
   else
      M.color_toggle_current.light_scheme_ends_at = opts.light_scheme_ends_at
   end

   if opts.light_scheme_name == nil then
      M.color_toggle_current["light"] = M.color_toggle_default["light"]
   else
      M.color_toggle_current["light"] = opts.light_scheme_name
   end

   if opts.dark_scheme_name == nil then
      M.color_toggle_current["dark"] = M.color_toggle_default["dark"]
   else
      M.color_toggle_current["dark"] = opts.dark_scheme_name
   end

   local current_time = os.date("*t")
   local current_hour = current_time.hour
   if current_hour >= opts.light_scheme_starts_at and current_hour < opts.light_scheme_ends_at then
      -- Set light color scheme during daytime
      M.set_light_scheme(M.color_toggle_current["light"])
   else
      -- Set dark color scheme during nighttime
      M.set_dark_scheme(M.color_toggle_current["dark"])
   end
end

return M
