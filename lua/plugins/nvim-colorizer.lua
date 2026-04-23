---@type LazyPluginSpec
return {
   "catgoose/nvim-colorizer.lua",
   event = { "BufReadPost", "BufNewFile" },
   opts = {
      filetypes = {
         "*", -- enable for all filetypes by default
         "!help", -- disable for 'help' (vim-doc) buffers
      },
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
