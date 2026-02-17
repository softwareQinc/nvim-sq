---@type LazyPluginSpec
return {
   "folke/which-key.nvim",
   event = "VeryLazy",
   opts = {},
   keys = require("core.keymaps").which_key.keys,
}
