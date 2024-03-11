local M = {}

-- Color scheme auto toggle (light/dark) defaults, do not
M.color_toggle_defaults = {
   light_starts = 8, -- daylight starts at 8AM
   light_ends = 17, -- daylight ends at 5PM
   ["light"] = "delek", -- default light theme
   ["dark"] = "darkblue", -- default dark theme
}

-- Current status of color toggle
M.color_toggle_current = {
   is_light_theme = true,
   light_starts = M.color_toggle_defaults.light_starts,
   light_ends = M.color_toggle_defaults.light_ends,
   ["light"] = M.color_toggle_defaults["light"],
   ["dark"] = M.color_toggle_defaults["dark"],
}

-- Sets a light color scheme
function M.set_light_theme(color_scheme)
   vim.cmd("set background=light")
   local status, _ = pcall(vim.cmd.colorscheme, color_scheme)
   if not status then
      print(
         "Color scheme '"
            .. color_scheme
            .. "' not found, switching to core.ui.color_toggle_defaults['light']: "
            .. M.color_toggle_defaults["light"]
      )
      M.color_toggle_current["light"] = M.color_toggle_defaults["light"]
      pcall(vim.cmd.colorscheme, M.color_toggle_current["light"])
   else -- update the color_toggle_current table
      M.color_toggle_current["light"] = color_scheme
   end
   M.color_toggle_current.is_light_theme = true
end

-- Sets a dark color scheme
function M.set_dark_theme(color_scheme)
   vim.cmd("set background=dark")
   local status, _ = pcall(vim.cmd.colorscheme, color_scheme)
   if not status then
      print(
         "Color scheme '"
            .. color_scheme
            .. "' not found, switching to core.ui.color_toggle_defaults['dark']: "
            .. M.color_toggle_defaults["dark"]
      )
      M.color_toggle_current["dark"] = M.color_toggle_defaults["dark"]
      pcall(vim.cmd.colorscheme, M.color_toggle_current["dark"])
   else -- update the color_toggle_current table
      M.color_toggle_current["dark"] = color_scheme
   end
   M.color_toggle_current.is_light_theme = false
end

-- Sets a light/dark theme automatically based on current time
-- Opts: {light_starts, light_ends, light_scheme, dark_scheme}
function M.set_auto_theme(opts)
   if opts.light_starts == nil then
      M.color_toggle_current.light_starts = M.color_toggle_defaults.light_starts
   else
      M.color_toggle_current.light_starts = opts.light_starts
   end

   if opts.light_ends == nil then
      M.color_toggle_current.light_ends = M.color_toggle_defaults.light_ends
   else
      M.color_toggle_current.light_ends = opts.light_ends
   end

   if opts.light_scheme == nil then
      M.color_toggle_current["light"] = M.color_toggle_defaults["light"]
   else
      M.color_toggle_current["light"] = opts.light_scheme
   end

   if opts.dark_scheme == nil then
      M.color_toggle_current["dark"] = M.color_toggle_defaults["dark"]
   else
      M.color_toggle_current["dark"] = opts.dark_scheme
   end

   local current_time = os.date("*t")
   local current_hour = current_time.hour
   if current_hour >= opts.light_starts and current_hour < opts.light_ends then
      -- Sets light theme during daytime
      M.set_light_theme(M.color_toggle_current["light"])
   else
      -- Sets dark theme during nighttime
      M.set_dark_theme(M.color_toggle_current["dark"])
   end
end

return M
