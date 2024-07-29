return {
   "m4xshen/hardtime.nvim",
   cmd = "Hardtime",
   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
   opts = {
      restricted_keys = {
         -- Remove the following restrictions
         ["j"] = {},
         ["k"] = {},
      },
      disable_mouse = false,
   },
}
