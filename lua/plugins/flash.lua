---@type LazyPluginSpec
return {
   "folke/flash.nvim",
   event = "VeryLazy",
   opts = {},
   keys = require("core.keymaps").flash.keys,
}
