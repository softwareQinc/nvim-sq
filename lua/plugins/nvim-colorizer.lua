---@type LazyPluginSpec
return {
   "catgoose/nvim-colorizer.lua",
   event = { "BufReadPre", "BufNewFile" },
   opts = {
      options = {
         parsers = {
            css = true, -- preset: enables names, hex, rgb, hsl, oklch
            tailwind = { enable = true, lsp = true, update_names = true },
         },
         -- display = {
         --    mode = "virtualtext",
         --    virtualtext = { position = "after" },
         -- },
      },
   },
}
