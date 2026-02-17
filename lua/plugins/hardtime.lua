---@type LazyPluginSpec
return {
   -- NOTE: If enabled, you may want to set `showmode = false` in
   -- `lua/core/options.lua` so the status mode does not overwrite Hardtime
   -- messages while in Insert mode
   "m4xshen/hardtime.nvim",
   lazy = false,
   dependencies = { "MunifTanjim/nui.nvim" },
   opts = {
      restricted_keys = {
         -- Allow j/k without hardtime restrictions
         ["j"] = false,
         ["k"] = false,
      },
      disable_mouse = false,
   },
}
