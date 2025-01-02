return {
   "hedyhli/outline.nvim",
   lazy = true,
   cmd = { "Outline", "OutlineOpen" },
   keys = require("core.keymaps").outline.keys,
   opts = {
      keymaps = {
         -- Do not close by pressing <ESC>, only by pressing 'q'
         close = "q",
      },
   },
}
