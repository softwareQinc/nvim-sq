---@type LazyPluginSpec
return {
   "hedyhli/outline.nvim",
   cmd = { "Outline", "OutlineOpen" },
   keys = require("core.keymaps").outline.keys,
   opts = {
      keymaps = {
         -- Do not close with <Esc>; press q instead
         close = "q",
      },
   },
}
