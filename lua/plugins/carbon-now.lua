---@type LazyPluginSpec
return {
   "ellisonleao/carbon-now.nvim",
   lazy = true,
   cmd = { "CarbonNow" },
   opts = {
      open_cmd = "open",
      options = {
         theme = "one-light",
         titlebar = "",
         -- titlebar = "Made with carbon-now.nvim", -- default
      },
   },
}
