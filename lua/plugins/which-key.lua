---@type LazyPluginSpec
return {
   "folke/which-key.nvim",
   event = "VeryLazy",
   opts = {}, -- lazy.nvim implicitly calls `setup({})`
   keys = require("core.keymaps").which_key.keys,
}
