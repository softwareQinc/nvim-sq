---@type LazyPluginSpec
return {
   "ellisonleao/carbon-now.nvim",
   lazy = true,
   cmd = { "CarbonNow" },
   opts = {
      options = {
         theme = "one-light",
         titlebar = "",
         -- titlebar = "Made with carbon-now.nvim", -- default
      },
   },
}
