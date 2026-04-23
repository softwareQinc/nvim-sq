---@type LazyPluginSpec
return {
   "windwp/nvim-autopairs",
   event = "VeryLazy",
   opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
   },
}
