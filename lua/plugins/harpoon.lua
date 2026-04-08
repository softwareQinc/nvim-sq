---@type LazyPluginSpec
return {
   "ThePrimeagen/harpoon",
   dependencies = { "nvim-lua/plenary.nvim" },
   keys = require("core.keymaps").harpoon,
   branch = "harpoon2",
   config = true,
}
