return {
   "m4xshen/hardtime.nvim",
   lazy = false,
   dependencies = { "MunifTanjim/nui.nvim" },
   opts = {
      restricted_keys = {
         -- Remove the following restrictions
         ["j"] = false,
         ["k"] = false,
      },
      disable_mouse = false,
   },
}
